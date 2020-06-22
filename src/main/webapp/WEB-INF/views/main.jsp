<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="includes/header.jsp" %>
<%
	String message = (String)request.getAttribute("message");
%>
<style>
	section.scene {		
		height: 100vh;
		overflow: hidden;
		background-attachment: fixed;
		background-size: cover;
		font-weight: 10;
		color: black;
	}
	.scene.one {
		background-image:
			url("https://images.unsplash.com/photo-1520032484190-e5ef81d87978?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1955&q=80");			
	}
	.scene.two {
		background-color: rgba(0, 0, 0, 0.85);
		background-image:
			/* url("${pageContext.request.contextPath}/resources/images/Main/scene1.jpg"); */			 
	}
	.scene.three {
		background-image:
			url("${pageContext.request.contextPath}/resources/images/Main/scene3.jpg");
	}
	.scene.one header,.scene.two header, .scene.three header{
		color: rgba(255, 255, 255, 0.85);
	}
	header h1{
		margin-bottom: 30px;
	}
	.scene header {
		max-width: 50%; 
		position: relative; 
		left: 50%;
		top: 20%;
		transform: translateX(-50%) translateY(-50%);
		font-size: 1.5rem;
		text-align: center;				
	}			
	img {
		width: 100%;
		height: 100%;
	}
	
	.img-wrap img:hover { 
		transition: 0.5s; 
		opacity: 0.7;
		background-color: rgba(0,0,0,1);				
	}
	.img-wrap {
		top: 40%;
		position: relative; 
	}
	.img-wrap img{
		opacity: 0;
		height: 30vh;
	}
	.img-wrap .img-tag{
		background-color: rgba(0,0,0,0.5);			
	}			
	.img-wrap .caption {
		font-size: 2rem;
		/* background-color: rgba(0, 0, 0, 0.3); */
		top: 50%;
		left: 50%; 
		transform: translateX(-50%) translateY(-50%);
		font-size: 3rem !important;
		font-weight: 200;		
		color: rgba(255,255,255,0.65);		
		position: absolute;
		width: 100%;
	}			
	.scene.one .btn-wrap {
		position: absolute;  
		top:55%;
		left:35%;							
	}
	.scene.two .btn-wrap {
		position: absolute;  
		top:145%;
		left:47%;							
	}
</style>
<style>
body {
  text-align: center;
}
.js_rdmTxt {
  opacity: 0;
  margin-bottom: 32px;
  font-size: 10rem; 
  font-weight: bold;
  line-height: 1.3;
}
.js_rdmTxt.on {
  opacity: 1;
}
/* ---------------------------------------------------------------- */
.path-slider {
  display: inline-block;
  position: relative;
  top: 80%;
  transform: translateY(60%);
}

.path-slider path {
  stroke-width: 1px;
  /* stroke: none; */
  fill: none;
}

.icon__path {
  fill: #FFFFFF;
}

.path-slider__path {
  stroke: rgba(255, 255, 255, 0.5);
}

.path-slider__item {
  position: absolute;
  left: -37px;
  top: -37px;
  color: #FFFFFF;
  cursor: pointer;
  transform-origin: 50% 50%;
  text-decoration: none;
  outline: none;
}
.path-slider__item:hover .item__circle, .path-slider__item:focus .item__circle {
  background-color: #ef900e;
  transform: scale(1.2);
  transition: 0.5s;
}

.item__circle {
  display: inline-block;
  width: 74px;
  height: 74px;
  background-color: #ef900e;
  box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.5);
  border-radius: 100%;
  text-align: center;
  transition: 0.5s;
}

.item__title {
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  font-variant: small-caps;
  white-space: nowrap;
  opacity: 0.8;
  transition: 0.5s;
}

.item__icon {
  width: 45px;
  height: 45px;
  position: relative;
  top: 50%;
  transform: translateY(-50%);
}

.path-slider__current-item .item__circle {
  background-color: #ef900e;
  transform: scale(1.7);
}
.path-slider__current-item .item__title {
  font-size: 3rem !important;
  opacity: 1;
  transform: translate(-50%, -20px);
}


/* ---------------------------- */
.name_container {
  position: absolute;
  display: flex;
  width: auto;
  margin: auto;
  left: 0;
  right: 0;
  top: 8vh;
  text-align: center;
  align-items: center;
  justify-content: center;
  flex-wrap: wrap;
}
.name_container .pn {
  font-size: 25px;
  color: #666;
  text-transform: uppercase;
  padding-bottom: 4px;
  letter-spacing: 8px;
  padding-left: 8px;
  border-bottom: 3px solid #bbb;
}
.main a, .main a:hover,.container .path-slider a{
	text-decoration: none;
	color: white;
}
</style>
<div class="wrap" id="page-wrapper">
	<div class="main">
		<section class="scene two">
			<header> 
				<h1>COMMUNITY</h1>
				구경하고 뽐내고 싶은 사진이 있다면<br/>
				"커뮤니티" 메뉴에 사진을 올려보세요.<br/>
				좋아요 팔로우 등 다양한 사람들과 소통할 수 있습니다.</br> 
			</header>
			<!-- SVG icons -->		
			<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
			    <symbol id="cm" viewBox="0 0 100 100">
					<switch><foreignObject requiredExtensions="http://ns.adobe.com/AdobeIllustrator/10.0/" x="0" y="0" width="1" height="1"/><g i:extraneous="self"><g><path class="icon__path" d="M13.3,66.4L8.4,30.3c-0.4-2.7,1.5-5.1,4.2-5.5l51.8-7.1c0.2,0,0.5,0,0.7,0c2.4,0,4.5,1.8,4.8,4.2l0.4,3h5.9l-0.5-3.7     c-0.4-2.8-1.8-5.3-4.1-7.1c-2.3-1.7-5.1-2.5-7.9-2.1L11.8,19c-5.9,0.8-10,6.2-9.2,12.1l4.9,36.1c0.7,5.3,5.3,9.2,10.6,9.2h0.2     v-5.9C15.9,70.7,13.7,68.9,13.3,66.4z"/><path class="icon__path" d="M86.8,30.3H34.5c-5.9,0-10.7,4.8-10.7,10.7v36.4c0,5.9,4.8,10.7,10.7,10.7h52.3c5.9,0,10.7-4.8,10.7-10.7V41     C97.5,35.1,92.7,30.3,86.8,30.3z M34.5,36.1h52.3c2.7,0,4.8,2.2,4.8,4.8v30.6L76.2,53.9c-2.6-3-7.2-3-9.8,0L53.2,69.2l-4.8-5.3     c-2.4-2.7-6.6-2.7-9,0l-9.7,10.7V41C29.6,38.3,31.8,36.1,34.5,36.1z"/><circle cx="43.8" cy="49" r="5.8"/></g></g></switch>
			    </symbol>
			    
			    <symbol id="custom" viewBox="0 0 70 60">
			    	<path class="icon__path" d="M30,14.5A1.5,1.5,0,1,1,31.5,16,1.5,1.5,0,0,1,30,14.5ZM40.5,16A1.5,1.5,0,1,0,39,14.5,1.5,1.5,0,0,0,40.5,16Zm-5.639,8A9.334,9.334,0,0,0,39.5,22.863L38.5,21.137A7.439,7.439,0,0,1,34.861,22H33v2h1.861ZM18,30v3.293a7.226,7.226,0,0,1,.7-.2c2.283-.43,4.954-.931,7.115-1.331l1.288-.243c.152-.028.3-.054.436-.074a3.522,3.522,0,0,1,.357-.077l.3-.054c.2-.035.377-.067.539-.1L29,31.171v-.038a4.983,4.983,0,0,1-.86-1.552l-1.473-4.417A13,13,0,0,1,26,21.053V20a4,4,0,0,1,0-8,9.928,9.928,0,0,1,1.115-4.524A3.5,3.5,0,0,1,30,2h7.9A7.236,7.236,0,0,1,44.89,7.435,10.024,10.024,0,0,1,46,12a4,4,0,0,1,0,8v1.053a13,13,0,0,1-.667,4.111L43.86,29.581A4.983,4.983,0,0,1,43,31.133v.037L53.294,33.1A7,7,0,0,1,59,39.98V58a4,4,0,0,1-4,4H49a1.074,1.074,0,0,1-.212-.022L34.168,58.8,23.279,61.96A1.017,1.017,0,0,1,23,62H12a1,1,0,0,1-1-1V56H9a1,1,0,0,1-1-1V46a1,1,0,0,1,1-1h2V30H6a1,1,0,0,1-1-1V23a1,1,0,0,1,1-1H16a1.006,1.006,0,0,1,.555.168L19.3,24H23a1,1,0,0,1,1,1v4a1,1,0,0,1-1,1ZM46,18a2,2,0,0,0,0-4ZM26,14.005A2,2,0,1,0,26,18ZM16,56H13v4h3Zm14.067,1.908-4.279-.93L18.929,56H18v4h4.858ZM57,47.847l-4.844-.807-4.61,2.3L57,49.936Zm-10-3.97.779,3.115.221-.11V44h2v1.882l1.553-.777a1.017,1.017,0,0,1,.612-.091L57,45.82V39.98a5,5,0,0,0-4.074-4.918L47,33.953ZM43,33.2V43h2V33.579ZM37.766,4l1.8,3h3.059A5.238,5.238,0,0,0,37.9,4Zm-5,0,1.8,3h2.668l-1.8-3ZM28.5,5.5A1.5,1.5,0,0,0,30,7h2.234l-1.8-3H30A1.5,1.5,0,0,0,28.5,5.5ZM28,12.846l1.654,5.223a1.512,1.512,0,0,0,2.158.521,3.493,3.493,0,0,1,1.455-.554l1.784-5.352,1.9.632L35.387,18H38.24a3.5,3.5,0,0,1,1.948.59l.176.118a1.512,1.512,0,0,0,2.071-.385L44,12.859V12a8.024,8.024,0,0,0-.592-3H30a3.477,3.477,0,0,1-1.3-.255A7.937,7.937,0,0,0,28,12Zm2.037,16.1A3,3,0,0,0,32.883,31h6.234a3,3,0,0,0,2.846-2.052l1.473-4.417A11,11,0,0,0,44,21.053V19.571a3.512,3.512,0,0,1-4.746.8l-.177-.118A1.506,1.506,0,0,0,38.24,20H33.76a1.5,1.5,0,0,0-.838.254A3.512,3.512,0,0,1,28,19.2v1.854a11,11,0,0,0,.564,3.478ZM31,39.5V43h4V41.193l-1.444-3.61Zm1.478-3.608L31,34.414V37ZM36,38.308l1.071-2.679.005,0a.979.979,0,0,1,.217-.338l2.333-2.333a5.06,5.06,0,0,1-.509.04H32.883a5.037,5.037,0,0,1-.509-.04l2.333,2.333a.979.979,0,0,1,.217.338l.005,0ZM37,43h4V39.5l-2.556-1.917L37,41.193Zm4-6V34.414l-1.478,1.478ZM27,43h2V33.2c-.139.027-.283.054-.45.084l-.309.056c-.119.019-.227.046-.334.07-.2.032-.314.054-.433.076L27,33.579Zm-.946,4.909.211.106,6.475.4,13.007-.411.2-.1L45.219,45H26.781Zm-.5,1.986L19.764,47H10v7h9a.969.969,0,0,1,.142.01l7,1L49.107,60H55a2,2,0,0,0,2-2V51.939L25.938,50A1.029,1.029,0,0,1,25.553,49.9ZM16,45V30H13V45Zm2-9.589V45h2a1,1,0,0,1,.447.1L22,45.882V44h2v2.882l.221.111L25,43.877V33.953c-1.92.357-4.048.756-5.925,1.109A5.119,5.119,0,0,0,18,35.411ZM22,28V26H19a1.006,1.006,0,0,1-.555-.168L15.7,24H7v4H22Z"/>    	
			    </symbol>
			
			    <symbol id="academy" viewBox="0 0 100 100" >
			    		<path class="icon__path" d="M5.99915,90.5H94.00122a.9989.9989,0,0,1,.9989.9989V94.001a.999.999,0,0,1-.999.999H5.999a.9989.9989,0,0,1-.9989-.9989V91.499A.999.999,0,0,1,5.99915,90.5Z"/>
			    		<path class="icon__path" d="M6.01965,38H29.62158V23.73511H13.928a1.00489,1.00489,0,0,0-.84363.45886L5.16516,36.42908A1.01785,1.01785,0,0,0,6.01965,38Z"/>
			    		<path class="icon__path" d="M94.83508,36.42908,86.91577,24.194a1.00451,1.00451,0,0,0-.8435-.45886H70.37866V38H93.98059A1.01785,1.01785,0,0,0,94.83508,36.42908Z"/>
			    		<path class="icon__path" d="M70.00012,78.80005h20V41.6h-20Zm3-30.5a1.003,1.003,0,0,1,1-1h12a1.003,1.003,0,0,1,1,1v10a1.003,1.003,0,0,1-1,1h-12a1.003,1.003,0,0,1-1-1Zm0,16a1.003,1.003,0,0,1,1-1h12a1.003,1.003,0,0,1,1,1v10a1.003,1.003,0,0,1-1,1h-12a1.003,1.003,0,0,1-1-1Z"/>
			    		<path class="icon__path" d="M30.00012,41.6h-20V78.80005h20Zm-3,32.70007a1.003,1.003,0,0,1-1,1h-12a1.003,1.003,0,0,1-1-1v-10a1.003,1.003,0,0,1,1-1h12a1.003,1.003,0,0,1,1,1Zm0-16a1.003,1.003,0,0,1-1,1h-12a1.003,1.003,0,0,1-1-1v-10a1.003,1.003,0,0,1,1-1h12a1.003,1.003,0,0,1,1,1Z"/>
			    		<path class="icon__path" d="M55.60376,28.25H51.25012V22.89624A.3963.3963,0,0,0,50.85376,22.5H49.14648a.3963.3963,0,0,0-.39636.39624v7.45752a.3963.3963,0,0,0,.39636.39624h6.45728a.3963.3963,0,0,0,.39636-.39624V28.64624A.3963.3963,0,0,0,55.60376,28.25Z"/>
			    		<path class="icon__path" d="M66.40015,78.80005V12.2h-32.8v66.6001h6.4V60.45a10,10,0,0,1,20,0v18.3501Zm-16.4-39.3a10,10,0,1,1,10-10A10.00362,10.00362,0,0,1,50.00012,39.5Z"/>
			    		<rect x="30.00012" y="5" width="40" height="3.59998" rx="0.9989"/>
			    		<path class="icon__path" d="M9.00012,83.403v2.494A1.01582,1.01582,0,0,0,10.0282,86.9H89.97205a1.01582,1.01582,0,0,0,1.02807-1.003V83.403A1.01579,1.01579,0,0,0,89.97205,82.4H10.0282A1.01579,1.01579,0,0,0,9.00012,83.403Z"/>
			    </symbol>
			    <symbol id="store" viewBox="0 0 100 100">    	 		
					<g>
						<circle cx="41" cy="76" r="5"/>
						<circle cx="68" cy="76" r="5"/>
						<path class="icon__path" d="M24.68,23.03L29,56.35C29.07,62.24,33.88,67,39.78,67h29.76c4.74,0,8.88-3.04,10.31-7.62l5.77-20.44 c0.73-2.35,0.32-4.83-1.14-6.82S80.77,29,78.31,29H45h-6h-9.52l-0.84-6.5c-0.51-3.71-3.72-6.5-7.46-6.5H9c-1.1,0-2,0.9-2,2   s0.9,2,2,2h12.18C22.93,20,24.44,21.31,24.68,23.03z"/>
					</g>
			    </symbol>
			</svg>
			<div class="container">
			    <!-- Path Slider Container -->
			    <div class="path-slider">
			        <!-- SVG path to slide the items -->
			        <svg width="460px" height="510px" viewBox="0 0 460 510">
			            <path d="M 230 5 c -300 0 -300 300 0 300 c 300 0 300 -300 0 -300 Z" class="path-slider__path">
			            </path>
			        </svg>
			        <!-- Slider items -->
			        <a href="#cm" class="path-slider__item" id="cm_slider">
			            <div class="item__circle"><svg class="item__icon"><use xlink:href="#cm"/></svg></div>
			            <div class="item__title">COMMUNITY</div>   
			        </a>
			         <a href="#store" class="path-slider__item" id="store_slider">
			            <div class="item__circle"><svg class="item__icon"><use xlink:href="#store"/></svg></div>
			            <div class="item__title">STORE</div> 
			        </a>
			        <a href="#custom" class="path-slider__item" id="custom_slider">
			            <div class="item__circle"><svg class="item__icon"><use xlink:href="#custom"/></svg></div> 
			            <div class="item__title">CUSTOM</div> 
			        </a>
			        <div class="name_container">
			        	<a href="/community/list"><p class="pn">MORE</p></a>
			        </div>
			    </div>
			</div>
		</section>
	</div>
</div> 
<script src="https://unpkg.com/animejs@2.2.0/anime.min.js"></script>
<script src="https://gitcdn.xyz/repo/lmgonzalves/path-slider/master/dist/path-slider.min.js"></script>
<script>
	var alpData = [];
	function rdmAlp(tgt){
		var num = 10; 
		var org = $(tgt).text();
		var txt = org.split('');
		var chk = Array(txt.length).fill(0);
		chk[0] = 1;
		var action = setInterval(function(){
			var t = '';
			$(tgt).addClass('on');
			for(var i = 0; i < txt.length; i++){
				if(chk[i] > 0){
					if(chk[i] >= num){
						t += txt[i];
					}else{
						var n = Math.floor(Math.random() * alpData.length);
						t += alpData[n];
						chk[i] = chk[i] + 1;
					}
					if(chk[i] == Math.floor(num / 3 * 2)){
						chk[i + 1] = 1;
					}
				}
			}
			$(tgt).text(t);
			if(chk[txt.length - 1] >= num){
				$(tgt).text(org);
				clearInterval(action);
			}
		}, 40);
	}
	$(function(){
		'use strict';
		if($('.js_rdmTxt').length > 0){
			var key = 0;
			for(var i = 65; i <= 90; i++){
				alpData.push(String.fromCharCode(i));
			}
		}
	});
	$(document).ready(function(){
		// Setting up the options
	    var options = {
	        startLength: 0, // start positioning the slider items at the beginning of the SVG path
	        duration: 3000, // animation duration (used by anime.js)
	        stagger: 15, // incrementally delays among items, producing an staggering effect
	        easing: 'easeOutElastic', // easing function (used by anime.js)
	        elasticity: 600, // elasticity factor (used by anime.js)
	        rotate: true // This indicates that items should be rotated properly to match the SVG path curve
	    };

	    // Initialize the slider using our SVG path, items, and options
	    new PathSlider('.path-slider__path', '.path-slider__item', options);
	    
		setInterval(function(){rdmAlp('.js_rdmTxt')}, 3000);

		//NAGAGU LOGO실행
		$(document).on('click','#cm_slider',function(){
			$('.scene.two header').html('<h1>COMMUNITY</h1>구경하고 뽐내고 싶은 사진이 있다면<br/>"커뮤니티" 메뉴에 사진을 올려보세요.<br/>좋아요 팔로우 등 다양한 사람들과 소통할 수 있습니다.</br>');
			$('.name_container').html('<a href="/community/list"><p class="pn">MORE</p></a>')
		})
		$(document).on('click','#store_slider',function(){
			$('.scene.two header').html('<h1>STORE</h1>완성도와 퀄리티가 높은 수제가구를 사고싶다면 <br/>"STORE" 메뉴를 눌러보세요.<br/>공방을 운영하는 전문가들이 직접 만든 가구를 판매합니다.</br>');
			$('.name_container').html('<a href="/store/list"><p class="pn">MORE</p></a>')
		})
		$(document).on('click','#custom_slider',function(){
			$('.scene.two header').html('<h1>CUSTOM</h1>나의 상황에 꼭 맞는 가구를 "견적내보기" 메뉴에 올려보세요.<br/>최고의 전문가들이 모여 상담해주고 견적을 내줍니다.</br>');
			$('.name_container').html('<a href="/store/list"><p class="pn">MORE</p></a>')
		})

	})
</script>
<script>
	/* 탈퇴 처리 후 alert문으로 메시지 처리*/
	$(document).ready(function() {
		var responseMessage = "<c:out value="${message}" />";
		if (responseMessage != "") {
			alert(responseMessage);
		}
	});
</script>
<%@include file="includes/footer.jsp" %>