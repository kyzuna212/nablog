package com.sj.nablog.model.service;

import java.util.ArrayList;

import com.sj.nablog.model.domain.BoardVO;

public interface BoardService {

	/*메뉴카테고리에 해당하는 글 목록을 가져옵니다*/
	public ArrayList<BoardVO> selectList(int menuCateNo);

	/*전체 카테고리의 글에서 최근에 쓰여진 글 5개를 가져옵니다*/
	public ArrayList<BoardVO> selectRecent();

	/*전체 카테고리의 글에서 가장 조회수가 높은 글 5개를 가져옵니다*/
	public ArrayList<BoardVO> selectPopluar();

	/*전체 검색한 내용을 가져옵니다*/
	public ArrayList<BoardVO> selectFindList(BoardVO boardVO); 
}
