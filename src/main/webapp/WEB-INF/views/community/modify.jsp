<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.css" rel="stylesheet">
<div class="container">
            
             <div class="row">
                <div class="col-lg-12">
                	<div class="panel-heading">
                    <h3><a href="/community/list">COMMUNITY</a> > 상세보기 </h3>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div> 
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <!-- /.panel-heading --> 
                        <div class="panel-body">
                        	<form role="form" id="operForm" action="/community/modify" method="post">
	                       		<div class="form-group">
	                       			<label>글번호</label><input class="form-control" name="bno" value='<c:out value="${board.bno}"/>'  readonly="readonly">
	                       		</div>
	                       		<div class="form-group">
	                       			<label>제목</label><input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
	                       		</div>
	                       		<div class="form-group d-flex">
                        			<div class="col-lg-2 pl-0"> 
	                        			<label>카테고리</label><br>
	                        			<select name="category" class="form-control">
											<option value="table" ${board.category=='table'? 'selected':''}>책상</option>
											<option value="chair" ${board.category=='chair'? 'selected':''}>의자</option>
											<option value="bookshelf" ${board.category=='bookshelf'? 'selected':''}>책장</option>
											<option value="bed" ${board.category=='bed'? 'selected':''}>침대</option>
											<option value="drawer" ${board.category=='drawer'? 'selected':''}>서랍장</option>
											<option value="sidetable" ${board.category=='sidetable'? 'selected':''}>협탁</option>
											<option value="sofa" ${board.category=='sofa'? 'selected':''}>소파</option>
											<option value="others" ${board.category=='others'? 'selected':''}>기타</option>
										</select>
									</div> 
									<div class="col-lg-2 pr-0">	
										<label>후기/일반</label>
										<select name="isReview" class="form-control">
											<option value="1" ${board.isReview==1? 'selected':''}>후기</option>
											<option value="2" ${board.isReview==2? 'selected':''}>일반</option>
										</select>
									</div>
                        		</div>
	                       		<div class="form-group">
	                       			<label>내용</label> 
                       				<textarea id="summernote" name="content">
									${board.content}
									</textarea>
	                       		</div>
	                       		<div class="form-group">
	                       			<label>글쓴이</label><input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
	                       		</div>
	                       		<div class="form-group uploadResult">
	                       			<ul>
	                       			</ul>
	                       		</div>
	                       		
	                       		<!-- 작성자만 버튼 보이기 -->
	                       		<sec:authentication property="principal" var="pinfo"/>
	                  			<sec:authorize access="isAuthenticated()">
		                  			<c:if test="${pinfo.username eq board.writer}">
		                  			<button type="button" data-oper='modify' class="btn btn-primary">수정</button>
		                       		<button type="button" data-oper='remove' class="btn btn-primary">삭제</button>
		                  			</c:if>
	                  			</sec:authorize>
	                       			<button type="button" data-oper='list' class="btn btn-primary">목록</button> 
	                       			
                       			<input type='hidden' name='pageNum' value="${cri.pageNum}"/> 
				            	<input type='hidden' name='amount' value="${cri.amount}"/>
			            		<input type='hidden' name='keyword' value="${cri.keyword}"/>
				            	<input type='hidden' name='type' value="${cri.type}"/>
				            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                       		</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
</div>
<!-- end container -->
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ready(function() {
	var operForm = $('#operForm');
	var str ='';
	$("button[data-oper='modify']").on('click',function(e){
		var mainImage= $('.note-editable').find('img').eq(0).attr('src');
		str += "<input type='hidden' name='mainImage' value='"+mainImage+"'>";
		operForm.append(str).attr('action','/community/modify').submit();
	})
	
	$("button[data-oper='remove']").on('click',function(e){
		operForm.attr('action','/community/remove').submit();
	})
	
	$("button[data-oper='list']").on('click',function(e){
		operForm.find('#bno').remove();
		operForm.attr('action','/community/list').attr('method','get').submit();
	}) 
	
	//상세페이지(get) 이동
	var actionForm= $('#actionForm');
	$('.move').on('click',function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr('action','/community/get');
		actionForm.submit();
	})
});

//파일 출력하기
(function(){
	var bno='<c:out value="${board.bno}"/>';
	$.getJSON("/community/getAttachList",{bno: bno}, function(arr){
		console.log(arr);
		var str='';
		$(arr).each(function(i,attach){
			if(attach.fileType){
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
				str += "<li data-path='"+attach.uploadPath+"'";
				str += " data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>" 
				str += '</li>';
			}
		})
		$('.uploadResult ul').html(str);
		$('.uploadResult ul').hide();
	});
})();
</script>
<script type="text/javascript" src="/resources/js/community/file.js"></script>
<!-- include summernote css/js -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%@include file="../includes/footer.jsp" %>
        