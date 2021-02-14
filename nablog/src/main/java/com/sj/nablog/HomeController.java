package com.sj.nablog;

import java.util.ArrayList;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sj.nablog.model.domain.MenuVO;
import com.sj.nablog.model.service.MenuService;

import lombok.Setter;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Setter(onMethod_ = {@Autowired})
	private MenuService menuService ;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		
		return "home";
	}
	
	//메인페이지로 이동
	@RequestMapping(value="/main.do",method=RequestMethod.GET )
	public String main (Model model) {
		
		ArrayList<MenuVO> menuMainList = new ArrayList<MenuVO>();
		ArrayList<MenuVO> menuList = new ArrayList<MenuVO>();
		
		menuMainList = menuService.selectMainList();
		menuList = menuService.selectList();
		
		model.addAttribute("main", "main");
		model.addAttribute("menuMainList", menuMainList);
		model.addAttribute("menuList", menuList);
		
		return "common/main";
	}
	
}
