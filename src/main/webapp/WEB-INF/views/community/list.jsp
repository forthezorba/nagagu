<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/community/list.css">
		<div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header py-3">COMMUNITY</h1>
					<table class="table text-center category_caption">
					<thead>
                        <tr>  
                            <th><a id="all" href="all">전체</a></th>
                            <th><a id="table" href="">책상</a></th>
                            <th><a id="chair" href="">의자</a></th>
                            <th><a id="bookshelf" href="">책장</a></th>
                            <th><a id="bed" href="">침대</a> </th>
                            <th><a id="drawer" href="">서랍장</a></th>
                            <th><a id="sidetable" href="">협탁</a> </th>
                            <th><a id="sofa" href="">소파</a></th>
                            <th><a id="others" href="">기타</a></th>
                        </tr>
                    </thead>
                    </table>
                    <div class="row justify-content-between">  
                       	<div class="col-6">
                       		<form class='' id="sortForm" action="/community/list" method="get">
	                       		<select name="sort" class="form-control mr-2">									
									<option value="regDate" id="new" ${pageMaker.cri.sort=='regDate'? 'selected':''}>최신순</option>
									<option value="readCnt" id="read" ${pageMaker.cri.sort=='readCnt'? 'selected':''}>조회순</option>
									<option value="likeCnt" id="like" ${pageMaker.cri.sort=='likeCnt'? 'selected':''}>인기순</option> 
								</select>
								<select name="isReview" class="form-control">
									<option value="0" id="all" ${pageMaker.cri.isReview==0? 'selected':''}>모두보기</option>
									<option value="1" id="review" ${pageMaker.cri.isReview==1? 'selected':''}>후기</option>
									<option value="2" id="no_review" ${pageMaker.cri.isReview==2? 'selected':''}>일반</option>
								</select>
								<input type='hidden' name='category' value='${pageMaker.cri.category}'>
							</form>
						</div>
						<div class="col-6">  
                       		<form class='pull-right' id="searchForm" action="/community/list" method="get">
                       			<select name='type' class="form-control mr-2">
                       				<option value=""
                       					<c:out value="${pageMaker.cri.type==null? 'selected':''}"/>>--</option>
                       				<option value="G" 
                       					<c:out value="${pageMaker.cri.type=='G'? 'selected':''}"/>>태그</option>
                       				<option value="T"
                       					<c:out value="${pageMaker.cri.type=='T'? 'selected':''}"/>>제목</option>
                       				<option value="C"
                       					<c:out value="${pageMaker.cri.type=='C'? 'selected':''}"/>>내용</option>
                       				<option value="W"
                       					<c:out value="${pageMaker.cri.type=='W'? 'selected':''}"/>>작성자</option>
                       				<option value="TC"
                       					<c:out value="${pageMaker.cri.type=='TC'? 'selected':''}"/>>제목 or 내용</option>
                       				<option value="TW"
                       					<c:out value="${pageMaker.cri.type=='TW'? 'selected':''}"/>>제목 or 작성자</option>
                       				<option value="TWC"
                       					<c:out value="${pageMaker.cri.type=='TWC'? 'selected':''}"/>>제목 or 작성자 or 내용</option>
                       			</select>
                       			<input type="text" name="keyword" class="form-control"/>
                       			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
           						<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
           						<button class="btn btn-default" style="width:200px;">검색</button>  
                       		</form>
                       	</div>
                    </div>
                    <div class="panel-heading">
                        <button id='regBtn' type='button' class='btn btn-xs pull-right'>새 글 등록</button>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div>
      		
      		<!-- image start -->
      		<div class="d-flex justify-content-start pt-2 mb-5 row img-wrap">
				<c:forEach items="${list}" var="board">
				<div class="col-lg-4 each_row">
					<div class="profile">
						<div class="profile_children"> 
							<div>  
								<a href="/mypage/other?writer=${board.writer}"> 
									<img src="${board.writer_picture}"	style="width:50px; height:50px;"><br/> 
									<b class="nick"><c:out value="${board.nick}"/></b>   
								</a> 
							</div > 
								<div class="follow_btn_wrap">
									<button type="button" class="follow_btn ${board.writer}" id="${board.writer}">follow</button>
								</div>
						</div>
						<div class="follow_readcount">
							<div>좋아요${board.likeCnt}&nbsp;조회수${board.readCnt}</div>
						</div> 
					</div>
					<div class=img-title><p>${board.title}</p></div>
					<div class="img">
					<a class='move' href="${board.bno}">
						<img src="${board.mainImage}" class="img" />
						<div class="hover-image heart_output" id="${board.bno}">
							<a href="#"> 
								<span class="button likeBtn" bno="${board.bno}"    >  
									<i class="far fa-heart fa-2x" id="far">${board.likeCnt}</i>
								</span>
							</a> 
						</div>
					</a>
					</div>
					
					<div class="img-tag">
					<c:forTokens items="${board.tags}" delims="," var="item">
					    <a href="#"><span class=img-tags>#${item}</span></a>
					</c:forTokens> 
					</div>
				</div>
				</c:forEach>
			</div>
			<!-- images end -->
			
			<!-- pagination -->
			<nav aria-label="..">
			<div class="row justify-content-center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="page-item previous"><a class="page-link"	href="${pageMaker.startPage-1}">이전</a></li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage}"	end="${pageMaker.endPage}">
						<li class="page-item ${pageMaker.cri.pageNum == num ? "active":""} ">
						<a class="page-link" href="${num}">${num}</a></li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="page-item next">
						<a class="page-link" href="${pageMaker.endPage+1}">다음</a></li>
					</c:if>
				</ul>
			</div>
			</nav>
			<form id='actionForm' action="/community/list" method="get">
            	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
            	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
            	<input type='hidden' name='type' value='${pageMaker.cri.type}'>
            	<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
            	
            	<input type='hidden' name='sort' value='${pageMaker.cri.sort}'>
            	<input type='hidden' name='isReview' value='${pageMaker.cri.isReview}'>
            	<input type='hidden' name='category' value='${pageMaker.cri.category}'>
            </form>
			<!-- pagination end -->
			<!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">성공</h4>
                        </div>
                        <div class="modal-body">
                             	처리가 완료됐습니다.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
      </div>
      <!-- /.container -->
 
<script>
var member_id = null;	
<sec:authorize access="isAuthenticated()">
member_id = '<sec:authentication property="principal.username"/>';
</sec:authorize>
var memeber_id=''; 
if(member_id != null){
	member_id = member_id.replace('&#64;','@').replace('&#46;','.');	
}


var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

var result = '<c:out value="${result}"/>';
$(document).ready(function() {
	checkModal(result);
	history.replaceState({},null,null);
	function checkModal(result){
		if(result==='' || history.state){
			return; 
		}
		if(parseInt(result)>0){
			$('.modal-body').html('게시글 '+parseInt(result)+'번이 등록되었습니다.');
		}
		$('#myModal').modal('show');
	}
	$('#regBtn').on('click',function(){
		self.location='/community/register';
	});
});


$(document).ready(function() {
	//페이지네이션
	var actionForm= $('#actionForm');
	$('.page-item a').on('click',function(e){
		e.preventDefault();
		actionForm.find('input[name="pageNum"]').val($(this).attr('href'));
		actionForm.submit();
	})
	
	//검색
	var searchForm=$('#searchForm');
	$('#searchForm button').on('click',function(e){
		if(!searchForm.find('option:selected').val()){
			alertify.alert('확인','검색종류를 선택하세요');
			return false;
		}
		if(!searchForm.find('input[name="keyword"]').val()){
			alertify.alert('확인','키워드를 입력하세요');
			return false;
		}
		searchForm.find('input[name="pageNum"]').val('1');
		e.preventDefault();
		searchForm.submit();
	})
	//엔터검색
    $(searchForm.find('input[name="keyword"]').keypress(function (e) {
			var key = e.which;
			var keywordVal = $(this).val();
	        if(key == 13)  {
	        	if(!keywordVal){
	                alertify.alert('확인','검색어를 입력하세요');
	    			return;
	    		};
	        	if(!searchForm.find('option:selected').val()){
	        		alertify.alert('확인','검색종류를 선택하세요');
	    			return;
	    		};
	        	searchForm.find('input[name="pageNum"]').val('1');
	    		e.preventDefault();
	    		searchForm.submit();
	        }    
	    })
    );
	/* 태그눌러서 검색 */ 
	$('.img-tags').on('click',function(){
		var text = $(this).text();
		var search_text = text.substring(1,text.length);
		searchForm.find('input[name="keyword"]').val(search_text);
		searchForm.find('input[name="pageNum"]').val('1');
		
		var optionG = $('#searchForm').find('option[value="G"]');
		$(optionG).prop('selected', true);
		
		searchForm.submit();
	})
	//검색어 색깔 표시기능
	var target_word = '${pageMaker.cri.keyword}';
	var target_type= '${pageMaker.cri.type}';
	console.log(target_type.includes('W')); 
	
    if(target_word!=''){
    		//작성자
    	if(target_type.includes('W')){
    		$('.nick:contains('+target_word+')').each(function() {
                var text = $(this).text();
                var b = text.replace(''+target_word+'','<span style="color:red;">'+target_word+'</span>');
                console.log('b'+b)
                $('b:contains('+target_word+')').html(b);    
            })
    	}
    	if(target_type.includes('G')){
	        //태그검색
	        $('.img-tags:contains('+target_word+')').each(function() {
	            var text = $(this).text();
	            var b = text.replace(''+target_word+'','<span style="color:red;">'+target_word+'</span>');
	            console.log('b'+b)
	            $('span:contains('+target_word+')').html(b);    
	        })
    	}
    	if(target_type.includes('T')){
	        //제목검색
	        $('.img-title:contains('+target_word+')').each(function() {
	            var text = $(this).text();
	            var b = text.replace(''+target_word+'','<span style="color:red;">'+target_word+'</span>');
	            console.log('b'+b)
	            $('p:contains('+target_word+')').html(b);    
	        })
    	}
    }
	
	//정렬
	var sortForm=$('#sortForm');
	$('#sortForm').on('change',function(e){
		e.preventDefault();
		sortForm.submit();
	})
	
	//카테고리 정렬
	$('.table a').on('click',function(e){
		e.preventDefault();
		sortForm.find('input[name="category"]').val($(this).attr("id"));
		sortForm.submit();
	})
	
	//상세페이지(get) 이동
	$('.move').on('click',function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr('action','/community/get');
		actionForm.submit();
	})
	
	//카테고리 카테고리 css활성화
	var category = '${pageMaker.cri.category}';
	$('.category_caption').find('a').removeClass('active');
	$('#'+category).addClass('active');

});

</script>
<script type="text/javascript" src="/resources/js/community/likefollow.js"></script>
<%@include file="../includes/footer.jsp" %>
        