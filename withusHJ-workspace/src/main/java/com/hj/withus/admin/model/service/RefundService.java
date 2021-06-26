package com.hj.withus.admin.model.service;


import java.util.ArrayList;

import com.hj.withus.admin.model.vo.Refund;
import com.hj.withus.common.model.PageInfo;

public interface RefundService {
	
	int selectListCount();
	ArrayList<Refund> selectList(PageInfo pi);
	
	Refund selectRefund(int refundNo);

}
