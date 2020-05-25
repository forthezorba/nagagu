<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
<style>
.category_cs{
	min-height:75vh;
}
</style>
<div class="container category_cs">  
	<div class="row">
        <div class="col-lg-12">
            <h1 class="page-header py-3">CUSTOM(업데이트 예정/ 현재 이용 불가)</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- end row -->
		<nav>
			<div class="nav d-flex justify-content-between shadow p-3 mb5 bg-white rounded" id="nav-tab" role="tablist">
		    	<a class="nav-item nav-link" id="nav-waiting-tab" data-toggle="tab" href="#nav-waiting" role="tab" aria-controls="nav-home" aria-selected="true">
		    		<dl class="text-center">
		    			<dd></dd>
		    			<dt><h5>견적신청</h5></dt>
		    			<dd></dd>
		    		</dl>
		    	</a>
				<div class="text-center align-self-center">
					<i class="far fa-arrow-alt-circle-right" style="font-size: 30px;"></i>
				</div>
		    	<a class="nav-item nav-link" id="nav-finish-tab" data-toggle="tab" href="#nav-finish" role="tab" aria-controls="nav-profile" aria-selected="false">
		    		<dl class="text-center">
		    			<dd></dd>
		    			<dt><h5>공방입찰</h5></dt>
		    			<dd></dd>
		    		</dl>
		    	</a>
		    	<div class="text-center align-self-center">
					<i class="far fa-arrow-alt-circle-right" style="font-size: 30px;"></i>
				</div>
		    	<a class="nav-item nav-link" id="nav-ready-tab" data-toggle="tab" href="#nav-ready" role="tab" aria-controls="nav-contact" aria-selected="false">
		    		<dl class="text-center">
		    			<dd></dd>
		    			<dt><h5>입찰확인</h5></dt>
		    			<dd></dd>
		    		</dl>
		    	</a>
		    	<div class="text-center align-self-center">
					<i class="far fa-arrow-alt-circle-right" style="font-size: 30px;"></i>
				</div>
				<a class="nav-item nav-link" id="nav-shipping-tab" data-toggle="tab" href="#nav-shipping" role="tab" aria-controls="nav-contact" aria-selected="false">
					<dl class="text-center">
		    			<dd></dd>
		    			<dt><h5>낙찰</h5></dt>
		    			<dd></dd>
		    		</dl>
				</a>
				<div class="text-center align-self-center">
					<i class="far fa-arrow-alt-circle-right" style="font-size: 30px;"></i>
				</div>
				<a class="nav-item nav-link" id="nav-completed-tab" data-toggle="tab" href="#nav-completed" role="tab" aria-controls="nav-contact" aria-selected="false">
					<dl class="text-center">
		    			<dd></dd>
		    			<dt><h5>낙찰확정</h5></dt>
		    			<dd></dd>
		    		</dl>
				</a>
			</div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
			<div class="tab-pane fade shadow p-3 mb5 bg-white rounded" id="nav-waiting" role="tabpanel" aria-labelledby="nav-waiting-tab">
				<div>
					<p>1. 회원 로그인 하신 상태에서 글쓰기 버튼을 클릭합니다.</p>
					<p>2. 제공되는 양식에 맞게 글을 쓴 뒤 신청을 클릭하면 수제가구 의뢰글이 등록됩니다.</p>
				</div>
				<hr>
			</div>
			<div class="tab-pane fade shadow p-3 mb5 bg-white rounded" id="nav-finish" role="tabpanel" aria-labelledby="nav-finish-tab">
				<div>
					<img src="${pageContext.request.contextPath}/resources/images/Estimate/Bidding.jpg" width="100%" height="auto">
					<div class="d-flex justify-content-center">
						<p>공방들이 입찰을 해줄 떄 까지 기다립니다..</p>
					</div>
				</div>
				<hr>
			</div>
			<div class="tab-pane fade shadow p-3 mb5 bg-white rounded" id="nav-ready" role="tabpanel" aria-labelledby="nav-ready-tab">
				<div>
					<img src="${pageContext.request.contextPath}/resources/images/Estimate/Bid_confirmation.jpg" width="100%" height="auto">
					<div class="d-flex justify-content-center">
						<p>공방들이 입찰을 다 했을 경우 원하는 가격을 선택해 낙찰하기 버튼을 누릅니다.</p>
					</div>
				</div>
				<hr>
			</div>
			<div class="tab-pane fade shadow p-3 mb5 bg-white rounded" id="nav-shipping" role="tabpanel" aria-labelledby="nav-shipping-tab">
				<div>
					<img src="${pageContext.request.contextPath}/resources/images/Estimate/bid.jpg" width="100%" height="auto">
					<div class="d-flex justify-content-center">
						<p>원하는 공방으로 낙찰을 하고 해당 공방과 문의를 하여 상세하게 지정합니다.</p>
					</div>
				</div>
				<hr>
			</div>
			<div class="tab-pane fade shadow p-3 mb5 bg-white rounded" id="nav-completed" role="tabpanel" aria-labelledby="nav-completed-tab">
				<div>
					<div class="d-flex justify-content-start">
						<p>마이페이지 견적 주문 관리에서 결제를 완료하여 주문을 완료합니다. </p>
					</div>
				</div>
				<hr>
			</div>
		</div>

	<div class="row">
	    <div class="col-lg-12">
	        <div class="panel panel-default">
	            <div class="panel-heading">제안글 목록
	            <button id='regBtn' type='button' class='btn btn-xs pull-right'>새 글 등록</button>
	            </div>
	            <!-- /.panel-heading -->
	            <div class="panel-body">
	                <table class="table table-striped table-bordered table-hover">
	                    <thead>
	                        <tr>
	                            <th>#번호</th>
	                            <th>신청인</th>
	                            <th>제목</th>
	                            <th>카테고리</th>
	                            <th>평균가</th>
	                            <th>업체수</th> 
	                            <th>진행상황</th>
	                            <th>작성일</th>
	                        </tr>
	                    </thead>
	                    
	                    <c:forEach items="${list }" var="board">
	                    <tr>
	                    	<td><c:out value="${board.bno }"/></td>
	                    	<td>
	                    		<a class='move' href='<c:out value="${board.bno}"/>'>
	                    		<c:out value="${board.title }"/>
	                    		<b>[ <c:out value="${board.replyCnt}"/> ]</b>
	                    		</a>
	                    	</td>
	                    	<td><c:out value="${board.writer }"/></td>
	                    	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
	                    	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
	                    </tr>
	                    </c:forEach>
	                     
	                </table>
	            <!-- /.panel-body -->
		        </div>
		        <!-- /.panel -->
		    </div>
		    <!-- /.col-lg-12 -->
		</div>
	</div>
	
	
	
	
</div>
<!-- end container -->
            
            
            
           
            
            
<script>
$(document).ready(function() {
	var result = '<c:out value="${result}"/>';
	checkModal(result);
	
	history.replaceState({},null,null);
	console.log(history.state)
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
		self.location='/board/register';
	})
	
	var actionForm= $('#actionForm');
	$('.paginate_button a').on('click',function(e){
		e.preventDefault();
		actionForm.find('input[name="pageNum"]').val($(this).attr('href'));
		actionForm.submit();
	})
	
	$('.move').on('click',function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr('action','/board/get');
		actionForm.submit();
	})
	
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
});
</script>
   	<%@include file="../includes/footer.jsp" %>
        