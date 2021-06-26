package com.hj.withus.admin.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hj.withus.admin.model.service.MemberService;
import com.hj.withus.admin.model.vo.Member;
import com.hj.withus.common.model.PageInfo;
import com.hj.withus.common.template.Pagination;

@Controller
public class MemberController {

	@Autowired
	private MemberService mService;
	
	
	// 회원조회
	@RequestMapping("memberListView.mana")
	public ModelAndView selectMemberList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,ModelAndView mv) {
		
		int totalList = mService.selectListCount();
		PageInfo pi = Pagination.getPageInfo(totalList, currentPage, 5, 10);
		
		ArrayList<Member> mList = mService.selectList(pi);
		
		mv.addObject("mList",mList)
		  .addObject("pi", pi)
		  .setViewName("admin/manaMemberListView");
		return mv;
	}
	
	// 회원상태 변경
	@RequestMapping("deleteMem.mana")
	public String deleteMember(String mId, String mStatus, HttpSession session, Model model) {
		int result = mService.updateMemStatus(mId, mStatus);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "성공적으로 변경되었습니다.");
			return "redirect:memberListView.mana";
		}else {
			model.addAttribute("errorMsg","상태변경 실패");
			return "common/errorPage";
		}
	}
	
	
	
}
