package com.hj.withus.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.hj.withus.admin.model.vo.Member;
import com.hj.withus.admin.model.vo.OrderTB;
import com.hj.withus.common.model.PageInfo;

public interface OrderService {
	
	int selectListCount();
	ArrayList<OrderTB> selectList(PageInfo pi);
	
	// 상세 조회
	OrderTB slectOrderDetail(int orderNo);
	// 검색 기능
	ArrayList<OrderTB> searchOrder(HashMap<String, String> map);
	
	
	
	// 파트너 발송관리
	// 프로젝트  총 주문내역  건수
	int selectDeliveryCount();
	// 프로젝트 진행 현황
	OrderTB selectStatusCount();
	// 프로젝트 총 주문내역 리스트
	ArrayList<OrderTB> selectOrderNDelivery(PageInfo pi);
	// 발송모달:펀딩내역
	OrderTB selectOrderInfo(int orderNo);
	// 환불모달:펀딩내역+환불신청내역
	OrderTB selectRefundInfo(int orderNo);
	

}
