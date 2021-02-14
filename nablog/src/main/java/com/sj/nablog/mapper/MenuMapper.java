package com.sj.nablog.mapper;

import java.util.ArrayList;

import com.sj.nablog.model.domain.MenuVO;

//Mybatis 매핑XML에 기재된 SQL을 호출하기 위한 인터페이스/ Mybatis3.0부터 생김

public interface MenuMapper {

	ArrayList<MenuVO> selectList();
	
	ArrayList<MenuVO> selectMainList();

}
