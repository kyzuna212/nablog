package com.sj.nablog.model.service;

import java.util.ArrayList;

import com.sj.nablog.model.domain.ReplyVO;

public interface ReplyService {
	
	/*게시글 번호에 해당하는 댓글을 불러온다*/
	public ArrayList<ReplyVO> selectList(int bno);

}
