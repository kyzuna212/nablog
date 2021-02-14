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
		
		ArrayList<MenuVO> list = menuMapper.selectList();
		
		return list;
	}

	
	//메인 카테고리 조회
	@Override
	public ArrayList<MenuVO> selectMainList() {
		
		ArrayList<MenuVO> list = menuMapper.selectMainList();
		return list;
	}

}
