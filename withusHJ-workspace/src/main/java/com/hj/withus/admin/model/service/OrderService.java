package com.hj.withus.admin.model.service;

import java.util.ArrayList;

import org.springframework.core.annotation.Order;

import com.hj.withus.admin.model.vo.Member;
import com.hj.withus.common.model.PageInfo;

public interface OrderService {
	
	int selectListCount();
	ArrayList<Order> selectList(PageInfo pi);
	

}
