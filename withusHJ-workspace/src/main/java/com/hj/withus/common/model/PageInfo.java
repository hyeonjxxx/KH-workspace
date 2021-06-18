package com.hj.withus.common.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter @Getter
@ToString
public class PageInfo {
	
	private int totalList;// 총 게시글 갯수
	private int currentPage;// 현재 페이지 쪽수
	private int pageLimit;// 한 페이지에 보여지를 페이지 수  ==>ex. 총 13페이지면 1~10,11~13 이때 PageLimt=10
	private int boardLimit;// 

	private int startPage;// 시작페이지
	private int endPage;// 마지막페이지
	private int maxPage;//
}
