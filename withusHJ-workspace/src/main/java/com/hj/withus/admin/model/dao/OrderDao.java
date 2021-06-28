package com.hj.withus.admin.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	
	
	public int selectDeilveryCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("withusOrderMapper.SelectDeliveryCount");
	}
	
	public ArrayList<OrderTB> selectOrderNDelivery(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("withusOrderMapper.selectOrderNDelivery",null,rowBounds);
	}

}
