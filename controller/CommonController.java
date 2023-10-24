package org.medipaw.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.medipaw.controller.CommonController;

import lombok.extern.log4j.Log4j;

@Controller 
@Log4j
public class CommonController {
	@GetMapping("/customLogout")
	public String logoutGet() {
		log.info("custom logout");
		
		return "/common/customLogout";
	}
	
	@GetMapping("/customLogin")
	public String coustomLogin(String error, String logout, Model model) {
		log.info("coutomLogin()");
		log.info("error: " + error);
		log.info("logout :" + logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인 에러 - 계정을 확인해 주세요");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃이 완료되었습니다.");
		}
		return "/common/customLogin";
	}
	
	@GetMapping("/accessDenied")
	public String accessDenied(Authentication auth, Model model) {
		log.info("accessDenied()");
		model.addAttribute("msg", "접근불가 - 권한부족");
		return "/error/accessDenied";
	}
}
