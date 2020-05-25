<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
#star_grade a{
    text-decoration: none;
    color: gray;
    font-size: xx-large;
}
#star_grade a.on{
    color: red;
}
</style>
<!-- reply -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>REVIEW
				<sec:authorize access="isAuthenticated()">
					<button id='addReplyBtn' class='btn btn-primary btn-sm pull-right'>New
						Review</button> 
				</sec:authorize>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
				</ul>
			</div>
			<!-- /.panel-body -->
			<div class="panel-footer"></div>
			<!-- panel-footer -->
		</div>
		<!-- /.panel -->
<!-- Modal -->
<div class="modal fade reply_modal" id="myModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
				<h4 class="modal-title" id="myModalLabel">Reply</h4>
			</div>
			<!-- original file -->
			<div class="bigPictureWrapper" style="margin: auto;">
				<div class="bigPicture">
				</div>
			</div>
			<!-- original file end-->
			<div class="modal-body">
				<div class="form-group">
					<label>작성자</label><input class="form-control" name="replyer"
						value='replyer' readonly='readonly' />
				</div>
				<div class="form-group">
           			<label>닉네임</label><input class="form-control" name="replyerNick" value='replyerNick' readonly='readonly'/>
           		</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control"	name="replyDate" value='replyDate' >
				</div>
				<div class="form-group">
					<label>별점</label>
					<input class="form-control" type='hidden' name="grade" value='grade'>
						<p id="star_grade">
					        <a href="#">★</a>
					        <a href="#">★</a>
					        <a href="#">★</a>
					        <a href="#">★</a>
					        <a href="#">★</a>
						</p>
				</div>
				<!-- file -->
	            <div class="form-group">
	            	<label>사진</label>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        <sec:authorize access="isAuthenticated()">
							<input type="file" name="uploadFile" multiple>
						</sec:authorize>
                            
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                       		<div class="form-group uploadResult">
                       			<ul>
                       			</ul>
                       		</div>
                       		<div class="form-group uploadResultCopy" style="display:none;">
                       			<ul>
                       			</ul>
                       		</div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
	            </div>
	            <!-- file end-->
	            <div class="form-group">
					<label>내용</label>
					<input class="form-control" name="reply" value='new reply'>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-primary"
					data-dismiss="modal">수정</button>
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
<!--  이미지 클릭 modal -->

<script>
$(document).delegate('#star_grade a', 'click', function() {
	$(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
    $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
    return false;
})

//다운 or 원본이미지
$('.uploadResult').on('click','li',function(e){
	var liObj = $(this);
	showImage(liObj.data('url'));
});	

function showImage(url){
	$('.bigPictureWrapper').css('display','flex').show();
	$('.bigPicture')
	.html("<img src='"+url+"'>")
	.animate({width:'100%',height:'100%'}, 1000);
}
$('.bigPictureWrapper').on('click',function(e){
	$('.bigPicture').animate({width:'0%',height: '0%'},1000);
	setTimeout(function(){
		$('.bigPictureWrapper').hide();
	},1000);
})
</script>