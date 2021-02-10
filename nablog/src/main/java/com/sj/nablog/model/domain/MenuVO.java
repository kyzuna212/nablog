package com.sj.nablog.model.domain;

import lombok.Data;

//메뉴관리
@Data
public class MenuVO {
	
	private String menuId; //메뉴 아이디
	private String cateYn; //카테고리 여부
	private String menuTit; //메뉴 제목
}
