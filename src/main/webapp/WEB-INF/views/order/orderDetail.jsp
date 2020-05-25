<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="../includes/header.jsp"%>
<%
	Date nowTime = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<style>
.main-output {
	font-weight: 700;
	margin-top: 15px;
}
.each-row img {
	width: 150px;
	height: 150px;
}
.category{
	padding-bottom: 10px;
	padding-top: 10px;
}
.values *{
	margin-top: 10px;
	text-align: center;
}
.font_change{
	font-size:1.2rem !important; 
}
.price_wrap div{
	margin-top: 0px;
}
</style>
<div class="container my-5 text-center">
	<div class="">
		<font size="24;">구매완료</font> <br>
		<p>구매가 완료되었습니다</p>
	</div>
	<div>
		<table class="table main-output">
			
		</table>
		<table class="table sub_output font_change">
			<colgroup>
				<col style="width:40%">
				<col style="width:40%"> 
			</colgroup>
		</table>
		<div class="col-12 row" style="padding-bottom:5%;">
			<div class="col-6">
				<button data-oper='main' class="btn btn-outline-dark w-100">메인</button>
				<!-- <a href="/" class="btn btn-outline-dark btn-lg w-100" role="button" aria-pressed="true">메인</a> -->
			</div>
			<div class="col-6">
				<button data-oper='list' class="btn btn-outline-dark w-100">목록</button>
				<!-- <a href="/order/orderList" class="btn btn-outline-dark btn-lg w-100" role="button" aria-pressed="true">목록</a> --> 
			</div>
			<form id='operForm' action="/" method="get">
			</form>
		</div>
	</div>		 
</div>

<script>
var order_member = null;	
<sec:authorize access="isAuthenticated()">
order_member = '<sec:authentication property="principal.username"/>';
</sec:authorize>
if(order_member != null){
	order_member = order_member.replace('&#64;','@').replace('&#46;','.');	
} 
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

var order_id = "${order_id}";
console.log(order_id); 


$(document).ready(function(){
	
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	var operForm = $('#operForm');
	$("button[data-oper='main']").on('click',function(e){
		operForm.attr('action','/').submit();
	})
	$("button[data-oper='list']").on('click',function(e){
		operForm.attr('action','/store/list').submit();
	}) 
	
	/*날짜 형식 변경*/
	function date_format(format) {
	    var year = format.getFullYear();
	    var month = format.getMonth() + 1;
	    if(month<10) { 
	       month = '0' + month;
	    }
	    var date = format.getDate();
	    if(date<10) {
	       date = '0' + date;
	    }
	   return year + "-" + month + "-" + date + " " ;
	}
	//사진 가져오기 함수 정의
	function getBasket(event){ 
		var category = 'count'
		var check='';
		if(order_id==''){
			check =  "/order/orderList/"+order_member+"/.json";
		}else{
			check = "/order/orderList/"+order_member+"/"+order_id+".json";
		}
		
		$.ajax({
			  url: check,
              type: "post",
              dataType: 'json',
              contentType:
  				'application/x-www-form-urlencoded; charset=utf-8',
              success: function (retVal) {
            	  console.log(retVal);
        		if(retVal.res=="OK"){
        			console.log(retVal.cntOrder)
        			console.log(retVal.orderList)
        			//console.log(retVal.orderListById)
        			var output="";
        			var url = '/store/get?bno=';
       				
       				//가장 최근 주문만 보이게[0]
       				var cnt = '';
       				order_id==''? cnt=retVal.cntGroupById[0].COUNT:cnt=retVal.orderList.length
       				
		        	for(var j=0; j<cnt; j++){
		        		var price = retVal.orderList[j].PRICE.toLocaleString();
		        		var ship = retVal.orderList[j].SHIPPRICE.toLocaleString();
		        		var chong = retVal.orderList[j].PRICE+retVal.orderList[j].SHIPPRICE;
		        		var amount = retVal.orderList[j].ORDER_AMOUNT;
		        		var	total = chong*amount*1
		        		
			    		output += '<div class="col-12 row each-row" id="'+retVal.orderList[j].ORDER_PRODUCT+'" bNum='+retVal.orderList[j].ORDER_NUM+'>'
    					output += '<div class="col-2"><a href="'+url+retVal.orderList[j].ORDER_PRODUCT+'">'
			    		output += '<img src="'+retVal.orderList[j].MAINIMAGE+'"></a></div>'
			    		output += '<div class="col-10">'
		    				output += '<div class="row category bg-light">'
		    					output += '<div class="col-2">상품명</div>'
	    						output += '<div class="col-2">배송</div>'
		    					output += '<div class="col-2">사이즈</div>'
	    						output += '<div class="col-2">컬러</div>'
    							output += '<div class="col-2">수량</div>'
   								output += '<div class="col-2 text-right">금액</div>'   
                               output += '</div>'
                             	output += '<div class="row values">' 
 			    					output += '<a href="'+url+retVal.orderList[j].ORDER_PRODUCT+'">'
 			    					output += '<div class="col-2"><b>'+retVal.orderList[j].TITLE+'</b></a></div>'
 				    				output += '<div class="col-2">'+retVal.orderList[j].SHIPCOMPANY+'</div>'
 				    				output += '<div class="col-2">'+retVal.orderList[j].ORDER_SIZE+'</div>'
 				    				output += '<div class="col-2">'+retVal.orderList[j].ORDER_COLOR+'</div>'
 				    				output += '<div class="price col-2">'+retVal.orderList[j].ORDER_AMOUNT+'</div>'
 				    				output += '<div class="price_wrap text-right col-2">'
					    			output += '<div class="basic_price text-right" value='+retVal.orderList[j].PRICE+'>가격</div><span>'+price+'원</span>'
					    			output += '<div class="shipPrice text-right" value='+retVal.orderList[j].SHIPPRICE+'>+배송비</div><span>'+ship+'원</span>'
				    				output += '<div class="chongprice text-right" style="font-size:1.2rem;">총가격</div><span style="font-size:1.2rem;">'+total.toLocaleString()+'원</span></b>' 
				    			output += '</div>'
		    				output += '</div></div></div>' 
		        	}  
        			var d_date = new Date(retVal.orderList[0].ORDER_DATE); 
	        		var date = date_format(d_date);
	        		 
        			var sub_output='';
        				sub_output += '<tr><th class="text-left">주소</th><td width="200px;" >'+retVal.orderList[0].ORDER_ADDRESS+'</td></tr>'
       					sub_output += '<tr><th class="text-left">연락처</th><td>'+retVal.orderList[0].ORDER_PHONE+'</td></tr>'
       					sub_output += '<tr><th class="text-left">구매일자</th><td>'+date+'</td></tr>'
						sub_output += '<tr><th class="text-left">결제금액</th><td>'+retVal.orderList[0].ORDER_PRICE.toLocaleString()+'원</td></tr>'
						if(typeof retVal.orderList[0].ORDER_MEMO == 'undefined'){
							sub_output += '<tr><th class="text-left">메모</th><td></td></tr>'	
						}else{
							sub_output += '<tr><th class="text-left">메모</th><td>'+retVal.orderList[0].ORDER_MEMO+'</td></tr>'
						}
		        	$('.main-output').html(output);
		        	$('.sub_output').append(sub_output) ;
				}else{
					alert("update fail"); 
				}  
			 },
			error:function(){
				alert("ajax통신 실패!!");
			}
		}) 
	} 
	//처음 로드하고 사진 가져오기 호출
	getBasket()
});
</script>
<%@include file="../includes/footer.jsp"%>