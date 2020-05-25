<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp" %>

<link rel="stylesheet" href="/resources/css/mypage/like.css">
<%@include file="../mypage/common.jsp" %>

<div class="container container_like bg-light">
	<div class="d-flex tab_wrap">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link active" id="picTab"
				data-toggle="tab" href="#home" role="tab" aria-controls="home"
				aria-selected="true">LIKE</a></li>
		</ul>
	</div>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active row text-center" id="picOutput"
				role="tabpanel" aria-labelledby="picTab">
				<!-- 사진 뿌려지는 장소 -->
			</div>
		</div>
</div>
	
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

var member_id = null;	
<sec:authorize access="isAuthenticated()">
member_id = '<sec:authentication property="principal.username"/>';
</sec:authorize>
if(member_id != null){
	member_id = member_id.replace('&#64;','@').replace('&#46;','.');	
} 
console.log(member_id);

$(document).ready(function() {
	$(document).ajaxSend(function(e,xhr,options){
		console.log(csrfHeaderName, csrfTokenValue);
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
});

	$(document).ready(function(){
		//사진 가져오기 함수 정의
		function getPics(event){
			if(member_id == null){
				return;
			}
			$.ajax({
				  url: "/community/getLikeList",
	              type: "POST",
	              data: {'like_member':member_id},
	              dataType:'json',
	              contentType:
	  				'application/x-www-form-urlencoded; charset=utf-8',
	              success: function (retVal) {
	            	  console.log(retVal);
	        			var output="";
	        			if(retVal.length==0){
	        				alertify.error('사진이 없습니다')
	        				return
	        			}
			        	for(var j=0; j<retVal.length; j++){
			        		var imgsrc = retVal[j].MAINIMAGE
			        		console.log(imgsrc)
			        		output += '<div class="col-3 picOutput">'
				        	output += '<a href="/community/get?bno='+retVal[j].BNO+'">'
				    		output += '<img src="'+imgsrc+'"></div>';
			        	}
			        	$('#picOutput').html(output)
				 },
				error:function(){
					alert("ajax통신 실패!!");
				}
			})
		} 
		getPics();
		
		$('.card-wrap').children().eq(0).css('background-color','#ef900e').children().css('color','white');		
	})
</script>
