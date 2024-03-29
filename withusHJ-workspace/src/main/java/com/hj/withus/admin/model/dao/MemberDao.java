package com.hj.withus.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.hj.withus.admin.model.vo.Member;
import com.hj.withus.common.model.PageInfo;

@Repository
public class MemberDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("withusMemeberMapper.mSelectListCount");
	}
	
	public ArrayList<Member> selectList (SqlSessionTemplate sqlSession, PageInfo pi){

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); //몇개의 게시물을 건너 뛰고
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("withusMemeberMapper.mSelectList", null, rowBounds);
	}	
	
	public Member selectMemStatus(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("withusMemeberMapper.selectMemStatus", memberNo);
	}
	
	public int deleteMember(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("withusMemeberMapper.deleteMember", map);
	}

	public int countSearch(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("withusMemeberMapper.countSearch", map);
	}

	public ArrayList<Member> searchMember(SqlSessionTemplate sqlSession, HashMap<String, String> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("withusMemeberMapper.searchMember", map, rowBounds);
	}


}
