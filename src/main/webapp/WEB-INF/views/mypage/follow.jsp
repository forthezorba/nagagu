<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/mypage/other.css">
<style>
	/* card-size end */
	.followmain {
		width: 75%;
		height: 850px; 
	}.followmain img {
		width: 100%;
		max-height: 300px;
		height: auto; 
		margin-bottom:15px;
	}
	.img_wrap{
		font-size:1.5rem; 
	}.img_wrap img{
		width: 50px;
		height: 50px;
		border-radius: 100%;
	}
	
</style>

<div class="container" style="margin-top: 30px; margin-bottom: 30px;">
	<div class="wrapper row justify-content-between">
		<div class="col-10 nickNameTap">
			<div>
				<h6>
					<a href="/mypage/other?writer=${list[0].writer}">
					<b>${list[0].nick}</b> 님의 페이지</a>
				</h6>
			</div>
		</div>
		<div class="followmain p-0">
			<div class="pics-wrap">
				<div class="row justify-content-around title mx-0 pt-2 ">
					<div class="col-4 text-center">
						<h2>Following List</h2>
					</div>
					<div class="col-4 text-center">
						<h2>Followed List</h2>
					</div>
				</div>
				
				<div class="row justify-content-center title pt-2 img_wrap">
					<div class="col-6 text-center">
						<c:forEach var="item" items="${followList}">
							<div>
								<a href="/mypage/other?writer=${item.FOLLOW_TO}">
									<img src="${item.MEMBER_PICTURE}">
									<span>${item.MEMBER_NICK}</span>
								</a>
							</div> 
						</c:forEach>  
					</div>
					<div class="col-6 text-center">
						<c:forEach var="itemed" items="${followedList}"
							varStatus="status">
							<div>
								<a href="/mypage/other?writer=${itemed.FOLLOW_FROM}">
									<img src="${itemed.MEMBER_PICTURE}">
									<span>${itemed.MEMBER_NICK}</span>
								</a>
							</div>
						</c:forEach>
					</div>
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
						<div class="card-footer bg-transparent">Follow List</div>
					</div> 	
				</div>
			</div> 
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp" %>