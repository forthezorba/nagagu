<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/order/orderList.css">  
<link rel="stylesheet" href="/resources/css/mypage/like.css">
<%@include file="../mypage/common.jsp" %> 

<div class="container my-5 bg-light">
	<div class="nav d-flex justify-content-between shadow p-3 mb5 bg-white rounded" id="nav-tab" role="tablist">
    	<a class="nav-item nav-link" status="0" id="nav-finish-tab" data-toggle="tab" href="#" role="tab" aria-controls="nav-profile" aria-selected="false">
    		<dl class="text-center">
    			<dt>결제완료</dt>
    			<dd></dd>
    			<dd class="count_paid"></dd>
    		</dl>
    	</a>
    	<div class="text-center align-self-center">
			<i class="far fa-arrow-alt-circle-right" style="font-size: 30px;"></i>
		</div>
    	<a class="nav-item nav-link" status="1" id="nav-ready-tab" data-toggle="tab" href="#" role="tab" aria-controls="nav-contact" aria-selected="false">
    		<dl class="text-center count_ready">
    			<dt>배송준비</dt>
    			<dd></dd>
    		</dl>
    	</a>
    	<div class="text-center align-self-center">
			<i class="far fa-arrow-alt-circle-right" style="font-size: 30px;"></i>
		</div>
		<a class="nav-item nav-link" status="2" id="nav-shipping-tab" data-toggle="tab" href="#" role="tab" aria-controls="nav-contact" aria-selected="false">
			<dl class="text-center">
    			<dt>배송중</dt>
    			<dd></dd>
    			<dd class="count_ing"></dd>
    		</dl>
		</a>
		<div class="text-center align-self-center">
			<i class="far fa-arrow-alt-circle-right" style="font-size: 30px;"></i>
		</div>
		<a class="nav-item nav-link" status="3" id="nav-completed-tab" data-toggle="tab" href="#" role="tab" aria-controls="nav-contact" aria-selected="false">
			<dl class="text-center">
    			<dt>배송완료</dt>
    			<dd></dd>
    			<dd class="count_ok"></dd>
    		</dl>
		</a>
		<div class="text-center align-self-center">
			<i class="far fa-arrow-alt-circle-right" style="font-size: 30px;"></i>
		</div>
		<a class="nav-item nav-link" status="4" id="nav-confirmation-tab" data-toggle="tab" href="#" role="tab" aria-controls="nav-contact" aria-selected="false">
			<dl class="text-center">
    			<dt>구매확정</dt>
    			<dd></dd>
    			<dd class="count_done"></dd>
    		</dl>
		</a>
	</div>
	<div class="tab-content main-output" id="nav-tabContent">
			<div class="flex output">
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
		$(document).ajaxSend(function(e,xhr,options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		//사진 가져오기 함수 정의
		function getBasket(status){
			var category = 'count';
			$.ajax({ 
				url: "/order/orderList/"+order_member+"/.json",
	              type: "POST",
	              async: false,
	              dataType: 'json',
	              contentType:
	  				'application/x-www-form-urlencoded; charset=utf-8',
	  				success: function (retVal) {
	  					console.log(retVal);
	  					if(retVal.res=="OK"){ 
  							//카운트(오더 목록을 받아서)
	  						if(retVal.cntOrder==0){
		        				alertify.error('주문이 없습니다')
		        				return
		        			}
  							$('.output').empty();
  							//주문id로 list받아오기
  							for(var i=0; i<retVal.cntGroupById.length; i++){
  								var order_id = retVal.cntGroupById[i].ORDER_ID;
  								$.ajax({
  									url: "/order/orderList/"+order_member+"/"+order_id+".json",
	  	  				            type: "POST",
	  	  				        	async: false,
  	  				            contentType:
  	  				  			'application/x-www-form-urlencoded; charset=utf-8',
 	  				            	success: function (data) {
 	  				            		if(retVal.res=="OK"){
  	  				            		var url = '/store/get?bno='; 
  	  				            		var d_date = new Date(data.orderListById[0].ORDER_DATE); 
  	  			        				var date = date_format(d_date);
  	  				            		var output ='';
  	  				            		//헤드  
  	  				            		output += '<div class="row col-12 tab-pane fade show active shadow mb-2 bg-white rounded" id="nav-waiting" role="tabpanel" aria-labelledby="nav-waiting-tab">'
  	  	  								output += '<div class="row col-12 justify-content-between order_tab">'
 	    				        			output += '<div><div><i style="font-size:0.7rem;">'+date+'</i></div>'
  	  	  									output += '<div><b>주문번호 '+data.orderListById[0].ORDER_ID+'</b></div></div>' 
 	    				        			output += '<div><a href="/order/orderDetail/'+data.orderListById[0].ORDER_ID+'">상세보기</a></div></div>'
  	  				            				
  	  				            		for(var j=0; j<data.orderListById.length; j++){
  	  				            		var price = data.orderListById[j].PRICE.toLocaleString();
						        		var ship = data.orderListById[j].SHIPPRICE.toLocaleString();
						        		var chong = data.orderListById[j].PRICE+data.orderListById[j].SHIPPRICE;
						        		var amount = data.orderListById[j].ORDER_AMOUNT;
						        		var	total = chong*amount*1
						        		//본문
						        		output += '<div class="col-12 d-flex each-row " id="'+data.orderListById[j].ORDER_PRODUCT+'" bNum='+data.orderListById[j].ORDER_NUM+'>'
				    					output += '<div class="col-2"><a href="'+url+data.orderListById[j].ORDER_PRODUCT+'">'
				    					output += '<img src="'+data.orderListById[j].MAINIMAGE+'"></a></div>'
							    		output += '<div class="col-10">'
						    				output += '<div class="row category bg-light">'
						    					output += '<div class="col-2">상품명</div>'
					    						output += '<div class="col-2">배송</div>'
						    					output += '<div class="col-2">사이즈</div>'
					    						output += '<div class="col-1">컬러</div>'
				    							output += '<div class="col-1">수량</div>'
			    								output += '<div class="col-2">상태</div>' 
			    								output += '<div class="col-2 text-right">금액</div>'   
			                                output += '</div>'
			                              	output += '<div class="row values">' 
			  			    					output += '<a href="'+url+data.orderListById[j].ORDER_PRODUCT+'">'
			  			    					output += '<div class="col-2"><b>'+data.orderListById[j].TITLE+'</b></a></div>'
			  				    				output += '<div class="col-2">'+data.orderListById[j].SHIPCOMPANY+'</div>'
			  				    				output += '<div class="col-2">'+data.orderListById[j].ORDER_SIZE+'</div>' 
			  				    				output += '<div class="col-1">'+data.orderListById[j].ORDER_COLOR+'</div>'
			  				    				output += '<div class="price col-1" value="'+data.orderListById[j].ORDER_AMOUNT+'">'+data.orderListById[j].ORDER_AMOUNT+'</div>' 
			  				    				output += '<div class="col-2">배송준비중</div>'
			  				    				output += '<div class="price_wrap text-right col-2">'
								    				output += '<div class="chongprice text-right">총가격</div><span>'+total.toLocaleString()+'원</span></b>'   
								    			output += '</div>';
						    				output += '</div></div></div>';
 	  				            		}
  	  	  								output += '<div class="end col-12"></div></div></div>' ;
	  	  					        	$('.output').append(output)  
  	  				            	}
  	  				            }
  								});
  							}
		  				}else{ 
							alert("update fail"); 
						}  
					},
					error:function(){
						alert("ajax통신 실패!!");
					}
			})
		}
		getBasket()
		$('.card-wrap').children().eq(3).css('background-color','#ef900e').children().css('color','white');  
	});
</script>
<%@include file="../includes/footer.jsp" %>