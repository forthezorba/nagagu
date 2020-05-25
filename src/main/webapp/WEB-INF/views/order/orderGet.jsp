<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	Date nowTime = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String num = request.getParameter("order_amount");
	
%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/Mypage/order_detail_.css">
<style type="text/css">
	.Precautions dl dd {
		font-size: 1rem;
	}
	
	#subject {
		font-size: 1.5rem;
	}
	
	.class-detail-container {
		padding: 0 15% 0 15% !important;
	}
	
	.hr-class {
		width: 100%;
		color: #f6f6f6;
		margin-top: 100px;
		margin-bottom: 100px;
	}
	
	.order-body {
		font-family: '만화진흥원체', 'KOMACON', KOMACON;
		font-size: 15px;
	}
	
	.sticky {
		padding-top: 2%;
		z-index:2;
		position: -webkit-sticky;
		position: sticky;
		background-color: #FFFFFF;
		top: 0;
	}
	
	.sticky2 {
		z-index:2;
		position: -webkit-sticky;
		position: sticky;
		background-color: #FFFFFF;
		top: 20px;
	}
	
	.nav-item .nav-link {
		color: #9d9d9d;
	}
	
	.comments_table {
		font-size: 1rem;
	}
	
	@media ( max-width : 700px) {
		.comments_table {
			font-size: 0.7rem;
		}
	}
	input#minus, input#plus {
		border-radius: 70px;
		width: 30px;
		margin: 0 10px;
		background-color: #1b1b27;
		color: white;
		border: none;
	}
	
	/* Reservation 부분 =====================================================   */
	
	/* Modal 부분 ===========================================================   */
	.reservation-container {
		margin-top: 100px;
		margin-bottom: 100px;
	}
	
	.solid {
		border: 2px solid #8C92A0;
	}
	
	#class_title {
		margin-top: 4%;
		font-size: 2em;
		font-weight: bolder;
	}
	
	#detail {
		margin-bottom: 3%;
	}
	
	#progress_time {
		font-weight: bolder;
		font-size: large;
		margin-bottom: 10px;
	}
	
	#calendar {
		color: green;
	}
	
	.center {
		text-align: center !important;
	}
	
	.nav-link.active {
		background-color: #EAEAEA !important;
	}
	
	.mbody {
		padding: 2rem !important;
	}
	
	.mheader {
		padding: 2rem !important;
	}
	
	.group {
		margin-top : 30px;
	}
	.main-output img{
		width : 100%;
		height: auto;
	}
	.brief,.basic_price{
		margin-top:20px;
	}
	.main-output {
		font-weight: 700;
		margin-top: 15px;
	}
	.each-row {
		margin-bottom: 15px;
		border-bottom: 1px solid black;
		border-color: rgba(0, 0, 0, 0.2);
	}
	.each-row img {
		width: 130px;
		height: 130px;
	}
	.each-row a, .each-row a:link, .each-row a:hover {
		text-decoration: none !important;
		color: black !important;
	}
    .category *{
        align-self: center;
        text-align: center;
        color: rgb(0, 0, 0, 0.6);  
    }
	 .basic_price, .shipPrice, .chongprice {
		margin-bottom: 0;
		margin-top: 10px;
	}
	.category{
		padding-bottom: 10px;
		padding-top: 10px;
		background-color: rgba(239,144,14,0.3);
	}.category *{
		align-items: baseline;
		text-align: center;
	}
	.values *{
		margin-top: 10px;
		text-align: center;
	}
	.amount,.basic_price{
		margin-top: 0;
	}
	.totalShipPrice,.totalPayPrice,.totalPrice{
		padding-right:25px !important;
	}
	.font_change{
		font-size:1.2rem !important; 
	}
</style>

<div class="container container-mypage bg-light">
	<div class="row justify-content-center pb-3">
	</div>

	<h4>
		<b>주문상세정보</b>
	</h4>
	<div>
		<div style="padding: 0 0 1% 0;">
			<b>주문번호 <span class="date_num"></span> / 주문날짜 <span class="date"></span></b>
		</div>
	</div>

	<div>
		<table class="table main-output">
		</table>
		<table class="table sub_output font_change">
			<colgroup>
				<col style="width:50%">
				<col style="width:50%">
			</colgroup>
		</table>
		<div class="col-12 row" style="padding-bottom:5%;">
			<div class="col-6">
				<a href="./index.ma" class="btn btn-outline-dark btn-lg w-100" role="button" aria-pressed="true">메인</a>
			</div>
			<div class="col-6">
				<a href="./order_list.my" class="btn btn-outline-dark btn-lg w-100" role="button" aria-pressed="true">목록</a>
			</div>
		</div>
	</div>		

</div>
		
<script>
	$(document).ready(function(){
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
			var num = <%=num%>
			console.log(num)
			var category = 'count'
			$.ajax({
				  url: "/NAGAGU/getPaidDetail.my",
	              type: "POST",
				  data: {'ORDER_AMOUNT':num},
	              contentType:
	  				'application/x-www-form-urlencoded; charset=utf-8',
	              success: function (retVal) {
	        		if(retVal.res=="OK"){
	        			var output="";
	        			var url = './productdetail.pro?PRODUCT_NUM='
        				var paidPrice=0;
			        	for(var j=0; j<retVal.myPaidOrder.length; j++){
		        			var price = retVal.myPaidOrder[j].PRODUCT_PRICE.toLocaleString();
			        		var ship = retVal.myPaidOrder[j].PRODUCT_SHIP_PRICE.toLocaleString();
			        		var chong = retVal.myPaidOrder[j].PRODUCT_PRICE+retVal.myPaidOrder[j].PRODUCT_SHIP_PRICE;
			        		var amount = retVal.myPaidOrder[j].BASKET_AMOUNT;
			        		var	total = chong*amount*1
			        			paidPrice += total;
				    		output += '<div class="col-12 row each-row" id="'+retVal.myPaidOrder[j].PRODUCT_NUM+'" bNum='+retVal.myPaidOrder[j].BASKET_NUM+'>'
	    					output += '<div class="col-2"><a href="'+url+retVal.myPaidOrder[j].PRODUCT_NUM+'">'
				    		output += '<img src="/productupload/image/'+retVal.myPaidOrder[j].PRODUCT_IMAGE+'"></a></div>'
				    		output += '<div class="col-10">'
			    				output += '<div class="row category">'
			    					output += '<div class="col-2">상품명</div>'
		    						output += '<div class="col-2">배송</div>'
			    					output += '<div class="col-2">사이즈</div>'
		    						output += '<div class="col-2">컬러</div>'
	    							output += '<div class="col-2">수량</div>'
    								output += '<div class="col-2 text-right">금액</div>'   
                                output += '</div>'
                              	output += '<div class="row values">' 
  			    					output += '<a href="'+url+retVal.myPaidOrder[j].PRODUCT_NUM+'">'
  			    					output += '<div class="col-2"><b>'+retVal.myPaidOrder[j].PRODUCT_TITLE+'</b></p>'
  				    					 output += '<p>'+retVal.myPaidOrder[j].PRODUCT_BRIEF+'</a></div>'
  				    				output += '<div class="col-2">'+retVal.myPaidOrder[j].PRODUCT_SHIP_COMPANY+'</div>'
  				    				output += '<div class="col-2">'+retVal.myPaidOrder[j].BASKET_SIZE+'</div>'
  				    				output += '<div class="col-2">'+retVal.myPaidOrder[j].BASKET_COLOR+'</div>'
  				    				output += '<div class="price col-2" value="'+retVal.myPaidOrder[j].BASKET_AMOUNT+'">'+retVal.myPaidOrder[j].BASKET_AMOUNT+'</div>'
  				    				output += '<div class="price_wrap text-right col-2">'
						    			output += '<div class="basic_price text-right" value='+retVal.myPaidOrder[j].PRODUCT_PRICE+'>가격</div><span>'+price+'원</span>'
						    			output += '<div class="shipPrice text-right" value='+retVal.myPaidOrder[j].PRODUCT_SHIP_PRICE+'>+배송비</div><span>'+ship+'원</span>'
					    				output += '<div class="chongprice text-right" style="font-size:1.2rem;">총가격</div><span style="font-size:1.2rem;">'+total.toLocaleString()+'원</span></b>' 
					    			output += '</div>'
			    				output += '</div></div></div>' 
			        	}  
	        			var d_date = new Date(retVal.myPaidOrder[0].ORDER_DATE); 
		        		var date = date_format(d_date);
		        		 
	        			var sub_output='';
	        				sub_output += '<tr><th class="text-left">주소</th><td width="200px;" >'+retVal.myPaidOrder[0].ORDER_ADDRESS+'</td></tr>'
        					sub_output += '<tr><th class="text-left">연락처</th><td>'+retVal.myPaidOrder[0].ORDER_PHONE+'</td></tr>'
        					sub_output += '<tr><th class="text-left">구매일자</th><td>'+date+'</td></tr>'
							sub_output += '<tr><th class="text-left">결제수단</th><td>'+retVal.myPaidOrder[0].ORDER_METHOD+'</td></tr>' 
							sub_output += '<tr><th class="text-left">결제금액</th><td>'+paidPrice.toLocaleString()+'원</td></tr>'
							sub_output += '<tr><th class="text-left">메모</th><td>'+retVal.myPaidOrder[0].ORDER_MEMO+'</td></tr>'
	      
			        	$('.main-output').html(output)
			        	$('.sub_output').append(sub_output) 
			        	$('.date').text(date)
			        	$('.date_num').text(retVal.myPaidOrder[0].ORDER_AMOUNT)
			        	$('.chongprice').css('color','rgba(239,144,14,1)');
 	        			$('.chongprice').next().css('color','rgba(239,144,14,1)');
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