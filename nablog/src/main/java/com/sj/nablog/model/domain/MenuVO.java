package com.sj.nablog.model.domain;

import lombok.Data;

//메뉴관리
@Data
public class MenuVO {
	
	private int menuCateNo; //메뉴 카테고리 번호
	private int menuCateRef; //메뉴 카테고리 참조번호
	private String menuTit; //메뉴 제목
}
