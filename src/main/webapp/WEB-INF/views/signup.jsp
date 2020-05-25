<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/signup.css">

<div class="cbody my-5">
    <div class="signup_form">
    	<nav> <h1>
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item w-50"><a class="nav-link active btn-outline-dark" id="general">일반회원가입</a></li>
				<li class="nav-item w-50"><a class="nav-link btn-outline-dark" id="gongbang">공방회원가입</a></li>
			</ul>  
			</h1> 
       	</nav>	 
        <form name="signup_form" action="memberInsert" method="post">
            <div class="signup_form_email">
                <div class="signup_form_label">이메일</div>
                <div class="signup_form_input">
                    <div class="input_email form_group">
                        <div class="input_email_local">
                            <input type="email" class="form_input" id="member_ema" name="member_id" placeholder="이메일" size="1" required>
                        </div>
                        <div class="email_chk_btn ml-3">
                           <button type="button" id="email_chk_btn" onclick="email_chk()" value="N" >중복체크</button>
                        </div>
                    </div>
                </div>
                <div class="error_next_box" id="emailMsg" aria-live="assertive"></div>
            </div>
            <div class="signup_form_pass1 form_group">
                <div class="signup_form_label">비밀번호</div>
                <div class="signup_form_input">
                    <input type="password" id="pass1" name="member_pass" class="form_input" placeholder="8자 이상 영문, 숫자, 특수문자를 사용하세요." required>
                </div>
                <div class="error_next_box" id="pass1Msg"aria-live="assertive"></div>
            </div>
            <div class="signup_form_pass2 form_group">
                <div class="signup_form_label">비밀번호 확인</div>
                <div class="signup_form_input">
                    <input type="password" id="pass2" name="member_pass_check" class="form_input" required>
                </div>
                <div class="error_next_box" id="pass2Msg" aria-live="assertive"></div>
            </div>
            <div class="signup_form_name form_group">
               <div class="signup_form_label">이름</div>
                <div class="signup_form_input">
                    <input type="text" id="member_name" name="member_name" class="form_input" required>
                </div>
                <div class="error_next_box" id="nameMsg" aria-live="assertive"></div>
            </div>
            <div class="signup_form_name form_group">
               <div class="signup_form_label">휴대폰</div>
                <div class="signup_form_input">
                    <input type="text" id="member_phone" name="member_phone" class="form_input" required>
                </div>
                <div class="error_next_box" id="phoneMsg" aria-live="assertive"></div>
            </div>
            <div class="signup_form_nickname form_group mt-4">
                <div class="signup_form_label signup_form_nick">별명</div>
                <div class="signup_form_input">
                    <input type="text" id="member_nick" name="member_nick" class="form_input" required>
                    <button type="button" id="nick_chk_btn" onclick="nickname_chk()" value="N">중복체크</button>
                </div>
                <div class="error_next_box" id="nickMsg" aria-live="assertive"></div>
            </div> 
            <div class="signup_form_license form_group">
            	<div class="signup_form_label">사업자 번호</div>
                <!-- <div class="signup_form_input"> 
                </div> -->
            </div>
            
            <div class="signup_form_term form_group">   
                <div class="signup_form_label">약관 동의</div>
                <div class="signup_form_term_body">
                    <div class="form_term">
                        <div class="term_all">
                            <div class="form_check checkbox_input">
                                <label class="form_check_label">
                                    <input type="checkbox" class="form_check" id="check_all" name="CHECK_ALL">
                                    <span class="check_img"></span>
                                    <span class="term_all_text">전체동의</span>
                                </label>
                            </div>
                        </div>
                        <div class="term_list">
                            <div class="term_agree_row">
                                <div class="form_check checkbox_input">
                                    <label class="form_check_label">
                                        <input type="checkbox" class="form_check" id="check_service" name="CHECK_SERVICE">
                                        <span class="check_img"></span>
                                        <span class="term_all_text">이용약관</span>
                                    </label>
                                </div>
                            </div>
                            <div class="term_agree_row">
                                <div class="form_check checkbox_input">
                                    <label class="form_check_label">
                                        <input type="checkbox" class="form_check" id="check_privacy" name="CHECK_PRIVACY">
                                        <span class="check_img"></span>
                                        <span class="term_all_text">개인정보취급</span>
                                    </label>
                                </div>
                            </div>
                            <div class="term_agree_row">
                                <div class="form_check checkbox_input">
                                    <label class="form_check_label">
                                        <input type="checkbox" class="form_check" id="check_mailing" name="CHECK_MAILING">
                                        <span class="check_img"></span>
                                        <span class="term_all_text">이벤트, 프로모션 알림 메일 및 SMS 수신 (선택)</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="error_next_box" id="termMsg" style="display: hidden;" aria-live="assertive"></div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button id="btn_submit" class="signup_form_submit" type="button">회원가입</button>
        </form>
    </div>
</div>
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ready(function(){
	$('.signup_form_license').hide();
	$('.nav-tabs .nav-link').on('click',function(){
		var oper=$(this).attr('id');
		if(oper=='gongbang'){
			console.log(oper);
			$('.signup_form_license').show().append('<input type="text" id="member_license" name="member_license" class="form_input" placeholder="숫자만 입력 10자리">');	
			$('.signup_form_nick').text('공방명');
		}else{
			$('.signup_form_license').hide().find('input').remove();	
			$('.signup_form_nick').text('별명');
		} 
		$('.nav-tabs .nav-link').removeClass('active');
		$(this).addClass('active');
	});
	
	$(document).ajaxSend(function(e,xhr,options){
 		console.log(csrfHeaderName, csrfTokenValue);
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
})
$(document).ready(function(){
	/*  error:function(request,err){ 
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+err)
			alert("ajax통신 실패!!");
	} */
});
  //이메일 중복체크
    function email_chk(){
	  var _str1 = $("#member_ema").val();
		console.log(_str1);
	    if(_str1==""){
	        alertify.alert("경고", "이메일을 입력하세요.");
	        return false;
	    }
      jQuery.ajax({
         url : '/emailChk.su',
         type : "post",
         data : {
            member_id : $("#member_ema").val()
         },
         success : function(retVal) {
        	 console.log(retVal);
            if (retVal == "OK") {
               $("#email_chk_btn").attr("value", "Y");
               alertify.alert("확인", "사용가능한 이메일입니다.");
            } else { // 실패했다면
               alertify.alert("확인","중복된 이메일입니다.");
            }
         }
	      });   
	   };
	   function nickname_chk(){
	      var _str2 = $("#member_nick").val();
	      if(_str2==""){alertify.alert("확인", "별명을 입력하세요.");return false;}
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
   // 비밀번호 정규식(특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식)
   var pwJ = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
   // 이름 정규식
   var nameJ = /^[가-힣]{2,6}$/;
   // 이메일 검사 정규식
   var mailJ = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
   // 휴대폰 번호 정규식
   var phoneJ = /^\d{3}\d{3,4}\d{4}$/;
   // 별명 정규식
   var nickJ = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,15}$/;
   // 숫자 정규식
   var num = /^[0-9]{5}$/;
    
   var sub_email = false;
   var sub_pw1 = false;
   var sub_pw2 = false;
   var sub_name = false;
   var sub_phone = false;
   var sub_nick = false;
   
    function showErrorMsg(obj, msg) {
       obj.attr("class", "error_next_box");
       obj.html(msg);
       obj.show();
    }
    
    var isShift = false;
    
    function checkShiftUp(e) {
        if (e.which && e.which == 16) {
            isShift = false;
        }
    }
    function checkShiftDown(e) {
        if (e.which && e.which == 16) {
              isShift = true;
        }
     }
    function checkCapslock(e) {
        var myKeyCode = 0;
        var myShiftKey = false;
        if (window.event) { // IE
            myKeyCode = e.keyCode;
            myShiftKey = e.shiftKey;
        } else if (e.which) { // netscape ff opera
            myKeyCode = e.which;
            myShiftKey = isShift;
        }
        var oMsg = $("#pass1Msg");
        if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock이 켜져 있습니다.");
        } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock이 켜져 있습니다.");
        } else {
            oMsg.hide();
        }
    }
    function setFocusToInputObject(obj) {
        if(submitFlag) {
            submitFlag = false;
            obj.focus();
        }
    }
    $("#member_ema").blur(function(){
        checkEmail1("first");
    });
    $("#member_name").blur(function(){
        checkName();
    });
    
    $("#pass1").blur(function(){
        checkPass1();
    }).keyup(function(event){
        checkShiftUp(event);
    }).keypress(function(event){
        checkCapslock(event);
    }).keydown(function(event){
        checkShiftDown(event);
    });
    
    $("#pass2").blur(function(){
        checkPass2();
    }).keyup(function(event){
        checkShiftUp(event);
    }).keypress(function(event){
        checkCapslock(event);
    }).keydown(function(event){
        checkShiftDown(event);
    }); 
    
    $("#member_nick").blur(function(){
        checkNick();
    });
    
    $("#member_phone").blur(function(){
        checkPhone();
    });
    
    function checkEmail1(event) {
        var member_email = $("#member_ema").val();
        var oMsg = $("#emailMsg");
        var input1 = $("#member_ema");
        if (member_email=="") {
            showErrorMsg(oMsg, "필수 정보입니다.");
            return false;
        } else if(!mailJ.test(member_email)) {
         showErrorMsg(oMsg, "이메일 형식을 확인하고 다시 입력해주세요.");
         $("#member_ema").focus();
         
         return false;
          
      } else {
           oMsg.hide();
           sub_email = true;
           
           return true;
        }
    }
    
    function checkPass1(event) {
        var pass1 = $("#pass1").val();
        var oMsg = $("#pass1Msg");
        var oInput = $("#pass1");
        
        if (pass1=="") {
            showErrorMsg(oMsg, "필수 정보입니다.");
            setFocusToInputObject(oInput);
            return false;
        } else if(!pwJ.test(pass1)) {
         showErrorMsg(oMsg, "8자 이상 영문+숫자+하나 이상의 특수문자를 사용하세요.");
         oInput.focus();
         
         return false;
       } else {
           oMsg.hide();
           sub_pw1 = true;
           
           return true;
        }
    }
    
    function checkPass2(event) {
        var email = $("#member_email").val();
        var pass1 = $("#pass1").val();
        var pass2 = $("#pass2").val();
        var oMsg = $("#pass2Msg");
        var oInput = $("#pass2");
        
        if (pass2=="") {
            showErrorMsg(oMsg, "필수 정보입니다.");
            setFocusToInputObject(oInput);
            return false;
        } else {
           oMsg.hide();
        }
        
        if (pass1 != pass2) {
            showErrorMsg(oMsg,"비밀번호가 일치하지 않습니다.");
            setFocusToInputObject(oInput);
            return false;
        } else {
            oMsg.hide();
            sub_pw2 = true;
            
            return true;
        }
    }
    
    function checkName(event) {
       var name = $("#member_name").val();
       var oMsg = $("#nameMsg");
       var oInput = $("#member_name");
       
       if(name == "") {
          showErrorMsg(oMsg, "필수 정보입니다.");
          
          return false;
       } else {
          oMsg.hide();
          sub_name = true;
          
          return true;
       }
    }
    
    function checkPhone(evnet) {
       var phone = $("#member_phone").val();
        var oMsg = $("#phoneMsg");
        
        if(phone==""){
           showErrorMsg(oMsg, "필수 정보입니다.");
            return false;
        }  else if(!phoneJ.test(콜)) {
         showErrorMsg(oMsg, "올바른 번호를 입력하세요.");
         $("#member_phone").focus();
         
         return false;
          
      } else {
         oMsg.hide();
         sub_phone = true;
         
            return true;
      }
    }
    
    function checkNick(event) {
        var nick = $("#member_nick").val();
        var oMsg = $("#nickMsg");
        var oInput = $("#member_nick");
        var checkLength = /^[가-힣A-Za-z0-9_]{2,12}$/;
        
        if (nick=="") {
            showErrorMsg(oMsg, "필수 정보입니다.");
            return false;
        } else {
            oMsg.hide();
            sub_nick = true;
        }
        if (!checkLength.test(nick)) {
            showErrorMsg(oMsg, "별명은 최소 2자, 최대 12자 까지 입력가능 합니다.[특수문자 불가]");
            setFocusToInputObject(oInput);
            sub_nick = false;
            
            return false;
        } else {
           oMsg.hide();
           sub_nick = true;
           
           return true;
        }
    }
    
    function checkterm() {
        var res = true;
        var oMsg = $("#termMsg");
    if ($("#check_service").is(":checked") == false || $("#check_privacy").is(":checked") == false) {
        showErrorMsg(oMsg, "이용약관과 개인정보 수집 및 이용에 대한 안내 모두 동의해주세요.");
        res = false;
    } else {
        oMsg.hide();
    }
    return res;
    }
    
    function mainSubmit() {
        if(emailFlag && passFlag && nickFlag) {
            $("#join_form").submit();
        } else {
            submitOpen();
            return false;
        }
    }
    //약관 전체 승인
    function setTerms() {
        if ($("#check_all").is(":checked")) {
            $("#check_service").prop("checked",true);
            $("#check_privacy").prop("checked",true);
            $("#check_mailing").prop("checked",true);
        } else {
            $("#check_service").prop("checked",false);
            $("#check_privacy").prop("checked",false);
            $("#check_mailing").prop("checked",false);
        }
    }
    function viewterm_() {
    if( !$("#check_service").is(":checked") || !$("#check_privacy").is(":checked") || !$("#check_mailing").is(":checked")) {
        $("#check_all").prop("checked",false);
    }
    if( $("#check_service").is(":checked") && $("#check_privacy").is(":checked") && $("#check_mailing").is(":checked")) {
        $("#check_all").prop("checked",true);
    }
    return true;
    }
        
    $(document).ready(function(){
        $("#check_all").prop("checked",false);
        setTerms();
        $("#check_all").click(function() {
            setTerms();
        })
        $("#check_service").click(function() {
            viewterm_();
        })
        $("#check_privacy").click(function() {
            viewterm_();
        })
        $("#check_mailing").click(function() {
             viewterm_();
        })
    });
    
    
    //중복확인 버튼, 약관동의
    
    $('#btn_submit').click(function(){
     var nicknamecheckBtn = $("#nick_chk_btn").val();
     var emailcheckBtn = $("#email_chk_btn").val();
     var email = $("#member_ema").val();
     var nick = $("#member_nick").val();
     var pass1 = $("#pass1").val();
     var pass2 = $("#pass2").val();
     var name = $("#member_name").val();
     var phone = $("#member_phone").val();
     
     if(email=="" || nick=="" || pass1=="" || pass2=="" || name=="" || phone==""){
        alertify.alert("경고", "빈 칸 없이 입력해주세요.");return;
     }else if(emailcheckBtn == "N") {
        alertify.alert("경고", "이메일 중복확인 버튼을 눌러주세요.");return;
     }else if(emailcheckBtn == "Y") {
        if(nicknamecheckBtn == "N"){
           alertify.alert("경고", "닉네임 중복확인 버튼을 눌러주세요.");return;
        }else if(nicknamecheckBtn == "Y"){
           if(($('#check_privacy').prop("checked")&&$('#check_service').prop("checked"))== false) 
           {
              alertify.alert("경고", '약관에 동의해주세요.');return;
           } else  {
             alertify.alert("확인", "인증을 위한 메일이 발송되었습니다.");
              document.signup_form.submit();
           }
        }
     }
    // document.signup_form.submit();
	});
</script>
<%@include file="includes/footer.jsp" %>