package com.sj.nablog.model.service;

import com.sj.nablog.model.domain.MemberVO;

public interface MemberService {

	/*로그인 확인*/
	MemberVO loginCheck(MemberVO membervo);

}
