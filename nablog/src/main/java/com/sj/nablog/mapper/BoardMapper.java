package com.sj.nablog.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.sj.nablog.model.domain.BoardVO;

public interface BoardMapper {
	

	/*메뉴카테고리에 해당하는 글 목록을 가져옵니다*/
	public ArrayList<BoardVO> selectList(int menuCateNo);

	/*전체 카테고리의 글에서 최근에 쓰여진 글 5개를 가져옵니다*/
	public ArrayList<BoardVO> selectRecent();

	/*전체 카테고리의 글에서 가장 조회수가 높은 글 5개를 가져옵니다*/
	public ArrayList<BoardVO> selectPopular();

	/*전체 검색한 내용을 가져옵니다*/
	public ArrayList<BoardVO> selectFindList(BoardVO boardVO);
	
	/*태그 배열을가져옵니다*/
	public ArrayList<String> selectTagList();

	/*카테고리 별 목록 총 갯수를 조회합니다*/
	public int selectTotalCount(BoardVO boardVO);

	/*전체 카테고리에서 검색한  목록 총 갯수를 조회합니다*/
	public int selectTotalCount(String search);
	
	/*게시물을 등록합니다*/
	public void insert(BoardVO board);

}
