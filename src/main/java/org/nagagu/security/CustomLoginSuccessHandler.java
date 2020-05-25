package org.nagagu.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler 
extends SavedRequestAwareAuthenticationSuccessHandler 
implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {

		log.warn("Login Success");
		List<String> roleNames = new ArrayList<>();
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAMES: " + roleNames);
		if (roleNames.contains("ROLE_ADMIN")) {
			//response.sendRedirect("/admin");
			return;
		}

		if (roleNames.contains("ROLE_MEMBER")) {
			//response.sendRedirect("/community/list");
			return;
		}
//		if (roleNames.contains("ROLE_MEMBER")) {
//			response.sendRedirect("/admin/workshop");
//			return;
//		}
		response.sendRedirect("/");
	}
	
	
}


