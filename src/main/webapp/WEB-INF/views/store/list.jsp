<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/community/list.css">
		<div class="container py-3">
           	<div class="row">
           		<div class="col-lg-12">
                    <h1 class="page-header py-3">STORE</h1>
					<table class="table text-center category_caption">
					<thead><tr>  
                            <th><a id="all" href="all">전체</a></th> 
                            <th><a id="table" href="">책상</a></th>
                            <th><a id="chair" href="">의자</a></th>
                            <th><a id="bookshelf" href="">책장</a></th>
                            <th><a id="bed" href="">침대</a> </th>
                            <th><a id="drawer" href="">서랍장</a></th>
                            <th><a id="sidetable" href="">협탁</a> </th>
                            <th><a id="sofa" href="">소파</a></th>
                            <th><a id="others" href="">기타</a></th>
                    </tr></thead>
                    </table>
                    <div class="row justify-content-between"> 
                       	<div class="col-3">
                       		<form class='d-flex' id="sortForm" action="/store/list" method="get">
	                       		<select name="sort" class="form-control mr-2">									
									<option value="regDate" id="new" ${pageMaker.store_cri.sort=='regDate'? 'selected':''}>최신순</option>
									<option value="readCnt" id="sales" ${pageMaker.store_cri.sort=='readCnt'? 'selected':''}>판매량순</option>
									<option value="readCnt" id="read" ${pageMaker.store_cri.sort=='likeCnt'? 'selected':''}>조회순</option> 
									<option value="likeCnt" id="like" ${pageMaker.store_cri.sort=='likeCnt'? 'selected':''}>좋아요순</option> 
									<option value="price" id="price" ${pageMaker.store_cri.sort=='likeCnt'? 'selected':''}>가격순</option> 
								</select>
								<input type='hidden' name='category' value='${pageMaker.store_cri.category}'>
							</form>
						</div>
						<div class="col-6">  
                       		<form class='pull-right d-flex' id="searchForm" action="/store/list" method="get">
                       			<select name='type' class="form-control mr-2">
                       				<option value=""
                       					<c:out value="${pageMaker.store_cri.type==null? 'selected':''}"/>>--</option>
                       				<option value="G" 
                       					<c:out value="${pageMaker.store_cri.type=='G'? 'selected':''}"/>>태그</option>
                       				<option value="T"
                       					<c:out value="${pageMaker.store_cri.type=='T'? 'selected':''}"/>>제목</option>
                       				<option value="C"
                       					<c:out value="${pageMaker.store_cri.type=='C'? 'selected':''}"/>>내용</option>
                       				<option value="W"
                       					<c:out value="${pageMaker.store_cri.type=='W'? 'selected':''}"/>>작성자</option>
                       				<option value="TC"
                       					<c:out value="${pageMaker.store_cri.type=='TC'? 'selected':''}"/>>제목 or 내용</option>
                       				<option value="TW"
                       					<c:out value="${pageMaker.store_cri.type=='TW'? 'selected':''}"/>>제목 or 작성자</option>
                       				<option value="TWC"
                       					<c:out value="${pageMaker.store_cri.type=='TWC'? 'selected':''}"/>>제목 or 작성자 or 내용</option>
                       			</select>
                       			<input type="text" name="keyword" class="form-control"/>
                       			<input type='hidden' name='pageNum' value='${pageMaker.store_cri.pageNum}'>
           						<input type='hidden' name='amount' value='${pageMaker.store_cri.amount}'>
           						<button class="btn btn-default" style="width:200px;">검색</button>  
                       		</form>
                       	</div>
                    </div>
                    <div class="panel-heading">
                        <button id='regBtn' type='button' class='btn btn-xs pull-right'>새 글 등록</button>
                    </div>
                </div>
            </div>
            <!--해더  col-lg-12 -->
            
      		
      		<!-- image start -->
      		<div class="d-flex justify-content-start pt-2 mb-5 row img-wrap">
				<c:forEach items="${list}" var="board">
				<div class="col-lg-4 each_row">
					<div class="profile">
						<div class="profile_children">
							<div> 
								<a href="memberLikePics.cm?MEMBER_NUM='${board.writer}'" class="move"> 
									<img src="${board.writer_picture}"	style="width:50px; height:50px;"><br/> 
									<b><c:out value="${board.workshopName}"/></b>  
								</a> 
							</div >   
						</div> 
						<div class="follow_readcount">
							<div>조회수${board.readCnt}</div>
						</div> 
					</div>
					<div class=img-title></div>
					<div class="img">
					<a class='move' href="${board.bno}">
						<img src="<c:out value="${board.mainImage}"/>" class="img" />
					</a>
					</div>
					<div class="item-content text-center"> 
						<div class="item-title"><h3>${board.title}</h3></div>
						<div class="item-brand"><h5>${board.workshopName}</h5></div>
						
						<fmt:formatNumber var='price' value="${board.price}" pattern="#,###" />
						<div class="item-price"><h5>${price}<span>원</span></h5></div>
					</div> 
					<div class="img-tag">
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
							<li class="page-item ${pageMaker.store_cri.pageNum == num ? "active":""} ">
							<a class="page-link" href="${num}">${num}</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="page-item next">
							<a class="page-link" href="${pageMaker.endPage+1}">다음</a></li>
						</c:if>
					</ul>
				</div>
			</nav>
			<form id='actionForm' action="/store/list" method="get">
            	<input type='hidden' name='pageNum' value='${pageMaker.store_cri.pageNum}'>
            	<input type='hidden' name='amount' value='${pageMaker.store_cri.amount}'>
            	<input type='hidden' name='type' value='${pageMaker.store_cri.type}'>
            	<input type='hidden' name='keyword' value='${pageMaker.store_cri.keyword}'>
            	
            	<input type='hidden' name='sort' value='${pageMaker.store_cri.sort}'>
            	<input type='hidden' name='category' value='${pageMaker.store_cri.category}'>
            </form>
			<!-- pagination end -->
			<!-- 확인 Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel">확인창</h4>
                        </div>
                        <div class="modal-body">처리가 완료됐습니다.</div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
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
$(document).ready(function() {
	var result = '<c:out value="${result}"/>';
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
		self.location='/store/register';
	})
	
	//페이지네이션
	var actionForm= $('#actionForm');
	$('.page-item a').on('click',function(e){
		e.preventDefault();
		actionForm.find('input[name="pageNum"]').val($(this).attr('href'));
		actionForm.submit();
	})
	//상세페이지
	$('.move').on('click',function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr('action','/store/get');
		actionForm.submit();
	})
	//검색
	var searchForm=$('#searchForm');
	$('#searchForm button').on('click',function(e){
		if(!searchForm.find('option:selected').val()){
			alert('검색종류를 선택하세요');
			return false;
		}
		if(!searchForm.find('input[name="keyword"]').val()){
			alert('키워드를 입력하세요');
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
	        		alertify.alert('검색종류를 선택하세요');
	    			return;
	    		};
	        	searchForm.find('input[name="pageNum"]').val('1');
	    		e.preventDefault();
	    		searchForm.submit();
	        }    
	    })
    );
	//검색어 색깔 표시기능
	var target_word = '${pageMaker.store_cri.keyword}';
    if(target_word!=''){
        $('b:contains('+target_word+')').each(function() {
            var text = $(this).text();
            var b = text.replace(''+target_word+'','<span style="color:red;">'+target_word+'</span>');
            console.log('b'+b)
            $('b:contains('+target_word+')').html(b);    
        })
        $('span:contains('+target_word+')').each(function() {
            var text = $(this).text();
            var b = text.replace(''+target_word+'','<span style="color:red;">'+target_word+'</span>');
            console.log('b'+b)
            $('span:contains('+target_word+')').html(b);    
        })
        $('p:contains('+target_word+')').each(function() {
            var text = $(this).text();
            var b = text.replace(''+target_word+'','<span style="color:red;">'+target_word+'</span>');
            console.log('b'+b)
            $('p:contains('+target_word+')').html(b);    
        })
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
	
	//카테고리 css활성화
	var category = '${pageMaker.store_cri.category}';
	$('.category_caption').find('a').removeClass('active');
	$('#'+category).addClass('active');
	
});
</script>
<%@include file="../includes/footer.jsp" %>
        