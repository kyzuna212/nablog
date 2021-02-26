package com.sj.nablog.common.domain;

public class PagingList {

	private int startPage ; //시작페이지
	private int endPage;	//끝페이지
	private int pg ; 		//현재 페이지
	private int pgSize ; 	//한 페이지에 나오는 글 갯수
	private int totalSize;	// 총 데이터 수
	
	public PagingList() {
		
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getPg() {
		return pg;
	}

	public void setPg(int pg) {
		this.pg = pg;
	}

	public int getPgSize() {
		return pgSize;
	}

	public void setPgSize(int pgSize) {
		this.pgSize = pgSize;
	}
	
	public int getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}
	
	/*시작페이지, 끝페이지, 현재페이지 계산*/
	public void RowSet (int pg, int totalSize) {
		if(this.pg!=1) {
			int currentPage  = (int)( Math.ceil(totalSize/ 10) ) ; 
		}
		
		int endPage = (int)( Math.ceil(pg/5) )*5 ;
		int startPage = endPage -4 ;
		
	}
	
	
	
}
