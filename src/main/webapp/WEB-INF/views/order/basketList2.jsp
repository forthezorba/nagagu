<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp"%>

<%
	ArrayList<Map<String, Object>> basketList = (ArrayList<Map<String, Object>>) request
			.getAttribute("getbasketList");
	int TOTAL_PRICE = 0;
%>
<style type="text/css">
.basket-size {
	width: 100px;
	height: 100px;
}

.nav-link.active {
	background-color: #EAEAEA !important;
}

.radius {
	border-radius: 10px;
}

.order-container {
	margin-top: 30px;
	margin-bottom: 100px;
}

.nav-link.active {
	background-color: #EAEAEA !important;
}

td dl div {
	text-align: right;
}

.second-container .table {
	font-weight: 600;
}
</style>

<div class="container order-container">

	<div class="second-container">
		<div>
			<h3>주문/결제</h3>
			<br />
			<br />
			<h5 style="padding-bottom: 2%;">주문상품</h5>
		</div>
		<table class="table table-hover">
			<%
				for (int i = 0; i < basketList.size(); i++) {
					Map<String, Object> list = basketList.get(i);
			%>
			<form class="basketForm">
				<tr>
					<td align="center"><img class="basket-size"
						src="<%=list.get("MAINIMAGE")%>"> 
						<input type="hidden" class="basket_num" name="order_num"
						value="<%=list.get("BASKET_NUM")%>"> 
						<input type="hidden" name="order_amount" value="<%=list.get("BASKET_AMOUNT")%>">
						<%-- <input type="hidden" name="order_price" value="<%=list.get("PRICE")%>"> --%>
						<input type="hidden" name="order_product" value="<%=list.get("BASKET_PRODUCT")%>"></td>
						<input type="hidden"  name="order_size" value="<%=list.get("BASKET_SIZE")%>"></td>
						<input type="hidden"  name="order_color" value="<%=list.get("BASKET_COLOR")%>"></td>
					<td colspan="2">
						<dl>
							<dd><%=list.get("TITLE")%></dd>
							<dd>
								사이즈 :
								<%=list.get("BASKET_SIZE")%>
								| 컬러 :
								<%=list.get("BASKET_COLOR")%></dd>
						</dl>
					</td>
					<td>
						<dl>
							<div>
								<span>가격</span> <span class="text-center price"><%=list.get("PRICE")%></span>
							</div>
							<div>
								<span>+배송비</span> <span class="text-center ship"><%=list.get("SHIPPRICE")%></span>
							</div>
							<div>
								<span>수량 X</span><span class="text-center amount"><%=list.get("BASKET_AMOUNT")%></span>
							</div>
							<div>
								<span style="font-size: 1.2rem;">총가격</span> <span
									class="text-center chongPrice" style="font-size: 1.2rem;"></span>
							</div>
						</dl>
					</td>
					<td>
						<button type="button" class="btn btn-outline-dark delete_btn"
							value="<%=list.get("BASKET_NUM")%>">삭제</button>
					</td>
				</tr>
			</form>
			<%
				}
			%>
		</table>
		<hr>
		<div>
			<div class="row">
				<div class="col-2">
					<h5 style="padding-top: 2%;">주문자</h5>
				</div>
			</div>
			<hr>

			<div class="form-group row">
				<div class="col-2">
					<label for="inputAddress">이름</label>
				</div>
				<div class="col-5">
					<sec:authorize access="isAuthenticated()">
						<input type="text" class="form-control name"
							value="<sec:authentication property="principal.member.member_name"/>">
					</sec:authorize>
				</div>
				<div class="col-5"></div>
			</div>
			<div class="form-group row">
				<div class="col-2">
					<label for="inputAddress">우편번호</label>
				</div>
				<div class="col-3">
					<sec:authorize access="isAuthenticated()">
						<input type="text" class="form-control address_zip"
							value="<sec:authentication property="principal.member.address_zip"/>">
					</sec:authorize>
				</div>
				<div class="col-7"></div>
			</div>
			<div class="form-group row">
				<div class="col-2">
					<label for="inputAddress">주소</label>
				</div>
				<div class="col-10">
					<sec:authorize access="isAuthenticated()">
						<input type="text" class="form-control address1"
							value="<sec:authentication property="principal.member.address_address1"/>">
					</sec:authorize>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-2"></div>
				<div class="col-10 input-group">
					<sec:authorize access="isAuthenticated()">
						<input type="text" class="form-control address2"
							value="<sec:authentication property="principal.member.address_address2"/>">
					</sec:authorize>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-2">
					<label for="inputAddress">휴대전화</label>
				</div>
				<div class="col-5">
					<sec:authorize access="isAuthenticated()">
						<input type="text" class="form-control phone"
							value="<sec:authentication property="principal.member.member_phone"/>">
					</sec:authorize>
				</div>
				<div class="col-5"></div>
			</div>
		</div>

		<form id='orderForm'>
			<div style="padding: 0 0 5% 0;">
				<div class="row mt-5">
					<div class="col-2">
						<h5 style="padding-top: 2%;">배송지</h5>
					</div>
					<div class="col-10">
						<button type="button" id="getInfo_btn"
							class="btn btn-outline-dark">
							<font size="2">주문자 정보와 동일하게 채우기
						</button>
					</div>
				</div>
				<hr>
				<div class="form-group row">
					<div class="col-2">
						<label for="inputAddress">받는분</label>
					</div>
					<div class="col-5">
						<input type="text" class="form-control toName" name="order_name">
					</div>
					<div class="col-5"></div>
				</div>
				<div class="form-group row">
					<div class="col-2">
						<label for="inputAddress">우편번호</label>
					</div>
					<div class="col-3">
						<input type="text" id="postcode" class="txtInp form-control toZip"
							readonly />
					</div>
					<div class="col-2">
						<input type="button" onclick="execDaumPostcode()" value="주소검색"
							class="btn btn-outline-dark">
					</div>
					<div class="col-5"></div>
				</div>
				<div class="form-group row">
					<div class="col-2">
						<label for="inputAddress">주소</label>
					</div>
					<div class="col-10 input-group">
						<input id="address" class="txtInp form-control toAddress1"
							readonly /> &nbsp;
					</div>
				</div>
				<div class="form-group row">
					<div class="col-2"></div>
					<div class="col-10 input-group">
						<input id="detailAddress" class="txtInp form-control toAddress2"
							placeholder="상세 주소를 입력해주세요." /> <input id="extraAddress"
							type="hidden" placeholder="참고항목">
					</div>
				</div>
				<div class="form-group row">
					<div class="col-2">
						<label for="inputAddress">휴대전화</label>
					</div>
					<div class="col-5">
						<input type="text" class="form-control toPhone" name="order_phone">
					</div>
					<div class="col-5"></div>
				</div>
				<div class="form-group row">
					<div class="col-2">
						<label for="inputAddress">배송 메모</label>
					</div>
					<div class="col-10 input-group">
						<input type="text" class="form-control memo" name="order_memo">
					</div>
				</div>
			</div>
		</form>
		<div>
			<div class="row">
				<div class="col-4">
					<h5 style="padding-top: 2%;">최종 결제 금액</h5>
				</div>
				<div class="col-8"></div>
			</div>
			<hr>
			<div class="row" style="font-size: 24px; padding-bottom: 1%;">
				<div class="col-2">총 상품 금액</div>
				<div class="col-8"></div>
				<div class="col-2 d-flex justify-content-end totalPrice"></div>
			</div>
			<div class="row" style="font-size: 20px; padding-bottom: 1%;">
				<div class="col-2">+ 배송비</div>
				<div class="col-8"></div>
				<div class="col-2 d-flex justify-content-end totalShipPrice">
				</div>
			</div>
			<div class="row" style="font-size: 30px; padding-bottom: 1%;">
				<div class="col-4"></div>
				<div class="col-8 d-flex justify-content-end totalPayPrice"></div>
			</div>
		</div>
		<div>
			<div class="row mt-3">
				<div class="col-4">
					<h5 style="padding-top: 2%;">결제 수단</h5>
				</div>
				<div class="col-8"></div>
			</div>
			<hr>
			<div>
				<ul class="nav nav-pills mb-3 table table-bordered" id="pills-tab"
					role="tablist">
					<li class="nav-item"><a class="nav-link pay_method"
						value="toss" id="pills-toss-tab" data-toggle="pill"
						href="#pills-toss" role="tab" aria-controls="pills-home"
						aria-selected="true"> <label> <img width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/toss.png"
								alt="Toss">
								<div class="text-center">
									<font color="black">토스</font>
								</div>
						</label>
					</a></li>
					<li class="nav-item"><a class="nav-link pay_method"
						value="card" id="pills-card-tab" data-toggle="pill"
						href="#pills-card" role="tab" aria-controls="pills-home"
						aria-selected="true"> <label> <img width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/card.png"
								alt="Toss">
								<div class="text-center">
									<font color="black">카드</font>
								</div>
						</label>
					</a></li>
					<li class="nav-item"><a class="nav-link pay_method"
						value="kakao" id="pills-naver-tab" data-toggle="pill"
						href="#pills-naver" role="tab" aria-controls="pills-home"
						aria-selected="true"> <label> <img width="64"
								src="/resources/images/Mypage/kakao.png" alt="Toss">
								<div class="text-center">
									<font color="black">카카오페이</font>
								</div>
						</label>
					</a></li>
					<li class="nav-item"><a class="nav-link pay_method"
						value="payco" id="pills-vbank-tab" data-toggle="pill"
						href="#pills-vbank" role="tab" aria-controls="pills-home"
						aria-selected="true"> <label> <img width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/vbank.png"
								alt="Toss">
								<div class="text-center">
									<font color="black">페이코</font>
								</div>
						</label>
					</a></li>
					<li class="nav-item"><a class="nav-link pay_method"
						value="samsung" id="pills-phone-tab" data-toggle="pill"
						href="#pills-phone" role="tab" aria-controls="pills-home"
						aria-selected="true"> <label> <img width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/phone.png"
								alt="Toss">
								<div class="text-center">
									<font color="black">삼성페이</font>
								</div>
						</label>
					</a></li>
				</ul>
				<div class="col-12" style="padding-bottom: 5%;">
					<a class="btn btn-dark btn-lg text-white w-100 IMP_pay"
						role="button" aria-pressed="true">결제하기</a>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<!-- 우편번호 API -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
var member_id = null;	
<sec:authorize access="isAuthenticated()">
	member_id = '<sec:authentication property="principal.username"/>';
</sec:authorize>
if(member_id != null){
	member_id = member_id.replace('&#64;','@').replace('&#46;','.');	
}
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ready(function() {
	if($('.address_zip').val()==0){ 
		$('.address_zip').val('');
		$('.address1').val('');
		$('.address2').val('');
	}
});
	/* 우편번호 api */
	function execDaumPostcode() {
	    new daum.Postcode({
			oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	            
	            var themeObj = {
	                     searchBgColor: "#3498DB", //검색창 배경색
	                     queryTextColor: "#FFFFFF" //검색창 글자색
	            };
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("extraAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("extraAddress").value = '';
	            }
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("postcode").value = data.zonecode;
	            document.getElementById("address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailAddress").focus();
	        }
	    }).open();
	}

	$(document).ready(function(){
		//누르면 주문에서 삭제
        $(document).on('click','.delete_btn',function(){
            if(!confirm('삭제하시겠습니까?')){
                return
            }
			var basket_num = $(this).attr('value')
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
						var url = '/order/basketList2?basket_member='+member_id;
						location.href = url
					}else{
						alert("update fail");
					}  
				 },
				error:function(){
					alert("ajax통신 실패!!");
				}
			})
		});
		var totalPrice=0;
		var totalShipPrice=0;
		var totalPayPrice=0;
		
        var sum_PayPrice=0;	//총 결제금액
		function getTotalPrice(){
	 		//오른쪽 상품금액 + 배송비 + 결제금액 구해서 뿌리기
            var sum_price=0;
            var sum_shipPrice=0;

			$('.price').each(function (index,item){
                var amount =  $(item).parent().parent().find('.amount').text()
				var price = $(item).text()
                var shipPrice = $(item).parent().parent().find('.ship').text()
                chongPrice = (price*1+shipPrice*1)*amount*1
                $(this).parent().parent().find('.chongPrice').text(chongPrice.toLocaleString()).append('원');
                
                sum_price     += price*1*amount;
                sum_shipPrice += shipPrice*1*amount;
            }) 
            sum_PayPrice= sum_price*1+sum_shipPrice*1;
            $('.totalPrice').text(sum_price.toLocaleString()).append('원')
            $('.totalShipPrice').text('+'+sum_shipPrice.toLocaleString()).append('원')
            $('.totalPayPrice').text('총 결제금액 : '+sum_PayPrice.toLocaleString()).append('원')  
            console.log("sum_PayPrice : "+sum_PayPrice)
		}
        getTotalPrice();
        
        function changeComma(){ 
            $('.price').each(function (index,item){
                var price = $(item).text()*1
                $(item).text(price.toLocaleString()+'원')    
            })
			$('.ship').each(function (index,item){
                var ship = $(item).text()*1
                $(item).text(ship.toLocaleString()+'원')    
			})
	    }
	    changeComma();
 		
		//배송지 정보와 동일하게 채우기
		$(document).on('click','#getInfo_btn',function(){ 
			$('.toName').val($('.name').val())
			$('.toZip').val($('.address_zip').val())
			$('.toAddress1').val($('.address1').val())
			$('.toAddress2').val($('.address2').val())
			$('.toPhone').val($('.phone').val())
		});
		
		var card ='';
		$(document).on('click','.pay_method',function(){ 
			getPayMethod(this)
		})
		function getPayMethod(item){
			if($('.pay_method').hasClass('active')){
				card = $(item).attr('value')  
			}
		}
		
		$(document).on('click','.IMP_pay',function(){
			//유효성 검사
			if($('.toName').val()==''){
				alertify.alert('확인','이름을 채워주세요'); 
				return;
			}if($('.toZip').val()=='' || $('.toAddress1').val()=='' || $('.toAddress2').val()==''){
				alertify.alert('확인','주소를 채워주세요');
				return;
			}if($('.toPhone').val()==''){
				alertify.alert('확인','번호를 채워주세요');
				return;
			}if($('.pay_method.active').length==0){
				alertify.alert('확인','결제수단을 선택해주세요');
				return;
			}
			
			var order_address = $('.toZip').val()+'  ';
			order_address += $('.toAddress1').val()+'  ';
			order_address += $('.toAddress2').val();
			var orderStr = $('#orderForm').serialize();
				orderStr += '&order_address='+order_address;
			var IMP = window.IMP; // 생략가능
			IMP.init('imp41335180');  // 가맹점 식별 코드
			IMP.request_pay({
			   pg : 'html5_inicis', // 결제방식 
			   merchant_uid : new Date().getTime(),
			   name : 'NAGAGU 결제',	// order 테이블에 들어갈 주문명 혹은 주문 번호
			   amount : '100'	// 결제 금액
			}, function(rsp) {
				if ( rsp.success ){
					console.log(rsp);
					var order_id= rsp.merchant_uid;
					$('.basketForm').each(function (index,item){
						var basketStr = $(this).serialize();
						var params = basketStr+'&'+orderStr+'&order_price='+sum_PayPrice+'&order_id='+order_id+'&order_member='+member_id;
						$.ajax({
							  url: "/order/insertOrder", 
					             type: "POST",
				  				 beforeSend: function(xhr){
				  					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
				  				 }, 
					             data:params,
					             contentType:
					 				'application/x-www-form-urlencoded; charset=utf-8'
				 		}).done(function(retVal){
		             	    console.log(retVal)
		             	    location.href='/order/orderDetail'    
	              		}); 
					});
				}else{
				 	  //[3] 아직 제대로 결제가 되지 않았습니다.
				      //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
				}
			});
		});
	});
</script>
<%@include file="../includes/footer.jsp"%>