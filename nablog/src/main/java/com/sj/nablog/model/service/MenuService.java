package com.sj.nablog.model.service;

import java.util.ArrayList;

import com.sj.nablog.model.domain.MenuVO;

public interface MenuService {

	public ArrayList<MenuVO> selectList();

	public ArrayList<MenuVO> selectMainList();
	
	/*메뉴 카테고리번호에 헤당하는 메뉴 정보를 가져옵니다*/
	public MenuVO selectOne(int menuCateNo);

}
