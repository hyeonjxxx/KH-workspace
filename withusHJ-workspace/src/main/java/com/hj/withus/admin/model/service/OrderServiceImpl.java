package com.hj.withus.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hj.withus.admin.model.dao.OrderDao;
import com.hj.withus.admin.model.vo.Order;
import com.hj.withus.common.model.PageInfo;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private OrderDao oDao;
	
	@Override
	public int selectListCount() {
		return oDao.selectListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Order> selectList(PageInfo pi) {
		return oDao.selectList(sqlSession,pi);
	}

	@Override
	public Order slectOrderDetail(int orderNo) {
		return (Order) oDao.selectOrderDetail(sqlSession, orderNo);
	}




}
