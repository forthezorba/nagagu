<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/fontello/css/fontello.css">

<style>
	.main-content{
	   padding: 100px;
	}
	.main-content a,.main-content a:link,.main-content a:hover{
	  text-decoration: none !important;
	  color: black;
	}
	img {
	   max-width: 100%;
	   height: auto;
	}
	.col-md-4 {
	   border: 1px solid lightgray;
	}
	.fur_contents {
	   width:70%; 
	   margin:0 auto;
	} 
	.imoji{
	   font-family: "fontello" ;
	   font-size: 5rem ; 
	   color: black ;
	}
	.caption{
	   font-size:2rem ; 
	}
	div.col-md-4.wrap:hover {
		box-shadow: 0 1rem 3rem rgba(0,0,0,.175) !important;
	}
	.imoji img{
		width:70px; 
	}
</style>

<div class="container main-content category_st d-flex align-items-center">
	<div class="fur_contents text-center">
		<div class="row content">
			<div class="col-md-4 wrap">
				<a href="/store/list">
					<div class="imoji">&#xe808;</div>
					<div class="caption">전체</div>
				</a>
			</div>
			<div class="col-md-4 wrap">
				<a href="./productlist.pro?PRODUCT_CATEGORY=table">
					<div class="imoji">&#xe805;</div>
					<div class="caption">책상</div>
				</a>
			</div>
			<div class="col-md-4 wrap">
				<a href="./productlist.pro?PRODUCT_CATEGORY=chair">
					<div class="imoji">&#xe807;</div>
					<div class="caption">의자</div>
				</a>
			</div>
		</div>
		<div class="row content">
			<div class="col-md-4 wrap">
				<a href="./productlist.pro?PRODUCT_CATEGORY=bookshelf">
					<div class="imoji"><img src="https://cdn1.iconfinder.com/data/icons/furniture-line-modern-classy/512/bookshelf-512.png" ></div>
					<div class="caption">책장</div>
				</a>
			</div>
			<div class="col-md-4 wrap">
				<a href="./productlist.pro?PRODUCT_CATEGORY=bed">
					<div class="imoji">&#xe800;</div>
					<div class="caption">침대</div>
				</a>
			</div>
			<div class="col-md-4 wrap">
				<a href="./productlist.pro?PRODUCT_CATEGORY=drawer">
					<div class="imoji">&#xe806;</div>
					<div class="caption">서랍장</div>
				</a>
			</div>
		</div>
		<div class="row content">
			<div class="col-md-4 wrap">
				<a href="./productlist.pro?PRODUCT_CATEGORY=sidetable">
					<div class="imoji">&#xe801;</div>
					<div class="caption">협탁</div>
				</a>
			</div>
			<div class="col-md-4 wrap">
				<a href="./productlist.pro?PRODUCT_CATEGORY=sofa">
					<div class="imoji">&#xe804;</div>
					<div class="caption">화장대</div>
				</a>
			</div>
			<div class="col-md-4 wrap">
				<a href="./productlist.pro?PRODUCT_CATEGORY=others">
					<div class="imoji">&#xe803;</div>
					<div class="caption">기타</div>
				</a>
			</div>
		</div>
	</div>
</div>

<!-- Optional JavaScript -->
<%@include file="../includes/footer.jsp" %>