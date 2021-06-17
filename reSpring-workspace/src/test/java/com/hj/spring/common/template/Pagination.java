package com.kh.spring.common.template;

import com.kh.spring.common.model.vo.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		// 가장 마지막 페이지 수
		int maxPage = (int)Math.ceil((double)listCount/boardLimit); 
		// 페이징바 의 시작 수		
		int startPage = (currentPage - 1)/pageLimit * pageLimit +1;
		// 페이징 바의 끝 수 
		int endPage;
		if((endPage = startPage + pageLimit-1) > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit, startPage, endPage, maxPage);
		
	}

}
