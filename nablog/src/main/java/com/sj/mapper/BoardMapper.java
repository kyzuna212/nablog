package com.sj.mapper;

import org.apache.ibatis.annotations.Select;

public interface BoardMapper {
	
	@Select("SELECT sysdate FROM dual")
	public String getTime();
	
	public String getTime2();
}
