package com.sj.nablog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sj.nablog.model.service.BoardService;
import com.sj.nablog.model.service.MenuService;

import lombok.Setter;

@Controller
public class MenuController {

	@Setter(onMethod_ = {@Autowired})
	private MenuService menuService ;
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService boardService;
	
	//메인페이지로 이동
	@RequestMapping(value="/main.do",method=RequestMethod.GET )
	public String main (Model model) {
					
		model.addAttribute("main", "main");
	//	model.addAttribute("menuMainList", menuService.selectMainList());
	//	model.addAttribute("menuList", menuService.selectList());
	//	model.addAttribute("recentList", boardService.selectRecent());
	//	model.addAttribute("popularList", boardService.selectPopluar());
			
		return "common/main";
	}
}
