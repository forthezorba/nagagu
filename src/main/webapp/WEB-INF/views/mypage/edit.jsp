<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 우편번호 찾기 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/signup.css">
<link rel="stylesheet" href="/resources/css/mypage/like.css">
<%@include file="../mypage/common.jsp" %>
<div class="cbody container bg-light">
    <div class="signup_form">
    	<nav> <h1>
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item w-50"><a class="nav-link active" id="general">회원 수정</a></li>
			</ul>  
			</h1> 
       	</nav>	 
        <form name="edit_member_form" action="/memberEdit" method="post">
            <div class="signup_form_email">
                <div class="signup_form_label">이메일</div>
                <div class="signup_form_input">
                     <div class="input_email_local">
                         <input type="email" class="form_input" id="member_ema" name="member_id"
                         value="<sec:authentication property="principal.member.member_id"/>" readonly>
                     </div>
                </div>
            </div>
            <div class="signup_form_name form_group">
               <div class="signup_form_label">이름</div>
                <div class="signup_form_input">
                    <input type="text" id="member_name" name="member_name" class="form_input"
                    value="<sec:authentication property="principal.member.member_name"/>">
                </div>
                <div class="error_next_box" id="nameMsg" aria-live="assertive"></div>
            </div>
            <div class="signup_form_name form_group">
               <div class="signup_form_label">휴대폰</div>
                <div class="signup_form_input">
                    <input type="text" id="member_phone" name="member_phone" class="form_input"
                    value="<sec:authentication property="principal.member.member_phone"/>">
                </div>
                <div class="error_next_box" id="phoneMsg" aria-live="assertive"></div>
            </div>
            <div class="signup_form_nickname form_group mt-4">
                <div class="signup_form_label signup_form_nick">별명</div>
                <div class="signup_form_input">
                    <input type="text" id="member_nick" name="member_nick" class="form_input"
                    value="<sec:authentication property="principal.member.member_nick"/>">
                    <button type="button" id="nick_chk_btn" onclick="nickname_chk()" value="N">중복체크</button>
                </div>
                <div class="error_next_box" id="nickMsg" aria-live="assertive"></div>
            </div> 
            <div class="signup_form_picture form_group">
               <div class="signup_form_label">프로필 사진</div>
                <div class="image-upload">
					<div class="form-group member_picture">
                  		<input type="file" name="mainImage" id="profile_img">
                  		<p> * 정사각형 이미지 추천</p>
                  		<!-- for attach & show -->
                  		<div class="form-group uploadResult text-center">
                  			<ul><li>
                  			<img src="<sec:authentication property="principal.member.member_picture"/>">
                  			</li></ul>
                  		</div>
					</div>
				</div>
            </div>
            
             <div class="signup_form_zip form_group">
               <div class="signup_form_label">우편번호</div>
                <div class="signup_form_input">
					<div class="address_zip_div ">
						<input type="text"  id="ADDRESS_ZIP" name="address_zip" readonly="readonly" 
						 value="<sec:authentication property="principal.member.address_zip"/>" class="zipcode">
					</div>
					<div class="btn_address_zip btn-sm">
						<button type="button" id="address_btn" class="zipcode_button" onclick="openZipSearch()">주소검색</button>
					</div>
				</div>
				<div class="edit_member_form_input">
					<input type="text" id="ADDRESS_ADDRESS1" name="address_address1" 
					 value="<sec:authentication property="principal.member.address_address1"/>" placeholder="기본주소" class="form_input" readonly>
				</div>
				<div class="edit_member_form_input">
					<input type="text" id="ADDRESS_ADDRESS2" name="address_address2" 
					 value="<sec:authentication property="principal.member.address_address2"/>" placeholder="상세주소" class="form_input">
				</div>
            </div>
            <div class="signup_form_license form_group">
            	<div class="signup_form_label">사업자 번호</div>
            </div>
            <div class="error_next_box" id="termMsg" style="display: hidden;" aria-live="assertive"></div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button id="btn_submit" class="signup_form_submit" type="button">수정</button>
        </form>
    </div>
</div> 
<!-- <script type="text/javascript" src="/resources/js/store/file.js"></script> -->
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
var originalNick = $('#member_nick').val();

$(document).ajaxSend(function(e,xhr,options){
	console.log(csrfHeaderName, csrfTokenValue);
xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
$(document).ready(function() {
	if($('#ADDRESS_ZIP').val()==0){
		$('#ADDRESS_ZIP').val('');
		$('#ADDRESS_ADDRESS1').val('');
		$('#ADDRESS_ADDRESS2').val('');
	}
})
	  // 우편번호 주소검색
	function openZipSearch() { 
	   new daum.Postcode({
	      oncomplete: function(data) {
	         $('[name=address_zip]').val(data.zonecode); // 우편번호 (5자리)
	         $('[name=address_address1]').val(data.address);   // 기본주소
	         $('[name=address_address2]').val(data.buildingName);   // 상세주소
	         $('[name=address_address2]').focus();
	         console.log(data);
	      }
	   }).open();
	}


	function nickname_chk(){
	    var checkLength = /^[가-힣A-Za-z0-9]{2,12}$/;
			var str2 = $("#member_nick").val();
		      if(str2==""){
		    	  alertify.alert("최소 2자 이상 입력하세요.");
		    	  return false;
		      }
	     if (!checkLength.test(str2)) {alertify.alert("입력한 정보를 다시 확인하고 누르세요.");return false;}
	     if($("#member_nick").val() == originalNick ){
	    	 alertify.alert("현재 닉네임입니다.(가능) ");
	    	 $("#nick_chk_btn").attr("value", "Y");
	    	 return false;
	     }
	     jQuery.ajax({  
	         url : '/nicknameChk.su',
	         type : "post",
	         data : {
	            member_nick : $("#member_nick").val()
	         },
	         success : function(retVal) {
	            if (retVal == "OK") {
	               $("#nick_chk_btn").attr("value", "Y");
	               alertify.alert("확인","사용가능한 별명입니다.");
	            } else { // 실패했다면
	               alertify.alert("확인","중복된 별명입니다.");
	            }
	         }
         });	
	}
	$('input[type="file"]').change(function(e){ 
		console.log('hi');
        var files = $('#profile_img')[0].files;
        var formData = new FormData();
        
        for(var i=0; i<files.length; i++){
			formData.append("data",files[i]);
		}
        formData.append("category",'profile');
        $.ajax({
            type: 'POST',
            url: '/uploadAWS',  
            data: formData, 
            dataType: 'json',
            processData: false,
            contentType: false
        }).done(function (data) {
        	console.log(data);
        	var str='';
        	$(data).each(function(i,obj){
        		str += "<img src="+obj.url+">"
        	})
            $('.uploadResult ul li').html(str);
        }).fail(function (error) { 
            alert(error);
        })
    });
	
$(document).ready(function() {
	$('#btn_submit').click(function(){
		var nick = $("#member_nick").val();
		var nick_chk = $("#nick_chk_btn").val();
		var zip_code = $('.zipcode').val();
		var address1 = $('[name=address_address1]').val();
		var address2 = $('[name=address_address2]').val();
		
		if(nick_chk == "N"){
			alertify.alert("별명을 다시 확인하세요.");
			return false;
		} else if(nick_chk =="N") {
			alertify.alert("중복체크 버튼을 다시 한번 눌러주세요.");
			return false;
		} else if(zip_code==0){
			alertify.alert("주소를 입력해주세요.");
			return false;
		}
		
		//메인이미지(db저장용)-
		var src= $('.uploadResult ul li img').attr('src');
		var str = $('.member_picture').html('<input type="hidden" name="member_picture" value="'+src+'">');
		document.edit_member_form.submit();
	}); 
	 
	$('.card-wrap').children().eq(2).css('background-color','#ef900e').children().css('color','white');
});
</script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script> 

<%@include file="../includes/footer.jsp" %> 