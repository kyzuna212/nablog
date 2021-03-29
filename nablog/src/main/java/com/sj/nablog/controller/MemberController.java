package com.sj.nablog.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sj.nablog.model.domain.MemberVO;
import com.sj.nablog.model.service.MemberService;



@Controller
public class MemberController {
	

	 @Autowired 
	 MemberService memberService;

	
	//로그인 페이지로 이동
	@RequestMapping("/mlogin.do")
	public String moveLogin() {
		return "member/loginCheck";
	}
	
	//로그인 
	@RequestMapping("/login.do")
	public String login(MemberVO membervo, HttpServletRequest request) {
		
		MemberVO loginMember = memberService.loginCheck(membervo);
		
		if(loginMember !=null) {
						
			if( StringUtils.equals(loginMember.getMagYn(),"Y") ){//관리자라면
				
				return "admin/main";
			
			}else {//관리자가 아니라면
				HttpSession session = request.getSession();
				session.setAttribute("Member", loginMember);				
			}
	
		}	
		
		return "redirect:main.do";
	}
}
