<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/mypage/other.css">
<div class="container container-mypage">
	<div class="wrapper row justify-content-between">
		<div class="col-10 nickNameTap">
			<div>
				<h4>
					<a href="/mypage/other?writer=${list[0].writer}">
					<b>${list[0].nick}</b> 님의 페이지</a>
				</h4>
			</div>
		</div>
		
			<div class="othermain p-0">
				<div class="pics-wrap d-felx">
					<div class="row justify-content-between title mx-0 pt-2 ">
						<div class="col-4">
							<h2>사진</h2>
						</div>
						<div class="col-2 text-right">
							<a href="pic" class="more">more</a>
						</div> 
					</div>
					<div class="row justify-content-start img-wrap pics-img-wrap">  
						<c:forEach var="item" items="${list}" varStatus="sta" begin="0" end="2" step="1" >
		            		<div class="col-lg-4 img-wrap"> 
				               <a href="/community/get?bno=${item.bno}">
				                  <img src="${item.mainImage}"/>  
				               </a> 
			               </div> 
						</c:forEach> 
			    	</div> 
			    </div>
		    	<div class="like-wrap d-felx">
					<div class="row justify-content-between title mx-0 pt-2">
						<div class="col-4">
							<h2>LIKE</h2> 
						</div>
						<div class="col-2 text-right">
							<a href="like" class="more">more</a> 
						</div>
					</div>
					<div class="row justify-content-start img-wrap like-img-wrap">
						<c:forEach var="like" items="${likeList}" varStatus="vs" begin="0" end="2" step="1">
						    <div class="col-lg-4 img-wrap">
							    <a href="/community/get?bno=${like.BNO}">
									<img src="${like.MAINIMAGE}"/>
								</a>
							</div>   
						</c:forEach> 
					</div>
				</div>
			</div>
			
			<div class="sidebar">
				<div class="row justify-content-center mb-2"> 
					<div class="card-group text-center">
						<div class="card text-white bg-secondary" style="width: 10rem;">
							<div class="card-header">${list[0].nick}</div> 
							<div class="card-body"> 
								<img src="${list[0].writer_picture}"/>
							</div> 
							<a href="follow?writer=${list[0].writer}">
								<div class="card-footer bg-transparent">Follow List</div>
							</a>
						</div> 	
					</div>
				</div>
			</div>
		 
	</div>
</div>
<script>
var likeList='<c:out value="${likeList}"/>';
$('.more').on('click',function(e){
	e.preventDefault(); 
	var str='';
	if($(this).attr('href')=='pic'){
		str='<c:forEach var="item" items="${list}">';
		str+= '<div class="col-lg-4 img-wrap"><a href="/community/get?bno=${item.bno}">'
		str+= '<img src="${item.mainImage}"/>'
		str+= '</a></div></c:forEach>'
		$('.pics-img-wrap').html(str);
		$('.like-wrap').hide();
		$(this).hide();
		return;
	}
	if($(this).attr('href')=='like'){ 
		str='<c:forEach var="like" items="${likeList}">';
		str+= '<div class="col-lg-4 img-wrap"><a href="/community/get?bno=${like.BNO}">'
		str+= '<img src="${like.MAINIMAGE}"/>'
		str+= '</a></div></c:forEach>'
		$('.like-img-wrap').html(str);
		$('.pics-wrap').hide();
		$(this).hide();
		return;
	}
})


</script>
<%@include file="../includes/footer.jsp" %>