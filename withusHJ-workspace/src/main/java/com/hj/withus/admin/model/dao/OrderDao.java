package com.hj.withus.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.hj.withus.admin.model.vo.Member;
import com.hj.withus.admin.model.vo.OrderTB;
import com.hj.withus.common.model.PageInfo;

@Repository
public class OrderDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("withusOrderMapper.oSelectListCount");
	}
	
	public ArrayList<OrderTB> selectList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset =(pi.getCurrentPage()-1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("withusOrderMapper.oSelectList", null, rowBounds);
	}
	
	public OrderTB selectOrderDetail(SqlSessionTemplate sqlSession, int orderNo) {
		
		return sqlSession.selectOne("withusOrderMapper.selectOrderDetail", orderNo);
	}
	
	public int cancleOrder(SqlSessionTemplate sqlSession, int orderNo) {
		
		return sqlSession.selectOne("withusOrderMapper.cancleOrder", orderNo);
	}
	
	public int selectDeilveryCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("withusOrderMapper.SelectDeliveryCount");
	}
	
	public OrderTB selectStatusCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("withusOrderMapper.selecetStatsCount");
	}
	
//	public OrderTB selectSendInfo(SqlSessionTemplate sqlSession) {
//		return sqlSession.selectOne("withusOrderMapper.selectSendInfo");
//	}

	
	public ArrayList<OrderTB> selectOrderNDelivery(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("withusOrderMapper.selectOrderNDelivery",null,rowBounds);
	}
	
	
	public OrderTB selectOrderInfo(SqlSessionTemplate sqlSession, int orderNo) {
		return sqlSession.selectOne("withusOrderMapper.selectOrderInfo", orderNo);
	}

	public OrderTB selectRefundInfo(SqlSessionTemplate sqlSession, int orderNo) {
		return sqlSession.selectOne("withusOrderMapper.selectRefundInfo", orderNo);
	}
	
//	검색기능
	public ArrayList<OrderTB> searchOrder(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		
		return (ArrayList)sqlSession.selectList("withusOrderMapper.searchOrder", map);
	}
	
	
	
	
}
