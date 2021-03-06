package com.sj.nablog.common.domain;

import lombok.Data;

@Data
public class AttachFile {
	
	private int fileNo; //첨부파일 번호
	private String bRefile; //저장이름
	private String fileName; 	//원본파일 이름
	private String uploadPath;	//업로드 경로
	private String uuid;	//UUID값
	private boolean image;	//이미지 여부
	private int bno; 	//게시글 번호
}
