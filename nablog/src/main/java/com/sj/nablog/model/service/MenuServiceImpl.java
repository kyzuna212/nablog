package com.sj.nablog.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sj.nablog.mapper.MenuMapper;
import com.sj.nablog.model.domain.MenuVO;

import lombok.Setter;

@Service
public class MenuServiceImpl implements MenuService{
	
	@Setter(onMethod_ = {@Autowired})
	private MenuMapper menuMapper;
	
	//전체 메뉴 조회
	@Override
	public ArrayList<MenuVO> selectList() {
	
		return  menuMapper.selectList();
	}

	
	//메인 카테고리 조회
	@Override
	public ArrayList<MenuVO> selectMainList() {
		
		return menuMapper.selectMainList();
	}

	
	/*메뉴 카테고리번호에 헤당하는 메뉴 정보를 가져옵니다*/
	@Override
	public MenuVO selectOne(int menuCateNo) {
		
		return menuMapper.selectOne(menuCateNo);
	}

}
