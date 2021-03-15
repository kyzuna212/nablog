package com.sj.nablog.mapper;

import java.util.ArrayList;

import com.sj.nablog.model.domain.ReplyVO;

public interface ReplyMapper {

	/*게시글 번호에 해당하는 댓글을 불러온다*/
	ArrayList<ReplyVO> selectList (int bno);
}
