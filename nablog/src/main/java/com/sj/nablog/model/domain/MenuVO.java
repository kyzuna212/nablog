package com.sj.nablog.model.domain;

//import lombok.Data;

//메뉴관리
//@Data
public class MenuVO {
	
	private int menuCateNo; //메뉴 카테고리 번호
	private int menuCateRef; //메뉴 카테고리 참조번호
	private String menuTit; //메뉴 제목
	
	
	public MenuVO() {}
	
	public int getMenuCateNo() {
		return menuCateNo;
	}
	public void setMenuCateNo(int menuCateNo) {
		this.menuCateNo = menuCateNo;
	}
	public int getMenuCateRef() {
		return menuCateRef;
	}
	public void setMenuCateRef(int menuCateRef) {
		this.menuCateRef = menuCateRef;
	}
	public String getMenuTit() {
		return menuTit;
	}
	public void setMenuTit(String menuTit) {
		this.menuTit = menuTit;
	}
	@Override
	public String toString() {
		return "MenuVO [menuCateNo=" + menuCateNo + ", menuCateRef=" + menuCateRef + ", menuTit=" + menuTit + "]";
	}
	
	
	
}
