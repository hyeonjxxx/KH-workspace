package com.hj.withus.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.hj.withus.admin.model.service.OrderService;
import com.hj.withus.admin.model.vo.OrderTB;
import com.hj.withus.common.model.PageInfo;
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
		System.out.println(o);
		
		model.addAttribute("o", o);
		return "admin/manaOrderDetailView";
		
//		if(o == null) {
//			model.addAttribute("errorMsg","주문내역 상세 조회 실패");
//			return "";
//		}else {
//		}
	}
	
	
	//결제 취소 기능 --> 안됨....
	@RequestMapping("orderUpdate.mana")
	public String updateOrder(int ono, Model model) {
		
		OrderTB o = oService.slectOrderDetail(ono);
		
		model.addAttribute("o", o);
		return "admin/manaOrderListView";
		
	}
	
	// 검색기능 -> 일단 키워드로 검색만(라디오 버튼 조건 없이)
	@RequestMapping("orderSearch.mana")
	public String selectOrderList(HttpServletRequest request, Model model) {
		
		String orderKeyword = request.getParameter("orderKeyword"); // title|writer|content
		String keyword = request.getParameter("keyword");
		String odStatus =request.getParameter("odStatus");
		String shStatus =request.getParameter("shStatus");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("orderKeyword", orderKeyword);
		map.put("keyword", keyword);
		map.put("odStatus", odStatus);
		map.put("shStatus", shStatus);
		
		ArrayList<OrderTB> olist = oService.searchOrder(map);
		
		model.addAttribute("olist", olist)
		     .addAttribute("orderKeyword",orderKeyword)
		     .addAttribute("keyword",keyword)
			 .addAttribute("odStatus",odStatus)
			 .addAttribute("shStatus",shStatus);
		
		return "admin/manaOrderListView";
	}
	
	
	
	// 파트너
	// 프로젝트 펀딩현황
	@RequestMapping("orderNDeliveryList.part")
	public ModelAndView selectPartnerOrderList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, ModelAndView mv
			) {
		
		// 총 주문리스트 갯수
		int totalList = oService.selectDeliveryCount();
		// statusBox에 출력될 건수
		OrderTB sc = oService.selectStatusCount();
		// 페이징 처리
		PageInfo pi = Pagination.getPageInfo(totalList, currentPage, 10, 10);
		// 주문현황 리스트 
		ArrayList<OrderTB> polist = oService.selectOrderNDelivery(pi);
		
		mv.addObject("polist", polist)
		  .addObject("pi",pi)
		  .addObject("sc", sc)
		  .setViewName("admin/partOrderNDeliveryList");

		return mv;
	}
	
	
//  모달 창만 나옴
//	@RequestMapping(value="send.info", produces="application/json; charset=utf-8")
//	public void ajaxSelectSendInfo(int ono, HttpServletResponse response) throws IOException {
//		OrderTB o = oService.selectSendInfo(ono);
//		System.out.println(o);
//		JSONObject jObj = new JSONObject();
//		jObj.put("ordreNo", o.getOrderNo());
//
//		response.setContentType("application/json; charset=utf-8");
//		response.getWriter().print(jObj);
//		
//	}
	
	// 발송모달 -  주문내역
	@ResponseBody
	@RequestMapping(value="send.info", produces="application/json; charset=utf-8")
	public String ajaxSelectOrderInfo(int orderNo) {
		
		System.out.println(orderNo); // 펀딩번호 확인		
		
		OrderTB o = oService.selectOrderInfo(orderNo);
		System.out.println(o); // 펀딩내역 잘 담겼는지
		
		return new Gson().toJson(o);
	}	

	@ResponseBody
	@RequestMapping(value="refund.info", produces="apllication/json; charset=utf-8")
		public String ajaxSelectRefundinfo(int orderNo) {
		
		//System.out.println(orderNo);
		
		OrderTB r = oService.selectRefundInfo(orderNo);
		//System.out.println(r);
		
		return new Gson().toJson(r);
	}
	
}
