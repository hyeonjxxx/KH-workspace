package com.hj.withus.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hj.withus.admin.model.dao.MemberDao;
import com.hj.withus.admin.model.vo.Member;
import com.hj.withus.common.model.PageInfo;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private MemberDao mDao;
	
	@Override
	public int selectListCount() {
		return mDao.selectListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Member> selectList(PageInfo pi) {
		return mDao.selectList(sqlSession, pi);
	}

	@Override
	public int updateMemStatus(String mId, String mStatus) {
		return mDao.updateMemStatus(sqlSession, mId, mStatus);
	}
	
	




}