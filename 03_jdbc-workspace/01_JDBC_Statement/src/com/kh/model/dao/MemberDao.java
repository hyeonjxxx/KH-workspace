package com.kh.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.kh.model.vo.Member;

// DAO (Date Access Object)
// Controller를 통해서 호출된 수행하기 위해서
// DB에 직접적으로 접근 한 후 해당 SQL문 실행 및 결과 받기 (JDBC)
public class MemberDao {
	
	/*
	 * 	* JDBC용 객체
	 * 	- Connection : DB의 연결정보를 담고있는 객체
	 * 	- [Prepared]Statement : 해당 DB에 SQL문을 전달하고 실행한 후 결과를 받아내는 객체
	 * 	- ResulSet : 만일 실행한 SQL문이 select문일 경우 조회된 결과들이 담겨있는 객체
	 * 
	 * 	* JDBC 처리 순서
	 * 1) jdbc driver 등록 : 해당 DBMS가 제공하는 클래스 등록
	 * 2) Connection 생성 : 접속하고자 하는 DB정보를 입력해서 DB에 접속하면서 생성
	 * 3) Statement 생성: Connection 객체를 이용해서 생성
	 * 4) sql문 전달하면서 실행 : Statement객체를 이요해서 SQL문 실행
	 * 			> SELECT문일 경우 -> executeQuery메소드를 이용해서 실행
	 * 			> DML문일 경우 -> excuteUpdate메소드를 이용해서 실행
	 * 5) 결과 받기
	 * 			> SELECT문일 경우 -> ResultSet 객체(조회된 데이터들이 담겨있음)로 받기  	=> 6_1) 
	 * 			> DML문일 경우 -> int(처리된 행수)로 받기  							=> 6_2)
	 * 6_1) ResultSet에 담겨있는 모든 데이터들 하나씩 하나씩 뽑아서 vo객체에 주섬주섬 담기
	 * 6_2) 트랜잭션 처리(성곡적이면 commit, 실패면 rollback)
	 * 
	 * 7) 다 쓴 JDBS용 객체들 반드시 자원반납(close)  => 생성된 역순으로
	 * 
	 * 8) 결과 반환(Controller)
	 * 			> SELECT문일 경우 - 6_1) 만들어진 결과
	 * 			> DML문일 경우 - int(처리된 행수)
	 * 
	 * 
	 * 	** Statement 특징
	 * 		: 완정된 SQL문을 실행할 수 있는 객체
	 * 
	 */

	/**
	 * 사용자가 추가 요청시 입력했던 값들을 가지고 insert문 실행하는 메소드
	 * @param 	사용자가 입력한 아이디~취미 까지의 값들이 잔뜩 담겨있는 Member객체
	 * @return 
	 */
	public int insertMember(Member m) {	// insert문 => 처리된 행 수 => 트랜잭션 처리
		
		// 필요한 변수들 먼저 셋팅
		int result = 0;			// 처리된 결과(처리된 행수)를 담아줄 변수
		Connection conn = null;	// 접속된DB의 연결정보를 담는 변수
		Statement stmt = null;	// SQL문 실행 후 결과를 받기 위한 변수
		
		// 실행할 SQL문(완성형태로 만들어줄것!!) => 끝에 세미콜론 있으면 안됨!!
		// INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVALM, 'XXX', 'XXX', 'XXX', 'X', XX, '','XXXX', 'XX', 'XX', SYSDATE);
		String sql = "INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL, "
										 + "'" + m.getUserId() + "', "
										 + "'" + m.getUserPwd() + "', "
										 + "'" + m.getUserName() + "', "
										 + "'" + m.getGender() + "', "
										 	   + m.getAge() + ", "
										 + "'" + m.getEmail() + "', "	   
										 + "'" + m.getPhone() + "', "
										 + "'" + m.getAddress() + "', "
										 + "'" + m.getHobby() + "', SYSDATE)";
		//System.out.println(sql);
		
		try {
			// 1) jdbc driver 등록
			Class.forName("oracle.jdbc.driver.OracleDriver"); // ojdbc6.jar 누락됐다거나, 잘 추가됐지만 오타가 있을 경우 => ClassNotFoindException 발생
			
			// 2) Connection 객체 생성 (DB와 연결 --> url, 계정명, 비밀번호)
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "JDBC", "JDBC");
			
			// 3) Statement 객체 생성
			stmt = conn.createStatement();
			
			// 4, 5) DB에 완선된 sql문 전달하면서 실행 후 결과(처리된행수) 받기
			result = stmt.executeUpdate(sql);
			
			// 6_2) 트랜잭션 처리
			if(result > 0) {   //성공했을 경우
				conn.commit();
			}else {		// 실패했을 경우
				conn.rollback();
			}
			
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			try {
					// 7) 다쓴 JDBC용 객체 지원 반납  => 생성된 역순으로 close
					stmt.close();
					conn.close();
			} catch (SQLException e) {
					e.printStackTrace();
			}
			
		}
			
		// 8) 결과 반환
		return result; // 처리된 행수
		
	}	
	
	
	
	public ArrayList<Member> selectList() { // select문 => ResultSet 객체 (여러행)
		
		// 필요한 변수들 세팅
		// 조회된 결과 뽑아서 담아줄 ArrayList생성 (현재 텅빈 리스트)
		ArrayList<Member> list = new ArrayList<>(); // 조회된 회원들(여러회원) == 여러행
		
		Connection conn = null; // DB 연결정보를 담는 객체
		Statement stmt = null;  // sql문 실행 및 결과 받기
		ResultSet rset = null;  // select문 실행된 조회결과값들이 처음에 실질적으로 담길 객체
		
		// 실행할 sql문 (완성된 형태로)
		String sql = "SELECT * FROM MEMBER";
		
		try {
			// 1) jdbc driver등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2) Connection 객체 생성
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
			
			// 3) Statement 객체 생성
			stmt = conn.createStatement();
			
			// 4, 5) sql문(select) 전달햐서  실행 후 결과(ResultSet) 받기
			rset = stmt.executeQuery(sql);
			
			//6_1) 현재 조회되 결과가 담긴 ResultSet으로부터 한행씩 움직여가며 조회결과 뽑아서 Vo객체에 주섬주섬 담기
			while(rset.next()) { // 커서를 한행 움직여주고 뿐만아니라 해당 행이 존재할 경우 true / 아니면 false를 반환
				
				// 현재 rset의 커서가 가리키고 있는 해당 행의 데이터를 하나씩 뽑아서 Memeber객체에 주섬주섬 담기
				Member m = new Member();
				// rset으로부터 어떤 컬럼에 해당하는 값을 뽑을건지 제시해주면 됨! (컬럼명 == 대소문자 가리지 않음)
				m.setUserNo(rset.getInt("USERNO"));
				m.setUserId(rset.getString("USERID"));
				m.setUserPwd(rset.getString("USERPWD"));
				m.setUserName(rset.getString("USERNAME"));
				m.setGender(rset.getString("GENDER"));
				m.setAge(rset.getInt("AGE"));
				m.setEmail(rset.getString("EMAIL"));
				m.setPhone(rset.getString("PHONE"));
				m.setAddress(rset.getString("ADDRESS"));
				m.setHobby(rset.getString("HOBBY"));
				m.setEnrollDate(rset.getDate("ENROLLDATE"));
				// 한 행에 대한 모든 데이터값들이 하나의  Member객체에 옯겨담는 거 끝!
				
				// 리스트에 해당 Member객체 차곡차곡 담아둘꺼임!
				list.add(m);
				
			}
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {
					// 7) 다쓴 JDBC용 객체 지원 반납  => 생성된 역순으로 close
					rset.close();
					stmt.close();
					conn.close();
					
			} catch (SQLException e) {
					e.printStackTrace();
			}
			
		}
		
		// 8) 결과반환 (조회된 결과들이 뽑혀서 싹다 담겨있는 있는 list)
		return list;
	}
	
	public Member selectByUserId(String userId) { //select문 => ResultSet객체 (한 행 조회)
	
		// 필요한 변수 세팅
		// 조회된 한 회원에 대한 정보를 담을 변수
		Member m = null;
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		// 실핼할 sql문(완성된 형태로)
		//SELECT * FROM MEMBER WHERE USERID = 'XXXX';
		String sql = "SELECT * FROM MEMBER WHERE USERID = '" + userId + "'";
		
		//
		try {
			// 1)
			Class.forName("oracle.jdbc.driver.OracleDriver");
		
			// 2)
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "JDBC", "JDBC");
		
			// 3) 
			stmt = conn.createStatement();
			
			// 4, 5) 
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) { // 커서를 한 행 움직여보고 조회결과가 있다면 true 없다면 false반환 
				
				// 조회된 한 행에 대한 데이터값들 뽑아서 하나의  Member객체 담기
				m = new Member(rset.getInt("USERNO"),
							   rset.getString("USERID"),
							   rset.getString("userpwd"),
							   rset.getString("username"),
							   rset.getString("GENDER"),
							   rset.getInt("AGE"),
							   rset.getString("EMAIL"),
							   rset.getString("PHONE"),
							   rset.getString("address"),
							   rset.getString("hobby"),
							   rset.getDate("enrolldate"));
				
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			
			try {
				// 7)
				rset.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		// 8) 
		return m;			
	}
	
	
	public ArrayList<Member> selectByUserName(String keyword) { // select문 => ResultSet객체 (여러행)
		
		// 필요한 변수들 세팅
		ArrayList<Member> list = new ArrayList<>();
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		// 실행항 sql문(완성된 형태로)
		// SELECT * FROM MEMBER WHERE USERNAME LIKE '%XX%';
		String sql = "SELECT * FROM MEMBER WHERE USERNAME LIKE '%" + keyword + "%'";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				
				// 해당 조회된 한 행에 데이터들을 한 Member객체에 담기 => list에 추가
				list.add(new Member(rset.getInt("userno"),
									rset.getString("USERID"),
									rset.getString("userpwd"),
									rset.getString("USERNAME"),
									rset.getString("GENDER"),
									rset.getInt("age"),
									rset.getString("EMAIL"),
									rset.getString("PHONE"),
									rset.getString("ADDRESS"),
									rset.getString("hobby"),
									rset.getDate("enrolldate")));	
			}
						
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			
			try {
				rset.close();
				conn.close();
				stmt.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
		return list;	
	}
	
	
public int updateMember(Member m) { // update문 => 처리된행수(int) => 트랜잭션 처리
		
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		// 실행할 sql문
		/*
		 * UPDATE MEMBER SET USERPWD = 'XXX', EMAIL = 'XXX', PHONE = 'XXXX', ADDRESS = 'XXXX' WHERE USERID = 'XXXX'
		 */
		String sql = "UPDATE MEMBER SET USERPWD = ?, EMAIL = ?, PHONE = ?, ADDRESS = ? WHERE USERID = ?";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "JDBC", "JDBC");
			pstmt = conn.prepareStatement(sql); // 미완성된 sql문 바로 실행 불가
			
			pstmt.setString(1, m.getUserPwd());
			pstmt.setString(2, m.getEmail());
			pstmt.setString(3, m.getPhone());
			pstmt.setString(4, m.getAddress());
			pstmt.setString(5, m.getUserId());
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}else {
				conn.rollback();
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
		
	}
	
	public int deleteMember(String userId) {  // delete문 => 처리된 행수 => 트랜잭션 처리
		
		// 필요한 변수 세팅
		// 조회된 한 회원에 대한 정보를 담을 변수
		int result = 0;	
		
		Connection conn = null;
		Statement stmt = null;
		
		// 실핼할 sql문(완성된 형태로)
		//DELETE FROM MEMBER WHERE USERID = 'XXXX';
		String sql = "DELETE FROM MEMBER WHERE USERID = '" + userId + "'";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "JDBC", "JDBC");
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			if( result > 0) {
				conn.commit();
			}else {
				conn.rollback();
			}
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return result;
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
