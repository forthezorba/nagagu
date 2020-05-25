<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/footer.css">
<!-- bootstrap js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	  
    
<div id="footer2" style="border-top: 4px solid #ef900e !important;">
    <div class="copyright">
        <ul class="sns">
	        <li><a href="#"><img src="<%=request.getContextPath()%>/resources/images/sns1.png"></a></li>
	        <li><a href="#"><img src="<%=request.getContextPath()%>/resources/images/sns2.png"></a></li>
	        <li><a href="#"><img src="<%=request.getContextPath()%>/resources/images/sns3.png"></a></li>
	        <li><a href="#"><img src="<%=request.getContextPath()%>/resources/images/sns4.png"></a></li>
        </ul>
        <ul>
	        <li>상호명 : <a href="./login.ad">NAGAGU</a></li>
	        <li class="line">/</li>
	        <li>대표 : 비트캠프</li>
	        <li class="line">/</li>
	        <li>전화 : 02-0000-0000</li>
	        <li class="line">/</li>
	        <li>사업자등록번호 : 119-86-91245</li>
	        <li class="line">/</li>
	        <li>E-mail : email@mail.com</li>
	        <li class="line">/</li>
	        <li><a href="./mypage_support.my">고객센터</a></li>
	        <sec:authorize access="isAuthenticated()">
				<li><a data-toggle="modal" data-target="#deleteMemberModal" class="btn_mypage" style="cursor: pointer;">회원탈퇴</a></li>
   			</sec:authorize>
	        <li class="copy">Copyright &copy; Design Bitcamp All rights reserved.</li>
        </ul>
    </div>
</div>
		
<div class="modal fade" id="deleteMemberModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">회원 탈퇴하기</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form name="deleteForm" action="./deleteMember.ma" method="post">
				<div class="modal-body">
					<p> 이용해주셔서 감사합니다. 항상 노력하는 NAGAGU가 되겠습니다. </p>
					<p> <h4>회원탈퇴 후 회원정보 보존기간</h4></p>
					<p> - 회원님의 재가입 여부 판단을 이유로 30일간 최소 정보 아이디, </p>
					<p>&nbsp;&nbsp;&nbsp;이름을 제외하고 모두 삭제되며, 31일 이후 자동 삭제됩니다. </p>
					<p> - 전자상거래법에 따라 아이디 및 구매정보에 대한 기록은 5년간 보관되며, </p>
					<p>&nbsp;&nbsp;&nbsp;이후 자동 삭제됩니다. </p>
					<p> - 단, 회원님의 탈퇴요청 접수 후 데이터 처리상 48시간 이내</p> 
					<p>&nbsp;&nbsp;&nbsp;e-mail/SMS 발송이 중지 됩니다.</p>
					<p> <h4>회원탈퇴 후 재가입 안내</h4></p>
					<p> - 기존에 사용하시던 아이디로는 재가입이 불가능합니다. </p>
					<p>&nbsp;&nbsp;&nbsp;신규 아이디로 재가입해주세요. </p>
					<div class="form-group">
						<label for="recipient-name" class="email">이메일</label>
						<sec:authorize access="isAuthenticated()">
							<input type="text" class="form-control" name="member_id" 
							value="<sec:authentication property="principal.username"/>" readonly>
			   			</sec:authorize>
						
					</div>
				</div> 
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-dark cancel" data-dismiss="modal">취소</button>
					<input type="button" class="btn btn-outline-dark delete_member" onclick="check_pw();" value="탈퇴">
				</div>
			</form>
		</div>
	</div>
</div>

	  </div>
      <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>
<script>
function check_pw(){
	alertify.confirm('확인', '정말 탈퇴하시겠습니까?', function(){ 
		alertify.alert("경고", "그동안 이용해주셔서 감사합니다.");
	}
    ,function(){ 
    	alertify.error('Cancel')
    	}
    );
}
</script>