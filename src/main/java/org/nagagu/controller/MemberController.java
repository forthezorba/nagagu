package org.nagagu.controller;

import java.io.PrintWriter;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.nagagu.domain.MemberVO;
import org.nagagu.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/*import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.nagagu.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;*/

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
public class MemberController {
	@Autowired(required = false)
	private MemberService memberService;
	@Autowired(required = false)
	private JavaMailSender mailSender;
	@Autowired(required = false)
	private PasswordEncoder passwordEncoder;

	@PostMapping(value = "/memberInsert")
	public String memberInsert(MemberVO memberVO, RedirectAttributes redirect) {
		log.info("memberinsert.."+memberVO);
		
		memberVO.setMember_pass(passwordEncoder.encode(memberVO.getMember_pass()));
		redirect.addAttribute("email", memberVO.getMember_id());
		
		return memberService.insert_member(memberVO)!=0 ? "redirect:/mailSending":"redirect:/signup";
	}
	@RequestMapping(value = "/memberEdit")
	public String memberEdit(MemberVO memberVO, RedirectAttributes redirect) {
		log.info("memberEdit.."+memberVO);
		int result = memberService.update_member(memberVO);
		if(result != 0) {
			return ("redirect:/customLogin?logout");
		}
		return("redirect:/signup");	//실패시 회원가입 창으로 이동
	}
	
	// mailSending 코드
    @RequestMapping(value = "/mailSending")
    public String mailSending(@RequestParam("email") String email) {
    	log.info("mailSending..."+email);
      String setfrom = "nagagu@gmail.com";  //host 메일 주소
      String title = "NAGAGU 인증메일";	//메일 이름
      String content= "아래 링크를 클릭하세요" + "\n" + "nagagu.ga/mailLink?member_id="+email;	//내용
     
      try {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper messageHelper 
                          = new MimeMessageHelper(message, true, "UTF-8");
   
        messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
        messageHelper.setTo(email);     // 받는사람 이메일
        messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
        messageHelper.setText(content);  // 메일 내용
       
        mailSender.send(message);
      } catch(Exception e){
        System.out.println(e);
      }
      return "redirect:/";
    }
    
    @RequestMapping(value = "/mailLink")
    public String mealLink(HttpServletResponse response, MemberVO memberVO) {
    	log.info("mailLink......");
    	response.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter writer;
        log.info("mailLink..."+memberVO);
        try {
           writer = response.getWriter();
           int res = memberService.emailLink_chk(memberVO);
           if(res == 1) {
        	   writer.write("<script>alert('인증 성공'); location.href='/';</script>");
           }
        } catch (Exception e) {
           e.printStackTrace(); 
        }
        return null;
    }
    
	@PostMapping(value = "/emailChk.su")
	public 	@ResponseBody String emailChk(MemberVO memberVO) {
		return memberService.email_chk(memberVO)==0 ? "OK":"FAIL";
	}
	@PostMapping(value = "/nicknameChk.su")
	public 	@ResponseBody String nicknameChk(MemberVO memberVO) {
		log.info("check nick..."+memberVO);
		return memberService.nickname_chk(memberVO)==0 ? "OK":"FAIL";
	}
}
