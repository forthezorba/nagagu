<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/order/basketList.css">

<div class="container">
	<div class="basket_wrapper row justify-content-between">
		<div class="basketmain">
			<div class="d-flex">
				<div class="btn-group-toggle" data-toggle="buttons">
					<label
						class="btn btn-sm btn-outline-warning text-white radius btn_check_all">
						<i class="fas fa-check"></i> 
						<input type="checkbox" id="check_all" style="align-self: center;">
					</label>
				</div>
				<span class="check_count"><i>전체선택</i></span> <span></span>
			</div>
			
			<div class="row img-wrap main-output mt-2">
			</div>
		</div>
		<!-- main end -->

		<!-- sidebar start -->
		<div class="sidebar" id="sidebar">
			<div class="row justify-content-around text-right sidebarOutput">
				<div class="col-5 forcss">상품금액</div>
                <div class="col-7 forcss totalPrice"></div>
                <div class="col-5 forcss">+배송비</div>
                <div class="col-7 forcss totalShipPrice">+</div>
                <div class="col-12 line"></div>
                <div class="col-5 forcss" style="font-size:1.5rem;">결제금액</div>
                <div class="col-7 forcss totalPayPrice" style="font-size:1.5rem;"></div>
				<div class="">
					<a href="#" class="btn btn-secondary text-white btn_commit">구매하기</a> 
				</div>
			</div>
			<!-- side bar end -->
		</div>
		<!-- wrapper end -->
	</div>
</div>


<script>
//getbasket post방식으로 
var member = null;	
<sec:authorize access="isAuthenticated()">
	member = '<sec:authentication property="principal.username"/>';
</sec:authorize>
if(member != null){
	member = member.replace('&#64;','@').replace('&#46;','.');	
}

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
	$(document).ready(function(){
		
		//사진 가져오기 함수 정의
		function getBasket(event){
			var category = 'count'
			$.ajax({
				  url: "/order/getBasket",
	              type: "POST",
	              data: {basket_member:member,basket_check:0},
	              dataType: 'json',
  				  beforeSend: function(xhr){
  					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
  				  },
	              success: function (retVal) {
	        		if(retVal.res=="OK"){
	        			console.log(retVal.getbasketList)
	        			console.log(retVal.countBasket)
	        			var output="";
	        			var url = '/store/get?bno='
			        	for(var j=0; j<retVal.getbasketList.length; j++){
			        		var amount = retVal.getbasketList[j].BASKET_AMOUNT;
			        		output += '<div class="col-1 btn-group-toggle" data-toggle="buttons">'
							output +=	'<label class="btn btn-sm btn-outline-warning text-white radius btn_check">' 
								output += '<i class="fas fa-check"></i>'
								output += '<input class="checkbox" type="checkbox" basket_num="'+retVal.getbasketList[j].BASKET_NUM+'">'							
							output +=	'</label></div>'		
				    		//output += '<div class="col-11 row each-row" /* id="'+retVal.getbasketList[j].BASKET_PRODUCT+'" */ basket_num='+retVal.getbasketList[j].BASKET_NUM+'>'
				    		output += '<div class="col-11 row each-row" basket_num='+retVal.getbasketList[j].BASKET_NUM+'>'
				    			output += '<div class="col-2"><a href="'+url+retVal.getbasketList[j].BASKET_PRODUCT+'">'
				    			output += '<img src="'+retVal.getbasketList[j].MAINIMAGE+'"></a></div>'
				    			output += '<div class="col-10">'
				    				output += '<div class="row category bg-light">'
				    					output += '<div class="col-2">상품명</div>'
			    						output += '<div class="col-2">배송</div>'
				    					output += '<div class="col-2">사이즈</div>'
			    						output += '<div class="col-2">컬러</div>' 
		    							output += '<div class="col-1">수량</div>'   
	                                    output += '<div class="col-3 btn_wrap">'
		    							output += '<button class="btn btn-outline-light delete_btn" basket_num='+retVal.getbasketList[j].BASKET_NUM+'>삭제</button></div></div>'   
					    				
					    				output += '<div class="row values">' 
				    					output += '<a href="'+url+retVal.getbasketList[j].BNO+'">'
				    					output += '<div class="col-2">'+retVal.getbasketList[j].TITLE+'</a></div>'
					    				output += '<div class="col-2">'+retVal.getbasketList[j].SHIPCOMPANY+'</div>'
					    				output += '<div class="col-2" style="word-break:break-all">'+retVal.getbasketList[j].BASKET_SIZE+'</div>'
					    				output += '<div class="col-2">'+retVal.getbasketList[j].BASKET_COLOR+'</div>'
					    				output += '<div class="price col-1" value="수량">'
						    				output += '<select class="amount forTotal" name="basket_amount" size="1" basket_num='+retVal.getbasketList[j].BASKET_NUM+'>';
											output += '<c:forEach var="i" begin="1" end="10">';
											if(amount==${i}){
												output += '<option value="${i}" selected>${i}</option>';	
											}else{
												output += '<option value="${i}">${i}</option>';
											} 
											output += '</c:forEach></select></div>';
					    				output += '<div class="price_wrap text-right col-3">'
							    			output += '<div class="basic_price text-right" value='+retVal.getbasketList[j].PRICE+'>가격</div><span>'+retVal.getbasketList[j].PRICE+'</span>'
							    			output += '<div class="shipPrice text-right" value='+retVal.getbasketList[j].SHIPPRICE+'>+배송비</div><span>'+retVal.getbasketList[j].SHIPPRICE+'</span>'
						    				output += '<div class="chongprice text-right">총가격</div><span></span></b>'  
						    			output += '</div>'
					    				output += '</div></div></div>' 
			        	}  
	        			var countOutput= '전체선택 '+retVal.countBasket+'개';
	        			$('.check_count').text(countOutput);
			        	$('.main-output').html(output);
			        	changePrice();
					}else{ 
						alert("update fail"); 
					}  
				 },
				error:function(){
					alert("ajax통신 실패!!");
				}
			});//ajax
			
		}
	    
		//수량 변경시 가격 변경(update)
		$(document).on('change','.amount',function(){
			var basket_num = $(this).attr('basket_num')
			console.log(basket_num)
			var amount = $(this).val()
	 		$.ajax({
				  url: "/order/updateAmount",
	              type: "POST",
	              data: { 'basket_num' : basket_num, 'basket_amount' : amount},
	              dataType: 'json',
	              contentType:
	  				'application/x-www-form-urlencoded; charset=utf-8',
  				  beforeSend: function(xhr){
  					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
  				  }, 
	              success: function (retVal) {
	        		console.log(retVal);
				 },
				 error:function(){
						alert("ajax통신 실패!!");
				}
			})
			changePrice(this);
		}) 
		//가격변화
		function changePrice(data){
			if(data!=null){
				var amount =  $(data).val(); 
				var price =  $(data).parent().next().find('.basic_price').attr('value')
				var shipPrice = $(data).parent().next().find('.shipPrice').attr('value')
				//선택 수량 x 가격
				var changedPrice= amount*(price*1+shipPrice*1)
				$(data).parent().next().find('.chongprice').next().text(changedPrice.toLocaleString()).append('원') 
			}
			//처음에?
			else{ 
				$('.amount').each(function (index,item){
					var amount =  $(this).val() 
					var price =  $(this).parent().next().find('.basic_price').attr('value')
					var shipPrice = $(this).parent().next().find('.shipPrice').attr('value')
					//선택 수량 x 가격 
					var changedPrice= amount*(price*1+shipPrice*1)
					$(this).parent().next().find('.chongprice').next().text(changedPrice.toLocaleString()).append('원')
				})
				function changeComma(){
		            $('.basic_price').each(function (index,item){
		                var price = $(item).next().text()*1
		                $(item).next().text(price.toLocaleString()).append('원')    
		            })
		            $('.shipPrice').each(function (index,item){
		                var ship = $(item).next().text()*1
		                $(item).next().text(ship.toLocaleString()).append('원')    
		            })
		        }
				changeComma(); 
			}  
			//가격+배송비 구해서 총가격에 뿌리기
			getTotalPrice();
		};

		function getTotalPrice(){
			var sum_price=0;
			var sum_shipPrice=0;
			var sum_PayPrice=0;
			$('.forTotal').each(function (index,item){
				var amount =  $(item).val()
				var price = $(item).parent().next().find('.basic_price').attr('value')
				var shipPrice = $(item).parent().next().find('.shipPrice').attr('value')
				sum_price     += price*1*amount;
				sum_shipPrice += shipPrice*1*amount;
			}) 
			sum_PayPrice= sum_price*1+sum_shipPrice*1;
			$('.totalPrice').text(sum_price.toLocaleString()).append('원');
			$('.totalShipPrice').text(sum_shipPrice.toLocaleString()).append('원');
			$('.totalPayPrice').text(sum_PayPrice.toLocaleString()).append('원');
	 	}
		//전체선택
		$(document).on('click','#check_all',function(){
			var chk = $(this).is(":checked");//.attr('checked');
			console.log('sdf'+chk)
	        if(chk){
	        	$(".checkbox").prop('checked', true);
	        	$('.checkbox').parent().parent().next().find('select').addClass('forTotal');
	        	$('.checkbox').parent().addClass('active');
	        }else{
	        	$(".checkbox").prop('checked', false);
	        	$('.checkbox').parent().parent().next().find('select').removeClass('forTotal');
	        	$('.checkbox').parent().removeClass('active');
	        }
	        getTotalPrice();
		});
		//부분선택
	 	$(document).on('click','.checkbox',function(){
	 		//체크하면 나머지 체크박스에서 클래스 지우고 셀렉트한 것만 클래스 추가
			$('.checkbox').each(function (index,item){
				var chk = $(item).is(":checked");
				if(chk){
					$(item).parent().parent().next().find('select').addClass('forTotal');
				}else{
					$(item).parent().parent().next().find('select').removeClass('forTotal');
				}
			})
			getTotalPrice();
		}); 
		//누르면 장바구니에서 삭제
        $(document).on('click','.delete_btn',function(){
			var basket_num = $(this).attr('basket_num');
        	alertify.confirm('확인', '정말 삭제하시겠습니까?', function(){ 
    			console.log('basket_num='+basket_num)
				$.ajax({
					  url: "/order/deleteBasket",
		              type: "POST",
		              data: { 'basket_num' : basket_num},
		              dataType: 'json',
		              contentType:
		  				'application/x-www-form-urlencoded; charset=utf-8',
	  				  beforeSend: function(xhr){
	  					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	  				  }, 
		              success: function (retVal) {
		        		if(retVal.res=="OK"){
		        			alertify.success('Ok');
							getBasket();
							changePrice();
						}else{
							alert("update fail");
						}  
					 },
					error:function(){
						alert("ajax통신 실패!!");
					}
				})
   			}
            , function(){ 
            	alertify.error('Cancel')
            	}
            );
		});
		//셀렉트 한 값만 넘기기(구매하기 버튼)
	 	$(document).on('click','.btn_commit',function(){
	 		if(!$('.checkbox').is(":checked")){
	 			alertify.alert('확인','하나 이상 선택해주세요')
	 			return
	 		}
			var arrChecked = new Array();
			$('.checkbox').each(function (index,item){
				var chk = $(item).is(":checked");
				var basket_num = $(item).attr('basket_num');
				if(chk){
					arrChecked.push(basket_num);
				}
			});
				var category='order'
				var Data = { "arr": arrChecked,"category":category}; 
				$.ajax({ 
					type: "post", 
					url: "/order/updateCheck",
					dataType: "json", 
					data: Data, 
					beforeSend: function(xhr){
		  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		  			}, 
					success: function (data) { 
						var url = '/order/basketList2?basket_member='+member;
						location.href = url
					},
					error:function(){
						alert("ajax통신 실패!!");
					} 
				});
			});
		//처음 로드하고 사진 가져오기 호출
		getBasket();
	})
</script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<%@include file="../includes/footer.jsp" %>