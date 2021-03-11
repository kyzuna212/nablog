package com.sj.nablog.mapper;

import java.util.List;

import com.sj.nablog.common.domain.AttachFile;

public interface AttachFileMapper {
	
	/*첨부파일 업로드*/
	public void insertFile (AttachFile attachFile);

	/*첨부파일 삭제*/
	public void deleteFile (int fileNo);
	
	/*게시글 번호에 해당하는 첨부파일 목록을 불러옴*/
	public List<AttachFile> selectOne(int bno); 
}
