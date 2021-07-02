package com.hj.withus.admin.model.service;

import java.util.ArrayList;

import com.hj.withus.admin.model.vo.Member;
import com.hj.withus.common.model.PageInfo;

public interface MemberService {
	
	int selectListCount();
	ArrayList<Member> selectList(PageInfo pi);
	
	// 탈퇴 모달
	Member selectMemStatus(int memberNo);
	// 탈퇴(회원 상태 변경)
	int deleteMember(Member m);
	

}
