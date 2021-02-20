package com.sj.nablog.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class MemberController {
	
	/*
	 * @Autowired MemberService memberService;
	 */
	
	//로그인 페이지로 이동
	@RequestMapping("/mlogin.do")
	public String moveLogin() {
		return "member/loginCheck";
	}
	
	//로그인 
	/*	public String login(MemberVO membervo) {
		
		MemberVO loginMember = memberService.loginCheck(membervo);
		
		if(loginMember !=null) {
			
		}else {
			
		}
			return "redirect:main.do";
	}*/
}
