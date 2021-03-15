package com.sj.nablog.model.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sj.nablog.mapper.ReplyMapper;
import com.sj.nablog.model.domain.ReplyVO;

import lombok.Setter;

@Service
public class ReplyServiceImpl implements ReplyService{

	private static final Logger log = LoggerFactory.getLogger(ReplyServiceImpl.class);

	@Setter(onMethod_ = {@Autowired})
	private ReplyMapper replyMapper;

	/*게시글 번호에 해당하는 댓글을 불러온다*/
	@Override
	public ArrayList<ReplyVO> selectList(int bno) {
		
		return replyMapper.selectList(bno);
	}
	
	
}
