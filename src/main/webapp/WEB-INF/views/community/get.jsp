<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/community/get.css">
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
.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img{
width:600px;}
</style>
<div class="container">
            <div class="row my-4">
                <div class="col-lg-12">
                	<div class="panel-heading">
                    <h3><a href="/community/list">COMMUNITY</a> > 상세보기 </h3>
                    </div>
                </div> 
                <!-- /.col-lg-12 -->
            </div> 
            <!-- /.row -->
            <div class="row detailmain mb-5">
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-body">
                       		<div class="form-group">
                       			<label>제목</label><input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">
                       		</div>
                      		<div class="form-group d-flex">
                       			<div class="col-lg-2 pl-0"> 
                        			<label>카테고리</label>
									<input class="form-control" name="category" value='<c:out value="${board.category}"/>' readonly="readonly">
								</div> 
								<div class="col-lg-2 pr-0">	
									<label>후기/일반</label>
									<c:if test="${board.isReview == 1}">
										<input class="form-control" name="category" value='<c:out value="후기"/>' readonly="readonly">
									</c:if>
									<c:if test="${board.isReview == 2}">
										<input class="form-control" name="category" value='<c:out value="일반"/>' readonly="readonly">
									</c:if>
									 
								</div>
                       		</div>
                       		<div class="form-group">
                       			<label>내용</label> 
                       			<div class="form-control" name="content" style="height: auto;">
                       				${board.content}
                       			</div>
                       		</div>
                       		<div class="form-group">
                       			<label>글쓴이</label>
                       			<input class="form-control" name="nick" value='<c:out value="${board.nick}"/>' readonly="readonly">
                       		</div>
                       		<!-- 작성자만 수정버튼 보이기 -->
                       		<sec:authentication property="principal" var="pinfo"/>
                  			<sec:authorize access="isAuthenticated()">
	                  			<c:if test="${pinfo.username eq board.writer}">
	                  			<button data-oper='modify' class="btn btn-primary">수정</button>	
	                  			</c:if>
                  			</sec:authorize>
                       		<button data-oper='list' class="btn btn-primary">목록</button>
                       		<form id='operForm' action="/community/modify" method="get">
                       			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
                       			<input type='hidden' name='pageNum' value="${cri.pageNum}"/> 
				            	<input type='hidden' name='amount' value="${cri.amount}"/>
				            	<input type='hidden' name='keyword' value="${cri.keyword}"/>
				            	<input type='hidden' name='type' value="${cri.type}"/>
                       		</form> 
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
             
				<!-- sidebar start -->
	         	<div class="sidebar col-lg-4">
					<div class=" d-flex justify-content-between pb-2">
						<div class="profile-img">
							<a href="/mypage/other?writer=${board.writer}">
							<img src="${board.writer_picture}" style="width: 50px; height: 50px;" class="src"/>
							<b>${board.nick}</b> 
							</a>
							<button class="follow_btn flw_btn${board.writer}" id="${board.writer}">follow</button>
						</div> 
						<div>
							<a href="#" value="${board.bno}" class="likeBtn-wrap">
							<span class="button likeBtn" id="${board.bno}"  >  
								<i class="far fa-heart fa-2x" id="far"></i>
							</span>${board.likeCnt}
							</a>
						</div>
					</div>
					<div class="row member_upload_img" style="max-width:300px;">
		            	<c:forEach var="item" items="${pics}" varStatus="sta" begin="0" end="3" step="1" >
		            		<div class="col-6">   
				               <a href="/community/get?bno=${item.bno}"> 
				                  <img src="${item.mainImage}"/>  
				               </a> 
			               </div> 
						</c:forEach> 
	            	</div> 
	            	<div id="product_output"> 
	            	 	<div class="row product">
	            	 		<c:if test="${!empty product}"> 
							<div class="col-11 text-left product_text mx-3 px-0 pb-2">관련 상품</div>  
							 	<div class="col-5 pt-2">
								 	<a href="/store/get?bno=${product.bno}">
					    		 	<img src="${product.mainImage}"></a>
				    		 	</div>
							 	<div class="row col-7 text-center">
								 	<div class="title">${product.title}</div>
						 		</div>
						 	</c:if>
					 	</div>
	            	</div>
	            </div> 
            
	  		  </div>
	  		  <!-- /.row -->
            
            <!-- reply -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-comments fa-fw"></i>Reply
                  			<sec:authorize access="isAuthenticated()">
								<button id='addReplyBtn' class='btn btn-primary btn-sm pull-right'>New Reply</button>	
                  			</sec:authorize>
                        </div>  
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<ul class="chat">
                        	</ul>
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel-footer">
                        </div>
                        <!-- panel-footer -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            
            <!-- Modal -->
            <div class="modal fade reply_modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Reply</h4>
                        </div>
                        <div class="modal-body">
							<div class="form-group">
                       			<label>내용</label><input class="form-control" name="reply" value='new reply'>
                       		</div>
                       		<div class="form-group">
                       			<label>작성자</label><input class="form-control" name="replyer" value='replyer' readonly='readonly'/>
                       		</div>
                       		<div class="form-group">
                       			<label>닉네임</label><input class="form-control" name="replyerNick" value='replyerNick' readonly='readonly'/>
                       		</div>
                       		<div class="form-group">
                       			<label>Reply Date</label><input class="form-control" name="replyDate" value='replyDate'>
                       		</div>
                        </div>
                        <sec:authorize access="isAuthenticated()">
						  <input type='hidden' id='replyerId' value='<sec:authentication property="principal.username"/>'>
                   	      <input type='hidden' id='replyerNick' value='<sec:authentication property="principal.member.member_nick"/>'>
						</sec:authorize> 
                      
                        
                        <div class="modal-footer">
                            <button id='modalModBtn' type="button" class="btn btn-primary" data-dismiss="modal">수정</button>
                            <button id='modalRemoveBtn' type="button" class="btn btn-primary">삭제</button>
                            <button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
                            <button id='modalCloseBtn' type="button" class="btn btn-primary">취소</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
            <form id='actionForm' action="/community/list" method="get">
            	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
            	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
            	<input type='hidden' name='type' value='${pageMaker.cri.type}'>
            	<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
            	<input type='hidden' name='sort' value='${pageMaker.cri.sort}'>
            	<input type='hidden' name='isReview' value='${pageMaker.cri.isReview}'>
            	<input type='hidden' name='category' value='${pageMaker.cri.category}'>
            </form>
</div>
<script type="text/javascript" src="/resources/js/community/reply.js"></script>
<script type="text/javascript" src="/resources/js/community/likefollow.js"></script>
<script type="text/javascript">

var bnoValue='<c:out value="${board.bno}"/>';
var replyer = $('#replyerId').val();	
var replyerNick = $('#replyerNick').val();
var member_id = $('#replyerId').val();	


var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
	
$(document).ajaxSend(function(e,xhr,options){
		console.log(csrfHeaderName, csrfTokenValue);
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

$(document).ready(function() {
	var operForm = $('#operForm');
	
	$("button[data-oper='modify']").on('click',function(e){
		operForm.attr('action','/community/modify').submit();
	})
	
	$("button[data-oper='list']").on('click',function(e){
		operForm.find('#bno').remove();
		operForm.attr('action','/community/list').submit();
	}) 
	
	//상세페이지(get) 이동
	var actionForm= $('#actionForm');
	$('.move').on('click',function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr('action','/community/get');
		actionForm.submit();
	})
	
	$('.panel-body').find('img').removeAttr("style").css('width','100%')
});


</script>

<script type="text/javascript" src="/resources/js/community/get.js"></script>

<%@include file="../includes/footer.jsp" %>
        