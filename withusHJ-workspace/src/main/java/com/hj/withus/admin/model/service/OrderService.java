package com.hj.withus.admin.model.service;

import java.util.ArrayList;


import com.hj.withus.admin.model.vo.OrderTB;
import com.hj.withus.common.model.PageInfo;

public interface OrderService {
	
	int selectListCount();
	ArrayList<OrderTB> selectList(PageInfo pi);
	
	// 상세 조회
	OrderTB slectOrderDetail(int orderNo);
	
	// 파트너 발송관리
	int selectDeliveryCount();
	ArrayList<OrderTB> selectOrderNDelivery(PageInfo pi);
	

}
