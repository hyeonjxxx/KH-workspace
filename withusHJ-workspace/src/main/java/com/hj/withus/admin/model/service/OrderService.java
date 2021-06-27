package com.hj.withus.admin.model.service;

import java.util.ArrayList;


import com.hj.withus.admin.model.vo.Order;
import com.hj.withus.common.model.PageInfo;

public interface OrderService {
	
	int selectListCount();
	ArrayList<Order> selectList(PageInfo pi);
	
	// 상세 조회
	Order slectOrderDetail(int orderNo);
	

}
