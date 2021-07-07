package com.hj.withus.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
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
		//System.out.println(mList);
		
		mv.addObject("mList",mList)
		  .addObject("pi", pi)
		  .setViewName("admin/manaMemberListView");
		return mv;
	}
	
	// 회원탈퇴
	// 모달
	@ResponseBody
	@RequestMapping(value="memStatus.mana", produces="apllication/json; charset=utf-8")
		public String ajaxSelectMemStatus(int mno) {
		
		//System.out.println(mno);
		
		Member ms = mService.selectMemStatus(mno);
		//System.out.println(ms);
		
		return new Gson().toJson(ms);
	}
	// 상태변경
	@RequestMapping("deleteMem.mana")
	public String deleteMember(@RequestParam(defaultValue="") String mStatus,
									 @RequestParam(defaultValue= "") String mamberName,
									 HttpSession session) {
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mStatus", mStatus );
		map.put("mamberName", mamberName );
		
		System.out.println(map);
		
		int delMem = mService.deleteMember(map);
		
		if (delMem > 0) {
			//session.setAttribute("alertMsg", "탈퇴처리 성공");
			return "redirect:/memberListView.mana";
		}else {
			session.setAttribute("alertMsg", "실패실패");
			return "redirect:/memberListView.mana";
		}
		
		
	}
	
	// 다중 조건 검색
	@RequestMapping("searchMember.mana")
	public ModelAndView searchMember(@RequestParam(defaultValue="T") String memberStatus,
									 @RequestParam(defaultValue="") String memKeyword ,
									 @RequestParam(value="currentPage", defaultValue="1") int currentPage,
									 ModelAndView mv) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberStatus", memberStatus);
		map.put("memKeyword", memKeyword);
		
		// 검색결과 리스트 총 갯수
		int count = mService.countSearch(map);
		
		// 페이징 처리
		PageInfo pi = Pagination.getPageInfo(count, currentPage, 10, 10);
		// 검색결과 담아내기
		ArrayList<Member> mList = mService.searchMember(map, pi);
		
		mv.addObject("pi", pi)
		  .addObject("mList",mList)
		  .setViewName("admin/manaMemberListView");
		
		return mv;
		
	}
	
	

	
}
