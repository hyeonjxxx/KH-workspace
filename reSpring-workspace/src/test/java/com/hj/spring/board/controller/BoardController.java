package com.hj.spring.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.board.model.service.BoardService;

@Controller
public class BoardController  {

	@Autowired
	private BoardService bService;
	
	@RequestMapping("list.bo")
	public void selectBoardtList() {
		
		int listCount = bService.selectListCount();
	}

}
