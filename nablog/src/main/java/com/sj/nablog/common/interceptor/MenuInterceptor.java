package com.sj.nablog.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sj.nablog.model.service.BoardService;
import com.sj.nablog.model.service.MenuService;

import lombok.Setter;

public class MenuInterceptor extends HandlerInterceptorAdapter{

	@Setter(onMethod_ = {@Autowired})
	private MenuService menuService ;
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService boardService;
	
	//컨트롤러에서 리턴되어 뷰리졸버로 가기 전 구동되는 메소드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler, ModelAndView modelAndView) throws Exception {
		
		modelAndView.addObject("menuMainList", menuService.selectMainList());
		modelAndView.addObject("menuList", menuService.selectList());
		modelAndView.addObject("recentList", boardService.selectRecent());
		modelAndView.addObject("popularList", boardService.selectPopluar());
		
		super.postHandle(request, response, handler, modelAndView);
		
	}
}
