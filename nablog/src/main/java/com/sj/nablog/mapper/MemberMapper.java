package com.sj.nablog.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.sj.nablog.model.domain.BoardVO;
import com.sj.nablog.model.domain.MemberVO;

public interface MemberMapper {
	
	//로그인
	public MemberVO selectOne(MemberVO membervo);
	

}
