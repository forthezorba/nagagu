package org.nagagu.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.nagagu.domain.AuthVO;
import org.nagagu.domain.MemberVO;
import org.nagagu.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	/* NaverLoginBO 
    //private NaverLoginBO naverLoginBO;
    private String apiResult = null;
    
    @Autowired(required = false)
    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }
	
	@Autowired(required = false)
	private MemberService memberService;
	
	@Autowired
	private MainService Mainservice;
	
	@Autowired
	private WorkShopMemberService workShopMemberService;
	
	*/

    /*
	
	@RequestMapping(value = "/signup.ma")
	public ModelAndView signup(Model model, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		// 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 
	    String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
	    System.out.println("네이버:" + naverAuthUrl);
	    model.addAttribute("naver_url", naverAuthUrl);
      
	    //카카오 인증 url을 view로 전달
	    String kakaoUrI = KakaoController.getAuthorizationUri(session);
	    System.out.println("카카오: "+ kakaoUrI);
	    model.addAttribute("kakao_url", kakaoUrI);
	    
	    mav.setViewName("signup");
	    
		return mav;
	}
	
    @RequestMapping("/logout.ma")
    public ModelAndView logout(HttpSession session) {
        session.invalidate();
        ModelAndView mv = new ModelAndView("redirect:/");
        return mv;
    }
    

	@RequestMapping(value = "/index.ma", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView Index(Model model, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		// 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 
	    String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
	    System.out.println("네이버:" + naverAuthUrl);
	    model.addAttribute("naver_url", naverAuthUrl);
      
	    //카카오 인증 url을 view로 전달
	    String kakaoUrI = KakaoController.getAuthorizationUri(session);
	    System.out.println("카카오: "+ kakaoUrI);
	    model.addAttribute("kakao_url", kakaoUrI);
        //네이버 
        mav.setViewName("index");
		return mav;
	}

	//네이버 로그인 성공시 callback호출 메소드
    @RequestMapping(value = "/callback.ma", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, HttpServletRequest request)
            throws IOException, ParseException {
    	
    	int email_check = 0;
    	int result = 0;
    	MemberVO memberVO = new MemberVO();
    	
    	//정보동의 취소시 이전페이지로 이동
    	if(code.equals("0")) {
    		return "index.ma";
    	}
        System.out.println("여기는 callback");
        
        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        
        //로그인 사용자 정보를 읽어온다.
        apiResult = naverLoginBO.getUserProfile(oauthToken);
        System.out.println(naverLoginBO.getUserProfile(oauthToken).toString());
        
        model.addAttribute("result", apiResult);
        System.out.println("result"+apiResult);
        // 네이버 로그인 성공 페이지 View 호출 
        
        //2. String형식인 apiResult를 json형태로 바꿈
        JSONParser parser = new JSONParser();
        Object obj = parser.parse(apiResult);
        JSONObject jsonObj = (JSONObject) obj;
        
		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱
		String nickname = (String) response_obj.get("nickname");
		String img = (String) response_obj.get("profile_image");
		String email = (String) response_obj.get("email");
		String name = (String) response_obj.get("name");
		
		System.out.println(nickname+" "+img+"  "+email+" "+name);
		
		try {
			memberVO.setMEMBER_NICK(nickname);
			memberVO.setMEMBER_EMAIL(email);
			
			email_check = memberService.email_chk(memberVO);
			
			if(email_check == 0 ) {	//이메일 중복이 없을 때 
				ArrayList<MemberVO> memberList = memberService.get_nick_list();
				
				for(int i=0; i<memberList.size(); i++) {
					if(nickname.equals(memberList.get(i).getMEMBER_NICK())) {
						//닉네임 중복
						double random =  Math.random() * 10000;
						nickname += (int)random;
						
						memberVO.setMEMBER_NICK(nickname);
					}
					break;
				}
				
				memberVO.setMEMBER_PICTURE(img);
				memberVO.setMEMBER_NAME(name);
				memberVO.setMEMBER_PASS("naver_pw");
				memberVO.setMEMBER_STATUS(1);
				result = memberService.insert_sns_member(memberVO);
				
				if(result != 0) {	//성공
					session.setAttribute("MEMBER_EMAIL", memberVO.getMEMBER_EMAIL());
					session.setAttribute("MEMBER_PASS", memberVO.getMEMBER_PASS());
					session.setAttribute("MEMBER_NICK", memberVO.getMEMBER_NICK());
					session.setAttribute("MEMBER_NAME", memberVO.getMEMBER_NAME());
					session.setAttribute("MEMBER_NUM", memberVO.getMEMBER_NUM());
				} else {
					System.out.println("sns 회원가입 컨트롤러 실패");
				}
			} else {	//등록된 회원
				session.setAttribute("MEMBER_EMAIL", memberVO.getMEMBER_EMAIL());
				session.setAttribute("MEMBER_NICK", memberVO.getMEMBER_NICK());
				session.setAttribute("MEMBER_NAME", memberVO.getMEMBER_NAME());
				session.setAttribute("MEMBER_NUM", memberVO.getMEMBER_NUM());
				
				System.out.println("sns 등록된 회원 이름" + memberVO.getMEMBER_NAME());
				
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
        return "redirect:/index.ma";
    }
    
    //카카오 로그인 성공
    @RequestMapping(value = "/kakaologin.ma", method = { RequestMethod.GET, RequestMethod.POST })
    public String kakaoLogin(Model model, @RequestParam String code, HttpSession session, HttpServletRequest request)
            throws Exception {
    	int email_check = 0;
    	int result = 0;
    	MemberVO memberVO = new MemberVO();
    	//결과값을 node에 담아줌
    	JsonNode node = KakaoController.getAccessToken(code);
    	//accessToken에 사용자의 로그인한 모든 정보가 들어있음
    	JsonNode accessToken = node.get("access_token");
    	//사용자의 정보
    	JsonNode userInfo = KakaoController.getKaKaoUserInfo(accessToken);
    	
    	String email = null;
    	String img = null;
    	String nickname = null;
    	
    	//유저정보 카카오에서 가져오기 Get properties
    	JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");
		email = kakao_account.path("email").asText();
		nickname = properties.path("nickname").asText();
		img = properties.path("profile_image").asText();
		System.out.println(nickname+" "+img+"  "+email);
	
		try {
			memberVO.setMEMBER_NICK(nickname);
			memberVO.setMEMBER_EMAIL(email);
			memberVO.setMEMBER_NAME(nickname);
			
			email_check = memberService.email_chk(memberVO);
			
			if(email_check == 0 ) {	//이메일 중복이 없을 때 
				ArrayList<MemberVO> memberList = memberService.get_nick_list();
				
				for(int i=0; i<memberList.size(); i++) {
					if(nickname.equals(memberList.get(i).getMEMBER_NICK())) {
						//닉네임 중복
						double random =  Math.random() * 10000;
						nickname += (int)random;
						
						memberVO.setMEMBER_NICK(nickname);
						break;
					}
				}
				
				memberVO.setMEMBER_PICTURE(img);
				memberVO.setMEMBER_PASS("kakao_pw");
				memberVO.setMEMBER_STATUS(1);
				result = memberService.insert_sns_member(memberVO);
				
				if(result != 0) {	//성공
					session.setAttribute("MEMBER_EMAIL", memberVO.getMEMBER_EMAIL());
					session.setAttribute("MEMBER_PASS", memberVO.getMEMBER_PASS());
				} else {
					System.out.println("sns 회원가입 컨트롤러 실패");
				}
			} else {	//등록된 회원
				session.setAttribute("MEMBER_EMAIL", memberVO.getMEMBER_EMAIL());
				session.setAttribute("MEMBER_NICK", memberVO.getMEMBER_NICK());
				session.setAttribute("MEMBER_NAME", memberVO.getMEMBER_NAME());
				session.setAttribute("MEMBER_NUM", memberVO.getMEMBER_NUM());
				
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/index.ma";
	}
	
    @RequestMapping(value = "/deleteMember.ma")
	public ModelAndView deleteMember(MemberVO memberVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			int res = memberService.duplicateMember(memberVO);
			int res2 = memberService.sysdateMember(memberVO);
			
			if ( res == 1 && res2 == 1) {
				System.out.println("멤버 정보 이동 성공!");
				int del = memberService.deleteMember(memberVO);
				
				System.out.println("멤버 삭제 성공!");
				
				session.invalidate();
				mav.setViewName("index");
				mav.addObject("message", "탈퇴처리 되었습니다. 그동안 NAGAGU를 이용해주셔서 감사합니다.");
			}
		} catch(Exception e) {
			System.out.println("멤버삭제 실패!!!" + e.getMessage());
		}
		return mav;
	}
    
    @RequestMapping(value = "/deleteWMember.ma")
	public ModelAndView deleteWMember(WorkShopMemberVO workshopVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			int res = workShopMemberService.duplicateWMember(workshopVO);
			int res2 = workShopMemberService.sysdateWMember(workshopVO);
			
			if ( res == 1 && res2 == 1) {
				System.out.println("공방멤버 정보 이동 성공!");
				int del = workShopMemberService.deleteWMember(workshopVO);
				System.out.println("공방멤버 삭제 성공!");
				
				session.invalidate();
				mav.setViewName("index");
				mav.addObject("message", "탈퇴처리 되었습니다. 그동안 NAGAGU를 이용해주셔서 감사합니다.");
			}
		} catch(Exception e) {
			System.out.println("멤버삭제 실패!!!" + e.getMessage());
		}
		return mav;
	}
    
    @RequestMapping(value="/FindMember.ma")
    public ModelAndView findMember(Model model, HttpSession session) {
    	ModelAndView mav = new ModelAndView();
    	
    	// 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 
	    String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
	    System.out.println("네이버:" + naverAuthUrl);
	    model.addAttribute("naver_url", naverAuthUrl);
      
	    //카카오 인증 url을 view로 전달
	    String kakaoUrI = KakaoController.getAuthorizationUri(session);
	    System.out.println("카카오: "+ kakaoUrI);
	    model.addAttribute("kakao_url", kakaoUrI);
    	
    	mav.setViewName("FindMember");
    	return mav;
    }
    
    @RequestMapping(value="/FindMemberPw.ma", method = RequestMethod.POST)
    public String findMemberPw(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response) {
    	String email = (String)request.getParameter("MEMBER_EMAIL");
    	String password = null;
    	int update_pw = 0;
    	
    	MemberVO memberVO = new MemberVO();
    	memberVO.setMEMBER_EMAIL(email);
    	memberVO.setMEMBER_NAME((String)request.getParameter("MEMBER_NAME"));
    	
    	System.out.println(memberVO.getMEMBER_EMAIL() + memberVO.getMEMBER_NAME());
    	
		int result = memberService.findMemberPW(memberVO);
		
		if(result != 0) {
			StringBuffer temp = new StringBuffer();
			Random rnd = new Random();
			for (int i = 0; i < 14; i++) {
			    int rIndex = rnd.nextInt(3);
			    switch (rIndex) {
			    case 0:
			        // a-z
			        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
			        break;
			    case 1:
			        // A-Z
			        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
			        break;
			    case 2:
			        // 0-9
			        temp.append((rnd.nextInt(10)));
			        break;
			    }
			}
			password = temp.toString();
			memberVO.setMEMBER_PASS(password);
			
			update_pw = memberService.updateMemberPW(memberVO);
			if(update_pw != 0) {
				redirect.addAttribute("MEMBER_EMAIL", email);
				redirect.addAttribute("ps", password);
				
				return ("redirect:/updateMailSending.ma");
			}
			
		} else {
			
			try {
				response.setCharacterEncoding("utf-8");
		        response.setContentType("text/html; charset=utf-8");
		        PrintWriter writer;
		        writer = response.getWriter();
		        System.out.println("결과값이 0 인데 왜 alert창이 실행 안됨?");
				writer.println("<script>alert('가입한 회원 정보가 없습니다.'); location.href='FindMember.ma';</script>");
				writer.flush();
				
			} catch(Exception e) {
				System.out.println("비밀번호 찾기 회원정보 보기 실패!");
				e.getMessage();
			}
			
		}
		
		return null;	//실패시 회원가입 창으로 이동
    }
    
 // mailSending 코드
    @RequestMapping(value = "/updateMailSending.ma")
    public String updateMailSending(HttpServletRequest request, RedirectAttributes redirect, @RequestParam("ps") String password, @RequestParam("MEMBER_EMAIL") String email) {
     
      String setfrom = "jieunkim.itit@gmail.com";  //host 메일 주소
      String title = "NAGAGU 비밀번호 재설정";	//메일 이름
      String content1= "http://192.168.0.37:8000/NAGAGU/mailUpadteLink.ma?mm=" + email;	//내용
      String content2="임시비밀번호: " + password;
      String content3="비밀번호 변경창이 사라졌을 경우 아래 링크를 클릭해주세요." + "\n";
     
      try {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper messageHelper 
                          = new MimeMessageHelper(message, true, "UTF-8");
   
        messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
        messageHelper.setTo(email);     // 받는사람 이메일
        messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
        messageHelper.setText(content3 + content1+ "\n"+ "\n"+ "\n" + content2);  // 메일 내용
       
        mailSender.send(message);
        
        redirect.addAttribute("ps", password);
        redirect.addAttribute("mm", email);
        
      } catch(Exception e){
        System.out.println(e);
      }
     
      return "redirect:/mailUpadteLink.ma";
    }
    
    @RequestMapping(value = "/mailUpadteLink.ma", method = RequestMethod.GET)
    public ModelAndView mailUpadteLink(HttpServletRequest request, HttpServletResponse response, MemberVO memberVO,
    		Model model, HttpSession session, RedirectAttributes redirect) {
    	ModelAndView mav = new ModelAndView();
    	
    	//네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 
	    String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
	    System.out.println("네이버:" + naverAuthUrl);
	    model.addAttribute("naver_url", naverAuthUrl);
      
	    //카카오 인증 url을 view로 전달
	    String kakaoUrI = KakaoController.getAuthorizationUri(session);
	    System.out.println("카카오: "+ kakaoUrI);
	    model.addAttribute("kakao_url", kakaoUrI);
    	
    	
    	String member_email = request.getParameter("mm");
    	memberVO.setMEMBER_EMAIL(member_email);
    	System.out.println("pw 찾기 인증");
    	System.out.println(request.getParameter("mm"));
    	
    	
    	response.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter writer;
        
        try {
           writer = response.getWriter();
           writer.write("<script>alertify.alert('이메일을 확인 해주세요.');</script>");
           redirect.addAttribute("MEMBER_EMAIL", request.getParameter("mm"));
           mav.addObject("memberVO", memberVO);
           mav.setViewName("FindPWForm");
           
        } catch (Exception e) {
           e.printStackTrace(); 
        }
     
        return mav;
    }
    
    @RequestMapping(value="/FindPw.ma", method = RequestMethod.POST)
    public String findPw(Model model, HttpServletRequest request, MemberVO memberVO) {
    	String pass2 = (String)request.getParameter("MEMBER_PASS2");
    	String email = (String)request.getParameter("MEMBER_EMAIL");
    	int result = 0;
    	System.out.println(123);
    	memberVO.setMEMBER_PASS(pass2);
    	memberVO.setMEMBER_EMAIL(email);
    	
    	try {
    		System.out.println(pass2+email);
    		result = memberService.updateMemberPW(memberVO);
    		
    		if(result != 0) {
    			System.out.println("비밀번호 찾기 - 변경 성공");
    			return "redirect:/index.ma";
    		}
    	} catch (Exception e) {
    		e.getMessage();
    	}
    	
    	return "FindPWForm";
    	
    }
    
    @RequestMapping(value="/FindMemberEmail.ma", method = RequestMethod.GET)
    public ModelAndView findMemberEmail(HttpServletRequest request, MemberVO memberVO, HttpServletResponse response) {
    	MemberVO member = new MemberVO();
    	ModelAndView mav = new ModelAndView();
        
    	System.out.println("값 체크1: "+(String)request.getParameter("MEMBER_NAME"));
    	System.out.println("값 체크2: "+(String)request.getParameter("MEMBER_PHONE"));
    	memberVO.setMEMBER_NAME((String)request.getParameter("MEMBER_NAME"));
    	memberVO.setMEMBER_PHONE((String)request.getParameter("MEMBER_PHONE"));
    	
    	member = memberService.findMemberEmail(memberVO);
        System.out.println(member);
        	
        mav.addObject("memberVO", member);
        mav.setViewName("Admin/Info/FindEmail");
    	
    	
    	return mav;
    }
    
    */
}
