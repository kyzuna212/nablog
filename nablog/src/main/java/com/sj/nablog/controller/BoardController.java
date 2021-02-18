package com.sj.nablog.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sj.nablog.model.domain.MenuVO;
import com.sj.nablog.model.service.MenuService;

import lombok.AllArgsConstructor;
import lombok.Setter;



@Controller //스프링의 빈으로 인식 가능
/* @Log4j */
//@RequestMapping("/board/*") //  /board로 시작하는 모든 처리를 함
@AllArgsConstructor  //생성자를 만들고 자동으로 주입(BoardService에 의존적)
					//단, 생성자를 만들지 않을 경우 @Setter(onMethod_={@Autowired})를 이용하여 처리
public class BoardController {
	
	@Setter(onMethod_ = {@Autowired})
	private MenuService menuService ;
	
	//목록 페이지로 이동
	@RequestMapping("/list.do")
	public String movePage(@RequestParam("menuTit") String menuTit, Model model) {
		
		
		
		ArrayList<MenuVO> menuMainList = new ArrayList<MenuVO>();
		ArrayList<MenuVO> menuList = new ArrayList<MenuVO>();
		
		menuMainList = menuService.selectMainList();
		menuList = menuService.selectList();
		
		model.addAttribute("menuMainList", menuMainList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("menuTit", menuTit);
		
		return "board/list";
	}
	
	//상세 페이지로 이동
	@RequestMapping("/detail.do")
	public String moveDetailPage(Model model) {

		/*
		 * ArrayList<MenuVO> menuMainList = new ArrayList<MenuVO>(); ArrayList<MenuVO>
		 * menuList = new ArrayList<MenuVO>();
		 * 
		 * menuMainList = menuService.selectMainList(); menuList =
		 * menuService.selectList();
		 * 
		 * model.addAttribute("menuMainList", menuMainList);
		 * model.addAttribute("menuList", menuList); model.addAttribute("menuTit",
		 * menuTit);
		 */
		
		return "board/detail";
	}
	
	@RequestMapping("/edit.do")
	public String moveEditPage(Model model) {
		return "board/edit";
	}
}
