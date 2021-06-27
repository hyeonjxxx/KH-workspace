package com.hj.withus.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hj.withus.admin.model.service.RefundService;
import com.hj.withus.admin.model.vo.Refund;
import com.hj.withus.common.model.PageInfo;
import com.hj.withus.common.template.Pagination;

@Controller
public class RefundController {
	
	@Autowired
	private RefundService rService;
	
	@RequestMapping("refundListView.mana")
	public ModelAndView selectRefundList(@RequestParam(value="currentPage", defaultValue="1")
										int currentPage, ModelAndView mv) {
		
		int totalList = rService.selectListCount();
		PageInfo pi = Pagination.getPageInfo(totalList, currentPage, 5, 10);
		
		ArrayList<Refund> rList = rService.selectList(pi);
		
		mv.addObject("rList", rList)
		  .addObject("pi", pi)
		  .setViewName("admin/manaRefundListView");
		
		return mv;
	}
	
	@RequestMapping("refundDetail.mana")
	public String selectRefund(int rno, Model model) {
		
		Refund r = rService.selectRefund(rno);
		model.addAttribute("r", r);
		
		return "admin/manaRefundDetailView";
	}

}
