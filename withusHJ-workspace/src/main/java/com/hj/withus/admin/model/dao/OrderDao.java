package com.hj.withus.admin.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Repository;

import com.hj.withus.common.model.PageInfo;

@Repository
public class OrderDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("withusOrderMapper.oSelectListCount");
	}
	
	public ArrayList<com.hj.withus.admin.model.vo.Order> selectList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset =(pi.getCurrentPage()-1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("withusOrderMapper.oSelectList", null, rowBounds);
	}
	
	public com.hj.withus.admin.model.vo.Order selectOrderDetail(SqlSessionTemplate sqlSession, int orderNo) {
		
		return sqlSession.selectOne("withusOrderMapper.selectOrderDetail", orderNo);
	}

}
