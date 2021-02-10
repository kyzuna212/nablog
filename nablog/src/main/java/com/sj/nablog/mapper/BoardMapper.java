package com.sj.nablog.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.sj.nablog.model.domain.BoardVO;

public interface BoardMapper {
	
	@Select("SELECT * FROM board WHERE bno >0")
	public List<BoardVO> getList();
	
	public String getTime2();
}
