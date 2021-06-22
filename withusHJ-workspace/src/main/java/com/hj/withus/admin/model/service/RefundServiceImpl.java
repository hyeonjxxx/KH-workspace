package com.hj.withus.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hj.withus.admin.model.dao.RefundDao;
import com.hj.withus.admin.model.vo.Refund;
import com.hj.withus.common.model.PageInfo;

@Service
public class RefundServiceImpl implements RefundService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private RefundDao rDao;
	
	@Override
	public int selectListCount() {
		return rDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Refund> selectList(PageInfo pi) {
		return rDao.selectList(sqlSession, pi);
	}

}
