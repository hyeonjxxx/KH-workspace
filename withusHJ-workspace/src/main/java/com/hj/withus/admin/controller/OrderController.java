package com.hj.withus.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hj.withus.admin.model.service.OrderService;
import com.hj.withus.common.model.PageInfo;
import com.hj.withus.admin.model.vo.Order;
import com.hj.withus.common.template.Pagination;

@Controller
public class OrderController {

	@Autowired
	private OrderService oService;
	
	@RequestMapping("orderListView.mana")
	public ModelAndView selectOrderList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		int totalList = oService.selectListCount();
		PageInfo pi = Pagination.getPageInfo(totalList, currentPage, 5, 10);
		
		ArrayList<Order> oList = oService.selectList(pi);
		
		mv.addObject("oList", oList)
		  .addObject("pi", pi)
		  .setViewName("admin/manaOrderListView");
		
		return mv;
	}
	
	@RequestMapping("orderDetail.mana")
	public String selectOrder(int ono, Model model) {
		
		Order o = oService.slectOrderDetail(ono);
		model.addAttribute("o", o);
		return "admin/manaOrderDetailView";
		
//		if(o != null) {
//		}else {
//			model.addAttribute("errorMsg","주문내역 상세 조회 실패");
//			return "";
//		}
	}
	
}
