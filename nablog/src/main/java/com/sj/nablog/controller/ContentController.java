package com.sj.nablog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ContentController {
		
	//about me 페이지로 이동
	@RequestMapping("/about.do")
	public String moveAbout() {
		
		return "content/about";
	}
}
