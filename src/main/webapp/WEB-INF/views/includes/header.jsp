<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">    
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>NAGAGU</title>
    <!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- alertify -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
	<!-- 메인 --> 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/main.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/header.css">
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" >
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
	<!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    
</head>

<div class="bg" id="wrapper" >
	<div class="nav-wrapper">
		<nav class="header_font navbar navbar-expand-lg navbar-dark w-100 container"> 
			<!-- Navbar content -->
			<a class="navbar-brand" href="/">
				<img src="<%=request.getContextPath()%>/resources/images/Main/NAGAGU2.png">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<div class="row w-50" style="padding-left: 5%;">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item">
							<a class="nav-link header_nav" id="header_cm" href="/community/list">COMMUNITY</a>
						</li>
						<li class="nav-item">
							<a class="nav-link header_nav" id="header_st" href="/store/entry">STORE</a>
						</li>
						<li class="nav-item">
							<a class="nav-link header_nav" id="header_cs" href="/custom/list">CUSTOM</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="header_util">
				<ul>
           			<sec:authorize access="isAnonymous()"> 
						<li>
							<img src="<%=request.getContextPath()%>/resources/images/Main/top_icon_mypage.png" 
								data-toggle="modal" data-target="#exampleModalCenter" aria-haspopup="true" aria-expanded="false" style="cursor: pointer;"/></li>
						<li>
							<img src="<%=request.getContextPath()%>/resources/images/Main/top_icon_cart.png" alt="" data-toggle="modal" data-target="#exampleModalCenter" style="cursor: pointer;"/>
						</li>
						<li>
							<a data-toggle="modal" data-target="#exampleModalCenter" class="btn_mypage" style="cursor: pointer;">MYPAGE</a>
						</li>
						<li style="color: white">
						<a href="/customLogin">Sign in</a></li>
           			</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li>
							<div class="dropdown">
								<img src="<%=request.getContextPath()%>/resources/images/Main/top_icon_mypage.png"/ style="width: 20px; height: 25px; cursor: pointer;">
								<div class="dropdown-content">
									<a href="#" class="sign" role="logout">로그아웃</a>
									<a href="/order/orderList">주문조회</a> 
									<a href="/mypage/edit">내정보수정</a> 
								</div>
							</div>
						</li>
						<li>
							<a href="/order/basketList">
								<img src="<%=request.getContextPath()%>/resources/images/Main/top_icon_cart.png" alt="" />
							</a>
						</li>
						<li>
							<a href="/mypage/like" style="cursor: pointer;">MYPAGE</a>
						</li>
						<li style="color: white">
						<a href="/customLogin">Sign out</a></li> 
           			</sec:authorize> 
				</ul>
			</div>
		</nav>
	</div>
<!-- 로그인 모달 -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered" role="document">
         <div class="modal-content mcontent">
             <div class="login-panel panel panel-default">
                 <div class="panel-heading">
                     <h3 class="panel-title">로그인 해주세요</h3>
                 </div>
                 <div class="panel-body">
                     <form method="post" role="login" action="/login" class="form-group">
                         <fieldset>
                             <div class="form-group">
                                 <input class="form-control" placeholder="userid" name="username" type="text" autofocus>
                             </div>
                             <div class="form-group">
                                 <input class="form-control" placeholder="Password" name="password" type="password" value="">
                             </div>
                             <div class="checkbox">
                                 <label>
                                     <input name="remember-me" type="checkbox">Remember Me
                                 </label>
                             </div>
                             <!-- Change this to a button or input when using this as a form -->
                             <a class="btn btn-lg btn-success sign btn-block" role="login">Login</a>
                         </fieldset>
                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                     </form>
                     <form role="logout" method="post" action="/customLogout" style="display:none;">
                            <fieldset>
                                <a class="btn btn-lg btn-success sign btn-block" role="logout">Logout</a>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                     </form>
                     <div class="d-flex">  
						<div class="col-md-4"><a href="/signup" class="sign-in-form-action-entry">회원가입</a></div>
						<div class="col-md-4"><a href="/FindMember" class="sign-in-form-action-entry">ID/PW 찾기</a></div>
					</div>
                 </div>
             </div>
         </div>
     </div> 
 </div>
		
<script>
$('.sign').on('click',function(e){
	e.preventDefault();
	console.log($(this).attr('role'));
	if($(this).attr('role')=='login'){
		$('form[role=login]').submit();
	}
	if($(this).attr('role')=='logout'){
		console.log('out')
		$('form[role=logout]').submit();
	}
})
</script>