package com.hj.withus.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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
	public ArrayList<OrderTB> searchOrder(HashMap<String, String> map) {
		return oDao.searchOrder(sqlSession, map);
	}
	
	
	
	

	@Override
	public int selectDeliveryCount() {
		return oDao.selectDeilveryCount(sqlSession);
	}

	@Override
	public OrderTB selectStatusCount() {
		return oDao.selectStatusCount(sqlSession);
	}
	
//	@Override
//	public OrderTB selectSendInfo() {
//		return oDao.selectSendInfo(sqlSession);
//	}
	
	@Override
	public ArrayList<OrderTB> selectOrderNDelivery(PageInfo pi) {
		return oDao.selectOrderNDelivery(sqlSession, pi);
	}
	
	@Override
	public OrderTB selectOrderInfo(int orderNo) {
		return oDao.selectOrderInfo(sqlSession, orderNo);
	}

	@Override
	public OrderTB selectRefundInfo(int orderNo) {
		return oDao.selectRefundInfo(sqlSession, orderNo);
	}

	// 발송정보입력
	@Override
	public int insertShippingInfo(HashMap<String, Object> map) {
		return oDao.insertShippingInfo(sqlSession, map);
	}

	// 결제취소
	@Override
	public int updateOrderCancle(int orderNo) {
		return oDao.updateOrderCancle(sqlSession, orderNo);
	}


	
	

	




}
