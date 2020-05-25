 package org.nagagu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomController {
	@RequestMapping(value = "/custom/list")
	public String estimate() {
		return "custom/list";
	}
}
