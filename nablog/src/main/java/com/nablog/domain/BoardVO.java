package com.nablog.domain;

import java.sql.Date;

import lombok.Data;

//게시판
@Data
public class BoardVO {
	
	private int bno; 	//게시글 번호
	private String menuId; 	//메뉴 아이디
	private String bTitle; 	//게시글 제목
	private String bCnt;	//게시글 내용
	private String bOrfile;	//첨부파일 원본이름
	private String bRefile;	//첨부파일 저장이름
	private Date bDate;	//게시글 작성일자
	private String bTage;	//게시글 태크
	private int bView;	//게시글 조회수
	private String rgbdId;	//게시글 작성자
	private String bUsyn;	//게시글 사용여부 (Y:사용, N:삭제)
	
	
}
