package com.sj.nablog.model.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.sj.nablog.mapper.MemberMapper;
import com.sj.nablog.model.domain.MemberVO;

public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper memberMapper;
	
	/*로그인 확인*/
	@Override
	public MemberVO loginCheck(MemberVO membervo) {
		
		return memberMapper.selectLoginCheck(membervo);
	}

}
