package org.nagagu.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		log.info("main...");
		return "main";
	}
	@GetMapping("/s3")
	public String s3() {
		log.info("main...");
		return "s3";
	}
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/admin")
	public void admin() {
		log.info("admin ");
	}

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {

		log.info("error: " + error);
		log.info("logout: " + logout);
		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}

	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}

	@PostMapping("/customLogout")
	public void logoutPost() {
		log.info("post custom logout");
	}
	
	
	@GetMapping("/signup")
	public void signup() {
		log.info("signup");
	}
	
	
	/*
	  @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	  @GetMapping("/annoMember")
	  public void doMember2() {
	    
	    log.info("logined annotation member");
	  }
	  
	  
	  @Secured({"ROLE_ADMIN"})
	  @GetMapping("/annoAdmin")
	  public void doAdmin2() {

	    log.info("admin annotaion only");
	  }
	  */
}
