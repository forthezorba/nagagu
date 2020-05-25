<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.css" rel="stylesheet">
<style>
.uploadResult, .uploadResultMain,.uploadResultBanner ul{
	width: 100%;
	background-color: gray;
}

.uploadResult ul,.uploadResultMain ul,.uploadResultBanner ul{
	display: flex;
	flex-flox: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li,.uploadResultMain ul li,.uploadResultBanner ul li{
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img,.uploadResultMain ul li img,.uploadResultBanner ul li img{
	width: 100px;
}
</style>
<div class="container">
            <div class="row">
                <div class="col-lg-12">
                	<div class="panel-heading py-3">
                    <h2><a href="/store/list">STORE</a> > 상품 수정 </h2>
                    <p>상품을 수정하실 수 있습니다. 해당 항목에 내용을 입력해주세요<br/>주의: 반드시 저작권 및 상표권에 문제가 없는 이미지를 사용해 주세요.</p>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div> 
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<form role="form" action="/store/modify" method="post">
                        		<div class="form-group d-flex">
                        			<div class="col-lg-3 pl-0"> 
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
                        		</div>
                        		<div class="form-group">
                        			<label>상품명</label><input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
                        		</div>
								<div class="d-flex">
	                        		<div class="form-group">
		                        		<label>상품 금액(원, 숫자만 입력)</label><input class="form-control" name="price" 
		                        		value='<c:out value="${board.price}"/>'>
									</div>
	                        		<div class="form-group">
		                        		<label>상품 재고(개, 숫자만 입력)</label><input class="form-control" name="stock" 
		                        		value='<c:out value="${board.stock}"/>'>
									</div>
 									<div class="form-group size">
		                        		<label>사이즈</label>
		                        		<input class="btn btn-outline-dark btn-sm ml-2" type="button" value="추가" onclick="addSize();">
	                  					<input class="btn btn-outline-dark btn-sm" type="button" value="삭제" onclick="deleteSize();">
		                        		
		                        		<c:forTokens var="board" items="${board.allsize}" delims=",">
											<input class="form-control" name="allsize" placeholder="예시) 1000*50*70" style="width:auto;" 
											value="${board}">
										</c:forTokens> 
									</div> 
									<div class="form-group color">
		                        		<label>색상</label>
		                        		<input class="btn btn-outline-dark btn-sm ml-2" type="button" value="추가" onclick="addColor();">
	                  					<input class="btn btn-outline-dark btn-sm" type="button" value="삭제" onclick="deleteColor();">
		                        		<c:forTokens var="board" items="${board.color}" delims=",">
											<input class="form-control" name="color" style="width:auto;" value="${board}">
										</c:forTokens> 
									</div>
								</div>
                        		<div class="form-group">
                        			<label>상품 소개</label>
                        			<textarea class="summernote form-control" name="content" id='content'>
                        			${board.content}
                        			</textarea>
                        		</div>
                        		<div class="d-flex justify-content-around"> 
									<div class="form-group">
		                        		<label>배송업체</label>
		                        		<input class="form-control" name="shipCompany" value="${board.shipCompany}"> 
									</div>
									<div class="form-group">
		                        		<label>배송 기간(일)</label>
		                        		<input class="form-control" name="shipDays" value="${board.shipDays}"> 
									</div>
									<div class="form-group">
		                        		<label>배송비</label>
		                        		<input class="form-control" name="shipPrice" value="${board.shipPrice}"> 
									</div>
									<div class="form-group">
		                        		<label>환불 배송비</label>
		                        		<input class="form-control" name="shipReturnPrice" value="${board.shipReturnPrice}"> 
									</div>
	                        		<div class="form-group">
		                        		<label>교환 배송비</label>
		                        		<input class="form-control" name="shipChangePrice" value="${board.shipChangePrice}">  
									</div>
								</div>
								<div class="form-group">
	                        		<label>배송지</label>
	                        		<input class="form-control" name="shipReturnPlace" value="${board.shipReturnPlace}"> 
								</div>
								<div class="form-group">
	                        		<label>배송/환불 정보</label>
	                        		<textarea class="summernote form-control" name="shipInfo" id="shipInfo">
	                        		${board.shipInfo}
	                        		</textarea>
								</div>
								<div class="form-group">
	                        		<label>상단 배너</label>
	                        		<p>* 가로가 긴 이미지 추천, 최대 네 장까지 업로드 가능</p>
	                        		<div class="form-group uploadDiv banner">
		                       			<input type="file" name="banner" multiple>
		                       		</div>
		                       		<div class="form-group uploadResultBanner">
		                       			<ul>
		                       			</ul>
		                       		</div>
								</div>
								<div class="form-group mainImage">
	                        		<label>대표이미지</label>
	                        		<input type="file" name="mainImage">
	                        		<p> * 정사각형 이미지 추천</p>
		                       		<div class="form-group uploadResultMain">
		                       			<ul> 
		                       			</ul>
		                       		</div>
								</div>
								<div class="form-group">
	                        		<div class="form-group uploadDiv"></div>
		                       		<!-- for attach & show -->
		                       		<div class="form-group uploadResult">
		                       			<ul>
		                       			</ul>
		                       		</div>
								</div>
								<input type="hidden" name="bno" value='<c:out value="${board.bno}"/>'/>
                        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								
								<div class="form-group">
                        			<label>글쓴이</label><input class="form-control" name="writer" value='<sec:authentication property="principal.username"/>' readonly="readonly" >
                        			<input class="form-control" name="workshopName"	value='<sec:authentication property="principal.member.member_nick"/>' readonly="readonly" >
                        			<input type="hidden" name="writer_picture" value='<sec:authentication property="principal.member.member_picture"/>'>
                        		</div> 
                        		
                        		<!-- 작성자만 버튼 보이기 -->
	                       		<sec:authentication property="principal" var="pinfo"/>
	                  			<sec:authorize access="isAuthenticated()">
	                        		<button type="submit" data-oper='register' class="btn btn-primary">수정</button>
	                        		<button type="submit" data-oper='remove' class="btn btn-primary">삭제</button>
	                        		<button type="submit" data-oper='list' class="btn btn-primary">목록</button>
	                        	</sec:authorize>
                        	</form>
                        
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
</div>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	/*size, color, option 추가*/
	function addSize() {
		var txt = '<input class="form-control" name="allsize" placeholder="예시) 1000*50*70">'
		$('.size').append(txt);
	}
	function deleteSize() {
		$('.size input:last').remove();
	}
	function addColor() {
		var txt = '<input class="form-control" name="color">'
		$('.color').append(txt); 
	}
	function deleteColor() {
		$('.color input:last').remove();
	}
</script>
<script>
$(document).ready(function(){
	//db에서 가져온 사진파일 출력하기
 	(function(){
		var bno='<c:out value="${board.bno}"/>';
		$.getJSON("/store/getAttachList",{bno: bno}, function(arr){
			console.log(arr) 
			var str='';
			$(arr).each(function(i,attach){
/* 				function getShortName(){
					var fileName= attach.uuid+attach.fileName;
					if(fileName.length > 10){
			          fileName = fileName.substring(0,7)+"...";
			          return fileName;
			        }	
					return fileName;
				} */
				
				//배너들
				if(attach.fileType){
					//var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					str += "<li data-path='"+attach.uploadPath+"' data-url='"+attach.url+"'";
					str += " data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>" 
					str += '<div>';
					//str += '<span>'+getShortName()+'</span>';
					str += '<button type="button" data-url="'+attach.url+'" data-type="image" class="btn btn-warning btn-circle"><i class="fa fa-times"></i></button><br>';
					str += "<img src='"+attach.url+"'>"
					str += '</div></li>';
				}
				//메인이미지
				else{
					var main='';
					//var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					main += "<li data-path='"+attach.uploadPath+"' data-url='"+attach.url+"'";
					main += " data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>" 
					main += '<div>';
					//main += '<span>'+getShortName()+'</span>';
					main += '<button type="button" data-url="'+attach.url+'" data-type="image" class="btn btn-warning btn-circle"><i class="fa fa-times"></i></button><br>';
					main += "<img src='"+attach.url+"'>"
					main += '</div></li>';
					$('.uploadResultMain ul').html(main);
					return;
				}
			})
			$('.uploadResultBanner ul').html(str);
		});
	})(); 
});
</script>
<script type="text/javascript" src="/resources/js/store/file.js"></script>
<!-- include summernote css/js -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<%@include file="../includes/footer.jsp" %>
        