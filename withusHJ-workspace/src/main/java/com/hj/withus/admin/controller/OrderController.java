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
import com.hj.withus.admin.model.vo.OrderTB;
import com.hj.withus.common.template.Pagination;

@Controller
public class OrderController {

	@Autowired
	private OrderService oService;
	
	@RequestMapping("orderListView.mana")
	public ModelAndView selectOrderList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		int totalList = oService.selectListCount();
		PageInfo pi = Pagination.getPageInfo(totalList, currentPage, 5, 10);
		
		ArrayList<OrderTB> olist = oService.selectList(pi);
		
		mv.addObject("olist", olist)
		  .addObject("pi", pi)
		  .setViewName("admin/manaOrderListView");
		
		return mv;
	}
	
	@RequestMapping("orderDetail.mana")
	public String selectOrder(int ono, Model model) {
		
		OrderTB o = oService.slectOrderDetail(ono);
		
		if(o != null) {
			model.addAttribute("o", o);
			return "admin/manaOrderDetailView";
		}else {
			model.addAttribute("errorMsg","주문내역 상세 조회 실패");
			return "";
		}
	}
	
	@RequestMapping("orderNDeliveryList.part")
	public ModelAndView selectPartnerOrderList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, ModelAndView mv
			) {
		
		int totalList = oService.selectDeliveryCount();
		// statusBox에 출력될 건수
		OrderTB sc = oService.selectStatusCount();
		// 페이징 처리
		PageInfo pi = Pagination.getPageInfo(totalList, currentPage, 10, 10);
		// 주문현황 리스트 
		ArrayList<OrderTB> polist = oService.selectOrderNDelivery(pi);
		// 발송정보 입력창 , 해쉬맵 or 자바 스크립트로
		OrderTB oi = oService.selectSendInfo();
		// 펀딩금 반화 신청창
		
		mv.addObject("polist", polist)
		  .addObject("pi",pi)
		  .addObject("sc", sc)
		  .addObject("oi", oi)
		  .setViewName("admin/partOrderNDeliveryList");

		return mv;
	}

	
}
