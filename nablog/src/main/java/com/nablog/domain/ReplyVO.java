package com.nablog.domain;

import java.sql.Date;

import lombok.Data;

//댓글 테이블
@Data
public class ReplyVO { 

	private int replyNo;	//댓글 번호
	private String replyId;	// 댓글 작성자 아이디
	private String replyCnt;	//댓글 내용
	private String replyLock;	//댓글 비밀글 여부
	private String bno;	//게시판 글 번호
	private int replyRef;	//참조 글 번호
	private int replySrt;	//댓글 순서
	private Date replyDate;	//댓글 작성일자
	private String replyUsyn;	//댓글 사용여부
	private String menuId;	//메뉴 아이디
	
}
