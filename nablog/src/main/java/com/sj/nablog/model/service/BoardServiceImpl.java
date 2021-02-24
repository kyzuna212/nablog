package com.sj.nablog.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sj.nablog.mapper.BoardMapper;
import com.sj.nablog.model.domain.BoardVO;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = {@Autowired})
	private BoardMapper boardMapper;
	
	/*메뉴카테고리에 해당하는 글 목록을 가져옵니다*/
	@Override
	public ArrayList<BoardVO> selectList(int menuCateNo) {
		
		return boardMapper.selectList(menuCateNo);
	}

	/*전체 카테고리의 글에서 최근에 쓰여진 글 5개를 가져옵니다*/
	@Override
	public ArrayList<BoardVO> selectRecent() {
		
		return boardMapper.selectRecent();
	}

	/*전체 카테고리의 글에서 가장 조회수가 높은 글 5개를 가져옵니다*/
	@Override
	public ArrayList<BoardVO> selectPopluar() {
		
		return boardMapper.selectPopular();
	}

	/*전체 검색한 내용을 가져옵니다*/
	@Override
	public ArrayList<BoardVO> selectFindList(BoardVO boardVO) {
		
		return boardMapper.selectFindList(boardVO);
	}
	
	/*태그 배열을 가져옵니다*/
	@Override
	public String[] selectTagList(){
		
		ArrayList<String> taglist = boardMapper.selectTagList();
		
		String tagArr[] = new String[taglist.size()] ;
		for(int i=0; i<taglist.size(); i++) {
			tagArr[i] = taglist.get(i);
		}

 		return tagArr;
	}

}
