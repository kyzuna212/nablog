package com.sj.nablog.model.domain;

import java.sql.Date;
import java.util.List;

import com.sj.nablog.common.domain.AttachFile;

//import lombok.Data;

//게시판
//@Data
public class BoardVO {
	
	/*컬럼*/
	private int bno; 	//게시글 번호
	private int menuCateNo; 	//메뉴 카테고리 번호
	private String bTitle; 	//게시글 제목
	private String bCnt;	//게시글 내용
//	private String bOrfile;	//첨부파일 원본이름
//	private String bRefile;	//첨부파일 저장이름
	private Date bDate;	//게시글 작성일자
	private String bTage;	//게시글 태크
	private int bView;	//게시글 조회수
	private String rgbdId;	//게시글 작성자
	private String bUsyn;	//게시글 사용여부 (Y:사용, N:삭제)
	
	//첨부파일 등록
	private List<AttachFile> attachList ;
	
	/*검색*/
	private String search; //검색

	public BoardVO() {}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public int getMenuCateNo() {
		return menuCateNo;
	}

	public void setMenuCateNo(int menuCateNo) {
		this.menuCateNo = menuCateNo;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbCnt() {
		return bCnt;
	}

	public void setbCnt(String bCnt) {
		this.bCnt = bCnt;
	}

	public Date getbDate() {
		return bDate;
	}

	public void setbDate(Date bDate) {
		this.bDate = bDate;
	}

	public String getbTage() {
		return bTage;
	}

	public void setbTage(String bTage) {
		this.bTage = bTage;
	}

	public int getbView() {
		return bView;
	}

	public void setbView(int bView) {
		this.bView = bView;
	}

	public String getRgbdId() {
		return rgbdId;
	}

	public void setRgbdId(String rgbdId) {
		this.rgbdId = rgbdId;
	}

	public String getbUsyn() {
		return bUsyn;
	}

	public void setbUsyn(String bUsyn) {
		this.bUsyn = bUsyn;
	}

	public List<AttachFile> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<AttachFile> attachList) {
		this.attachList = attachList;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", menuCateNo=" + menuCateNo + ", bTitle=" + bTitle + ", bCnt=" + bCnt
				+ ", bDate=" + bDate + ", bTage=" + bTage + ", bView=" + bView + ", rgbdId=" + rgbdId + ", bUsyn="
				+ bUsyn + ", attachList=" + attachList + ", search=" + search + "]";
	}
	
	
	
	



	
	
	
}
