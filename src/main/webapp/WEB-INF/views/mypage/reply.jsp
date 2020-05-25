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
				aria-selected="true">REPLY</a></li>
		</ul>
	</div>
	<div class="tab-content" id="myTabContent">
		<!-- 댓글 뿌려지는 장소 -->
		<ul class="replyOutput chat">
		</ul>
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
	var replyUL = $('.replyOutput');
	showList();
	function showList(){
		getList({replyer:member_id}, function(list){
			console.log(list)
			var str='';
			if(list==null || list.length == 0){
				replyUL.html("");
				return;
			}
			for(var i=0, len=list.length||0; i<len; i++){
				str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str += "	<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
				str += "		<small class='pull-right text-muted'>"+displayTime(list[i].replyDate)+"</small></div>";
				str += "		<p>"+list[i].reply+"</p></div></li>";
			}
			replyUL.html(str);
		});
	}
	function getList(param, callback, error){
		console.log('reply_js...'+param.replyer);
		$.getJSON("/community/getListByReplyer?replyer="+param.replyer+"",
			function(data){
			console.log(data);
				if(callback){
					callback(data);
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
			});
	}
	function displayTime(timeValue){
		var today=new Date();
		var gap = today.getTime() - timeValue;
		var dateObj= new Date(timeValue);
		var str = '';
		if(gap<(1000*60*60*24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			return [(hh > 9 ? '': '0') + hh, ':',(mi>9? '': '0')+mi,':', (ss>9 ? '':'0') + ss].join('');
		}else{
			var yy = dateObj.getHours();
			var mm = dateObj.getMonth()+1;
			var dd = dateObj.getDate();
			return [yy, '/', (mm > 9 ? '': '0') + mm, '/', (dd>9 ? '':'0') + dd].join('');
		}
	}
	$('.card-wrap').children().eq(4).css('background-color','#ef900e').children().css('color','white');
})
</script>