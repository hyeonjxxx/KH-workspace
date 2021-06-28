package com.hj.withus.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hj.withus.admin.model.dao.OrderDao;
import com.hj.withus.admin.model.vo.OrderTB;
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
	public ArrayList<OrderTB> selectList(PageInfo pi) {
		return oDao.selectList(sqlSession,pi);
	}

	@Override
	public OrderTB slectOrderDetail(int orderNo) {
		return (OrderTB) oDao.selectOrderDetail(sqlSession, orderNo);
	}

	@Override
	public int selectDeliveryCount() {
		return oDao.selectDeilveryCount(sqlSession);
	}

	@Override
	public ArrayList<OrderTB> selectOrderNDelivery(PageInfo pi) {
		return oDao.selectOrderNDelivery(sqlSession, pi);
	}
	
	




}
