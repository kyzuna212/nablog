package com.sj.nablog.model.service;

import java.util.ArrayList;

import com.sj.nablog.model.domain.MenuVO;

public interface MenuService {

	public ArrayList<MenuVO> selectList();

	public ArrayList<MenuVO> selectMainList();

}
