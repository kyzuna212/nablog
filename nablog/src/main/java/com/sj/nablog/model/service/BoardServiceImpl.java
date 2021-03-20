package com.sj.nablog.model.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sj.nablog.mapper.AttachFileMapper;
import com.sj.nablog.mapper.BoardMapper;
import com.sj.nablog.model.domain.BoardVO;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {
	
	private static final Logger log = LoggerFactory.getLogger(BoardServiceImpl.class);

	@Setter(onMethod_ = {@Autowired})
	private BoardMapper boardMapper;
	
	@Setter(onMethod_ = {@Autowired})
	private AttachFileMapper attachFileMapper;
	
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
		
		String str ="";
		
		for(int i=0; i<taglist.size(); i++) {
			
			str += taglist.get(i)+",";
			
		}
		
		String tagArr[] = str.split(",");

 		return tagArr;
	}

	/*카테고리 별 목록 총 갯수를 조회합니다*/
	@Override
	public int selectTotalCount(BoardVO boardVO) {
		
		return boardMapper.selectTotalCount(boardVO);
	}

	/*전체 카테고리에서 검색한  목록 총 갯수를 조회합니다*/
	@Override
	public int selectTotalCount(String search) {
		
		return boardMapper.selectTotalCount(search);
	}
	
	/*게시물 등록*/
	@Override
	public int insert(BoardVO board) {
		
		log.info("insert...."+board);
		
		//먼저 게시물 등록
		int result = boardMapper.insert(board);
		
		if(board.getAttachList() ==null || board.getAttachList().size() <=0) {
			return result;
		}else {
				//등록 번호를 가지고 첨부파일 등록
				/*
				 * board.getAttachList().forEach(attach ->{
				 * 
				 * attach.setBno(board.getBno()); // result =
				 * attachFileMapper.insertFile(attach); });
				 */
		}

		return result;
	}

	/*게시물 조회수를 1 증가시킵니다*/
	@Override
	public int updatebView(int bno) {
		
		return boardMapper.updatebView(bno);
	}

	/*게시글 번호에 해당하는 게시물을 불러옵니다*/
	@Override
	public BoardVO selectOne(int bno) {
		
		return boardMapper.selectOne(bno);
	}

	/* 해당 카테고리에서 게시글 번호 앞뒤 글 최대 5글 불러오기 */
	@Override
	public BoardVO selectConList(int bno, int menuCateNo, int rowNum) {
		
		return boardMapper.selectConList(bno, menuCateNo, rowNum);
	}

	/*게시글 번호로 rownum값 조회하기*/
	@Override
	public int selectRowNum(int bno) {
	
		return boardMapper.selectRowNum(bno);
	}

}
