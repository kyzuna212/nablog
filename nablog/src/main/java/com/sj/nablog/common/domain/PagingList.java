package com.sj.nablog.common.domain;

public class PagingList {

	private int startPage ; //시작페이지
	private int endPage;	//끝페이지
	private int pg ; 		//현재 페이지
	private int pgSize ; 	//한 페이지에 나오는 글 갯수
	private int totalSize;	// 총 데이터 수
	private int realEndPage; //실제 마지막 페이지
	private boolean prev, next ; //이전글 과 실제글 
	
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
	
	public int getRealEndPage() {
		return realEndPage;
	}

	public void setRealEndPage(int realEndPage) {
		this.realEndPage = realEndPage;
	}
	
	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	
	/*시작페이지, 끝페이지, 현재페이지 계산*/
	public PagingList( int pg,  int totalSize, int pgSize) {
		/*
		 * if(this.pg!=1) { int currentPage = (int)( Math.ceil(totalSize/ 10) ) ; }
		 */
		
		this.pg = pg;
		this.totalSize = totalSize;
		
		//한 페이지에 썸네일이 9개씩 나올때 
		if(pgSize==9) {
			
			//실제 마지막 페이지 
			this.realEndPage = (int)(Math.ceil(totalSize/pgSize));
			
			//현재 페이지 기준으로 마지막 페이지 구하기 (페이징이 5개씩 나온다고 가정)
			this. endPage = (int)( Math.ceil(pg/5) )*5 ;
			
			//실제 데이터 보다 더 많이 마지막 페이지 번호가 계산 될 때
			if( endPage > realEndPage ) {
				
				endPage = realEndPage;
			}
			
			//시작 페이지 구하기 (페이징 번호가 5개씩 나올 때)
			this.startPage = endPage -4 ;
			
			//이전 페이지 있는지 확인
			this.prev = this.startPage >1;
			
			//다음 페이지가 있는지 확인
			this.next = this.endPage < this.realEndPage;
		}
		
		
	}

	
	
	
	
	
}
