package com.hj.withus.common.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

public class PageInfo {
	
	private int totalList;// 총 게시글 갯수
	private int currentPage;// 현재 페이지 쪽수
	private int pageLimit;// 한 페이지에 보여지를 페이지 수  ==>ex. 총 13페이지면 1~10,11~13 이때 PageLimt=10
	private int boardLimit;// 

	private int startPage;// 시작페이지
	private int endPage;// 마지막페이지
	private int maxPage;//
	
	public PageInfo() {}

	public PageInfo(int totalList, int currentPage, int pageLimit, int boardLimit, int startPage, int endPage,
			int maxPage) {
		super();
		this.totalList = totalList;
		this.currentPage = currentPage;
		this.pageLimit = pageLimit;
		this.boardLimit = boardLimit;
		this.startPage = startPage;
		this.endPage = endPage;
		this.maxPage = maxPage;
	}

	public int getTotalList() {
		return totalList;
	}

	public void setTotalList(int totalList) {
		this.totalList = totalList;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageLimit() {
		return pageLimit;
	}

	public void setPageLimit(int pageLimit) {
		this.pageLimit = pageLimit;
	}

	public int getBoardLimit() {
		return boardLimit;
	}

	public void setBoardLimit(int boardLimit) {
		this.boardLimit = boardLimit;
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

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	@Override
	public String toString() {
		return "PageInfo [totalList=" + totalList + ", currentPage=" + currentPage + ", pageLimit=" + pageLimit
				+ ", boardLimit=" + boardLimit + ", startPage=" + startPage + ", endPage=" + endPage + ", maxPage="
				+ maxPage + "]";
	}
	 
	
}
