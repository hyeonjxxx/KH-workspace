package com.hj.withus.admin.model.service;

import java.util.ArrayList;

import com.hj.withus.admin.model.vo.Member;
import com.hj.withus.common.model.PageInfo;

public interface MemberService {
	
	int selectListCount();
	ArrayList<Member> selectList(PageInfo pi);
	
	int deleteMember(String memberId);
	

}
