<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/community/get.css">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.css" rel="stylesheet">
<style>
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
	background-color: grey;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
<div class="container">
            <div class="row">
                <div class="col-lg-12">
                	<div class="panel-heading">
                    <h3><a href="/community/list">COMMUNITY</a> > 새 글 등록 </h3>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div> 
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           	게시글 등록
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<form role="form" action="/community/register" method="post" id="board_form">
                        		<div class="form-group">
                        			<label>제목</label><input class="form-control" name="title">
                        		</div>
                        		<div class="form-group d-flex">
                        			<div class="col-lg-2 pl-0"> 
	                        			<label>카테고리</label><br>
	                        			<select name="category" class="form-control">
											<option value="">선택</option>
											<option value="table">책상</option>
											<option value="chair">의자</option>
											<option value="bookshelf">책장</option>
											<option value="bed">침대</option>
											<option value="drawer">서랍장</option>
											<option value="sidetable">협탁</option>
											<option value="sofa">소파</option>
											<option value="others">기타</option>
										</select>
									</div> 
									<div class="col-lg-2 pl-0">	
										<label>후기/일반</label>
										<select name="isReview" class="form-control">
											<option value="0">선택</option> 
											<option value="1">후기</option>
											<option value="2">일반</option>
										</select>
									</div>
                        		</div>
								<div class="search_tab form-group offset-md-2">
							 		<div class="search_form d-flex "> 
								      <button type='button' class="btn w-50 btn-dark">상품명</button>
								      <input class="form-control w-50" id="search_product" placeholder="검색..." aria-label="Search">
								      
								      <input type="hidden" id="productNo" value="" name="productNo">
								    </div>
								    <div class="search_form d-flex col-lg-4">
								      <input class="form-control search_form text-center" id="search_gongbang" placeholder="공방명" aria-label="Search" readonly>
								   	</div> 
								</div>
                        		
                        		<div class="form-group">
                        			<label>내용</label><textarea id="summernote" class="form-control" name="content" rows="3"></textarea>
                        		</div>
                        		<div class="form-group">
                        			<label>태그</label>
                        			<input type="hidden" name="tags" id="pics_tags"  value=""/>
									<div class="d-flex tags">           		
										#<input type="text" value="" class="form-control">
										#<input type="text" value="" class="form-control">
										#<input type="text" value="" class="form-control">
										#<input type="text" value="" class="form-control">
									</div>
                        		</div>
                        		<div class="form-group">
                        			<label>닉네임</label><input class="form-control" name="nick"
                        			value='<sec:authentication property="principal.member.member_nick"/>' readonly="readonly" >
                        		</div> 
                        		<div class="form-group uploadResult">
	                       			<ul>
	                       			</ul>
	                       		</div>
                        		<sec:authorize access="isAuthenticated()">
								  <input type='hidden' id='member_id' value='<sec:authentication property="principal.username"/>'>
								</sec:authorize> 
                        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        		<input type="hidden" name="writer" value='<sec:authentication property="principal.username"/>'>
                        		<input type="hidden" name="writer_picture" value='<sec:authentication property="principal.member.member_picture"/>'>
                        		<button type="submit" data-oper='modify' class="btn btn-default">등록</button>
                        		<button type="reset" class="btn btn-default">취소</button> 
                        	</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
</div>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
var member_id = $('#member_id').val();

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ajaxSend(function(e,xhr,options){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
</script>
<script>
//유효성
$(document).ready(function(){
	//처음에 숨기고
	$('.search_tab').hide();
	$('select[name=isReview]').on('change',function(){
		if($(this).val()==1){
			$('.search_tab').show().addClass('d-flex')
		}
		if($(this).val()!=1){
			$('.search_tab').hide().removeClass('d-flex')
		}
	});
	//후기 자동완성
	 $(function(){
		$('#search_product').autocomplete({
			source : function(request,response){
				 $.ajax({
					 url: "/order/orderList/"+member_id+"/''"+".json",
					 async: false,
		             type: "get",
		             contentType:
		 				'application/x-www-form-urlencoded; charset=utf-8',
		             success: function (retVal){
	       			 	if(retVal.res=="OK"){
			       		   response(
                               $.map(retVal.orderList, function(item){   //json[i] 번째 에 있는게 item 임.
                                   return {
                                       label: item.TITLE,     //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
                                       number: item.BNO,   //그냥 사용자 설정값?
                                       gongbang: item.WORKSHOPNAME   //그냥 사용자 설정값?
                               		}
                               })
                           );
						}
					 }
				});
			},
			select: function(event, ui) {
	            console.log(ui.item);
	            $('#search_gongbang').val(ui.item.gongbang);
	            $('#productNo').val(ui.item.number);
	        },
	        focus: function(event, ui) {
	            return false;
	        }
		});
	 });
	
	//태그 값 채워넣기
	function addTags(){				
		var	tags_value= '';
		var tags_children = $('div.tags').children();
		for (var i = 0; i < tags_children.length; i++) {
			if (i != tags_children.length - 1) {
				tags_value += tags_children[i].value + ',';
			} else {
				tags_value += tags_children[i].value;
			}
		}
		$('#pics_tags').val(tags_value);
	}
	
	function check_method(e){
		//유효성 검사
		if($('input[name=title]').val()==0){
			console.log($(this))
			alertify.alert('제목을 선택하세요')
			return false;
		}
		if($('select[name=category]').val()==0){
			alertify.alert('카테고리를 선택하세요')
			$('select[name=category]').focus();
			return;
		}
		if($('select[name=isReview]').val()==0){
			alertify.alert('후기/일반 중에 선택하세요');
			return false;
		}
		if($('.note-editable img').length==0){
			alertify.alert('하나 이상의 사진을 넣어주세요');
			return false;
		}
		return true;
	}
	
	var formObj = $('form[role=form]');
	$('button[type="submit"]').on('click',function(e){
		e.preventDefault();
		if(!check_method()){
			return;
		}
		
		var operation=$(this).data('oper');
		if(operation==='remove'){
			formObj.attr('action','/community/remove');
		}else if(operation==='list'){
			formObj.attr('action','/community/list').attr('method','get');
			
			var pageNumTag = $('input[name="pageNum"]').clone();
			var amountTag = $('input[name="amount"]').clone();
			var keywordTag = $('input[name="keyword"]').clone();
			var typeTag = $('input[name="type"]').clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}else if(operation === 'modify'){
			var str='';
			$('.uploadResult ul li').each(function(i,obj){
				var jobj = $(obj);
				console.dir(jobj);
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			})
			addTags();
			//set mainImage
			var mainImage= $('.note-editable').find('img').eq(0).attr('src');
			str += "<input type='hidden' name='mainImage' value='"+mainImage+"'>";
			
			formObj.append(str).submit();	
		}
		formObj.submit();
	})
});


</script>


<script type="text/javascript" src="/resources/js/community/file.js"></script>


<!-- include summernote css/js -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<%@include file="../includes/footer.jsp" %>
        