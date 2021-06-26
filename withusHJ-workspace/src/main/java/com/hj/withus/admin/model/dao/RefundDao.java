package com.hj.withus.admin.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.hj.withus.admin.model.vo.Refund;
import com.hj.withus.common.model.PageInfo;

@Repository
public class RefundDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("withusRefundMapper.rSelectListCount");
	}

	public ArrayList<Refund> selectList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("withusRefundMapper.rSelectList",null, rowBounds);
	}
	
	public Refund selectRefund(SqlSessionTemplate sqlSession, int refundNo) {
		return sqlSession.selectOne("withusRefundMapper.selectRefund", refundNo);
	}
}
