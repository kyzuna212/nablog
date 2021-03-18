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
	
	/*태그 배열을 가져옵니다*/
	public String[] selectTagList();
	
	/*카테고리 별 목록 총 갯수를 조회합니다*/
	public int selectTotalCount(BoardVO boardVO);

	/*전체 카테고리에서 검색한  목록 총 갯수를 조회합니다*/
	public int selectTotalCount(String search);
	
	/*게시물을 등록합니다*/
	public int insert(BoardVO board);

	/*게시물 조회수를 1 증가시킵니다*/
	public int updatebView(int bno);

	/*게시글 번호에 해당하는 게시물을 불러옵니다*/
	public BoardVO selectOne(int bno);

	/*해당 카테고리에서 게시글 번호 앞뒤 글 최대 5글 불러오기 */
	public BoardVO selectConList(int bno, int menuCateNo);
		
}
