package com.sj.nablog.model.domain;

import lombok.Data;

//멤버
@Data
public class MemberVO {
	
	private String id;	//아이디
	private String pwd;	//비밀번호
	private String nickNm;	//닉네임
	private String magYn;	//운영자 여부 (Y:여, N:부)

}
