<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp" %>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}
.uploadResult ul {
	display: flex;
	flex-flox: row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li {
	list-style: none;
	padding: 10px;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li img {
	width: 100px;
}

/* 상품 이미지 관련*/
.thumbMain img {
	max-width: 100%;
	width: 500px;
	height: 500px;
}
.thumbItem {
	width: 95px;
	height: 95px;
	overflow: hidden;
	margin-right: 6px;
	margin-bottom: 6px;
}
.thumbBorder{
	border: 2px solid #ef902e; 
	border-radius: 4px;
}
.thumbItem img {
	width: inherit;
}
.row_ship_info {
	padding:3px;
}   
#thumbLarge{
	width: inherit;
}
.sticky,.sticky2 {
   padding-top: 5%;
   z-index:2;
   position: -webkit-sticky;
   position: sticky;
   background-color: #FFFFFF;
   top: 0;
}
.sticky2 {
   top: 20px;
}
.sticky .nav-item .active {
	color : white !important;
	background-color : #1B1B27 !important;
}
@media screen and (max-width: 767px) {
	.sticky-wrapper {
	  display:none;
	}
}
li.nav-item a.nav-link {
    color: black;
}
.chat li{
	border-bottom: 1px solid #ddd;
}
</style>
<div class="container"> 
            <div class="row">
                <div class="col-lg-12">
                	<div class="panel-heading py-3">
                    <h3><a href="/store/list">STORE</a> > 상세보기 
                   		<!-- 작성자만 수정버튼 보이기 -->
                   		<div class="pull-right">
                       		<sec:authentication property="principal" var="pinfo"/>
                  			<sec:authorize access="isAuthenticated()">
	                  			<c:if test="${pinfo.username eq board.writer}">
	                  			<button data-oper='modify' class="btn btn-primary">수정</button>	
	                  			</c:if>
                  			</sec:authorize>
                       		<button data-oper='list' class="btn btn-primary">목록</button>
                       		<form id='operForm' action="/store/modify" method="get">
                       			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
                       			<input type='hidden' name='pageNum' value="${store_cri.pageNum}"/> 
				            	<input type='hidden' name='amount' value="${store_cri.amount}"/>
				            	<input type='hidden' name='keyword' value="${store_cri.keyword}"/>
				            	<input type='hidden' name='type' value="${store_cri.type}"/>
                       		</form> 
                       	</div>
                    </h3>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div> 
            <!-- 상품 베너/메인 이미지  -->
            <div class="row" role="order">
            	<div class="col-lg-7">
            	<div class="d-flex pt-4">
					<div class="thumbList">
						<div class="thumbItem">
							<img src="<c:out value="${board.mainImage}"/>">
						</div>
						<c:forTokens var="board" items="${board.banner}" delims=",">
						<div class="thumbItem">
							<img src="<c:out value="${fn:trim(board)}"/>">
						</div>
						</c:forTokens>
					</div>
					<div class="thumbMain">         
						<img src="<c:out value="${board.mainImage}"/>" data-toggle="modal" data-target="#imgModal" aria-haspopup="true" aria-expanded="false">      
					</div>
				</div>
            	</div>
            	<div class="col-lg-5">
            	<!-- 주문FORM  -->
            	<form name="goodsform" action="#" method="post" id="goodsform" class="goodsform">
					<div class="row pt-4 pl-4">
						<div class="col-3">
							<!-- <img src=""> -->
						</div>
						<hr>
						<div class="col-9">
							<h3 name="title">${board.title}</h3>
							<p name="workshopName">
								<font size="2">${board.workshopName}</font>
							</p>
						</div>
					</div>
					<div>
						<table class="table table-borderless">
							<thead>
								<tr>
									<th scope="col">가격</th>
									<th scope="col" value="${board.price}" name="price">
									${board.price}<span>원</span>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">배송비</th>
									<th value="${board.shipPrice}" name="shipPrice">${board.price}</th>
								</tr>
								<tr>
									<th scope="row">배송 기간</th>
									<td name="shipDays">${board.shipDays}</td>
								</tr>
								<tr>
									<th scope="row">색상선택</th>
									<td><select name="basket_color" size="1" class="pauseSale form-control">
											<option value="">선택</option>
											<c:forTokens var="color" items="${board.color}" delims=",">
												<option value="${fn:trim(color)}">${fn:trim(color)}</option>
											</c:forTokens>
									</select></td>
								</tr>
								<tr>
									<th scope="row">사이즈선택</th>
									<td><select name="basket_size" size="1"	class="form-control">
											<option value="">선택</option>
											<c:forTokens var="size" items="${board.allsize}" delims=",">
												<option value="${fn:trim(size)}">${fn:trim(size)}</option>
											</c:forTokens>
									</select></td>
								</tr>
								<tr>
									<th scope="row">수량</th>
									<td>
										<div>
										<select name="basket_amount" size="1" class="form-control">
											<c:forEach var="i" begin="1" end="10">
												<option value="${i}">${i}</option>
											</c:forEach>
										</select>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">총 합계금액</th>
									<td class="total"></td>
								</tr>
								<tr>  
									<td colspan="1">
									</td>
									<td colspan="2" style="display: contents;">
										<a href="#" class="pauseSale btn btn-outline-dark btn-lg basket_btn button" role="button" aria-pressed="true" id="basket_btn">장바구니</a>
										<a href="#" class="pauseSale btn btn-outline-dark btn-lg order_btn button"	role="button" aria-pressed="true" id="order_btn">바로구매</a>
									</td>
								</tr>
							</tbody> 
						</table>
					</div>
					<sec:authorize access="isAuthenticated()">
          				<input type='hidden' name="basket_member" value='<sec:authentication property="principal.username"/>' >
          				<input type='hidden' name="basket_memberNick" value='<sec:authentication property="principal.member.member_nick"/>' >
          			</sec:authorize>
          			<input type='hidden' name="basket_product" value="${board.bno}" >
				</form>
            	</div>
            </div>
            <!-- order row end -->
            
            <!-- info row start -->
          <div class="d-flex" style="padding: 15px 0;"> 
            	<div class="col-lg-8">
					<nav class="sticky" id="sticky">
						<ul class="nav nav-tabs nav-fill">
						   <li class="nav-item">
						      <a class="nav-link" href="#info"><h5>상품정보</h5></a>
						   </li>
						   <li class="nav-item">
						      <a class="nav-link" href="#deliver"><h5>배송/환불</h5></a>
						   </li>
						   <li class="nav-item">
						      <a class="nav-link" href="#review"><h5>리뷰</h5></a>
						   </li>
						</ul>
					</nav>
					<div class="detail">
						<div id="info">
							${board.content}
						</div>
						<!-- 상세 사진정보 끝 -->
			      
			            <!-- 배송 및 환불 시작 -->
			            <h3>배송 및 환불</h3> 
						<div id="deliver">
							<div class="row_ship_info">
						    	<h5>배송정보</h5>${board.shipInfo}
							</div>
							<div class="row_ship_info">
								<h5>배송정보</h5><br/>	반품 배송지 : ${board.shipReturnPlace}
							</div>
							<br/>
						</div>
						<div id="review">
						<%@include file="../store/review.jsp" %>
						</div>
					</div> 
            	</div>
            	<!-- 스티키 주문 창 -->
            	<div class="col-lg-4 sticky-wrapper">
	        	<div class="sticky2" style="border: 1px solid #EAEAEA;">
				</div>
			</div>
    	</div>
   	  	<!-- info row end -->
   	  	
</div>
<!-- end container -->
<script type="text/javascript" src="/resources/js/store/file.js"></script>
<script type="text/javascript" src="/resources/js/store/reply.js"></script>
<script type="text/javascript" src="/resources/js/store/basket.js"></script>
<script>
	var bnoValue='<c:out value="${board.bno}"/>';
	var replyer = $('input[name=basket_member]').val();
	var replyerNick = $('input[name=basket_memberNick]').val();

	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
		
	$(document).ready(function() {
		var operForm = $('#operForm');
		$("button[data-oper='modify']").on('click',function(e){
			operForm.attr('action','/store/modify').submit();
		})
		
		$("button[data-oper='list']").on('click',function(e){
			operForm.find('#bno').remove();
			operForm.attr('action','/store/list').submit();
		}) 
		
	}); 
	$(document).ready(function() {
		//배너 클릭시 테두리 추가
		var targetImg = $('.thumbItem')[0];
		$(targetImg).addClass('thumbBorder');
		//thumb클리하면 main이미지로
		$(document).delegate('.thumbItem', 'click', function() {
			var targetImg = '';
			$('.thumbItem').removeClass('thumbBorder');
			$(this).addClass('thumbBorder');
			
			targetImg = $(this).find('img').attr("src");
			var largeSrc = targetImg.replace('s_','');
			console.log(largeSrc);
			$('#thumbLarge').attr('src', largeSrc);
			$('.thumbMain img').css('opacity','0').stop().attr('src',largeSrc).animate({opacity:1},500);
		});
	});
	
	$(document).ready(function(){
		var status='<c:out value="${board.status}"/>';
		if(status != 0) {
			$('.pauseSale').addClass('disabled');
			$('.goodsform').find('td.total').text('품절된 상품').css('color', 'red')
		} else {
			$('.pauseSale').removeClass('disabled');
		}
		//스크롤스파이
		$('body').scrollspy({target:'.sticky', offset:20});
		//써머노트 이미지
		$('#info img').removeAttr("style").css('width','100%');
		$('#deliver img').removeAttr("style").css('width','100%');
	}) 
	
	
</script>
<script type="text/javascript" src="/resources/js/store/get.js"></script>
<!-- include summernote css/js -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<%@include file="../includes/footer.jsp" %>
        