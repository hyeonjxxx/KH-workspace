package com.hj.withus.common.template;

import com.hj.withus.common.model.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int totalList, int currentPage, int pageLimit, int boardLimit) {
		
		// 마지막 페이지수
		int maxPage = (int)Math.ceil((double)totalList/boardLimit);
		// 페이징바의 시작 수
		int startPage = (currentPage-1)/pageLimit * pageLimit+1;
		// 페이빙바의 끝수
		int endPage;
		if((endPage = startPage+pageLimit-1)>maxPage) {
			endPage = maxPage;
		}
		return null;
	}
	
}
