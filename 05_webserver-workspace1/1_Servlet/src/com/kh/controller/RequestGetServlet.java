package com.kh.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RequestGetServlet
 */
@WebServlet("/test1.do")
public class RequestGetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestGetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//System.out.println("잘 실행되나?");
		
		/*
		 *  Get방식으로 요청하게되면 doGet 메소드 알아서 실행됨
		 *  
		 *  첫번째 파라미터인 HttpServletRequest에는 사용자가 요청한 내용들을 받아주는 용도
		 *  두번째 파라미터인 HttpServletResponse는 요청 처리 후 나중에 사용자에게 응답을 해줄 때 사용할 용도
		 *  
		 *  request : 요청시 전달된 내용(사용자가 입력한 값, 요청전송방식, 요청한 사용자의 ip 등등)이 담겨있음
		 *  response : 요청 처리 후 응답할 때 사용할 객체 (즉, 응답페이지에 대한 작업시 사용할 예정)
		 *  
		 *  
		 *  우선 요청처리하기 위해 전달된 값들을 뽑아야됨!! (request의 parameter영역에 키-밸류 세트로 담겨있음)
		 *  > request.getParameter("키값") : String(문자열)
		 *           그에 해당하는 value값 반환 (단, 키값이 존재하지 않을 경우 null 반환)
		 *           
		 *  > request.getParameterValues("키값") : String[]
		 *  		  그에 해당하는 value값들을 String베열에 담아서 반환 (단, 키값이 존재하지 않을 경우 null반환)
		 * 
		 */
		
		String name = request.getParameter("name");				// "홍길동"		/ ""
		String gender = request.getParameter("gender");			// "M" | "F"	/ null
		int age = Integer.parseInt(request.getParameter("age"));// "20"=>20		/ ""=>오류
		String city = request.getParameter("city");				// "서울"
		double height = Double.parseDouble(request.getParameter("height")); // "170"=>170.0
		
		// 체크박스와 같이 복수개의 데이터 받을 때는 배열로 받아야됨
		String[] foods = request.getParameterValues("food");	// ["한식", "양식"] / null
		
		System.out.println("name : " + name);
		System.out.println("gender : " + gender);
		System.out.println("age : " + age);
		System.out.println("city : " + city);
		System.out.println("height : " + height);
		
		if(foods != null) { // NullPointerException방지차원
			for(int i=0; i<foods.length; i++) {
				System.out.println("foods[" + i + "] : " + foods[i]);
			}
		}
		
		// 원래는 이렇게 뽑은값들을 > service > dao > sql 실행 후 결과 리턴되서 돌아올 것
		// 돌아온 결과를 가지고 사용자가 보게될 응답 view 지정
		/*
		int result = new MemberService().insertMember(name, gender, age, city, height, foods);
		if(result > 0) { // 성공
			
		}else { // 실패
			
		}
		*/
		
		// 다 요청처리됐다는 가정하에 그에 해당하는 응답페이지 만들어서 사용자에게 다시 전달
		// 즉, 여기 Java 코드 내에 사용자가 보게될 응답 html 만드는 구문을 작성할꺼임!!
		
		// 장점 : Java코드내에 작성하기 때문에 반복문이나 ,조건문, 유용한메소드 같은걸 활용할 수 있음!
		// 단점 : 겁나 복잡함, 혹시 html을 수정하고자 했을 때 결국 Java코드를 수정하는거기 때문에 서버 리스타트해야됨
		
		// * response객체를 통해 사용자에게 html(응답화면) 전달
		// 1) 이제부터 내가 전달할 내용은 문서형태의 html이고 문자셋은 utf-8이다 라는걸 지정
		response.setContentType("text/html; charset=UTF-8");
		// 2) 응답하고자하는 사용자(요청했던 사용자)와의 스트림(클라이언트와의 길)생성
		PrintWriter out = response.getWriter();
		// 3) 그 스트림을 통해 html구문을 한줄씩 출력
		out.println("<html>");
		out.println("<head>");
		out.println("<title>개인정보출력화면</title>");
		out.println("<style>");
		out.println("h2{color:red;}");
		out.println("#name{color:orange; font-weight:bold;}");
		out.println("#age{color:yellow;}");
		out.println("#city{color:blue;}");
		out.println("#height{color:green;}");
		out.println("#gender{color:purple;}");
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");
		
		out.println("<h2>개인정보 결과 화면 </h2>");
		
		//out.println("<span id='name'>" + name + "</span>님은 ");
		out.printf("<span id='name'>%s</span>님은 ", name);
		out.printf("<span id='age'>%d</span>살이며, ", age);
		out.printf("<span id='city'>%s</span>에 사는 ", city);
		out.printf("키는 <span id='height'>%.1f</span>cm 이고 ", height);
		out.print("성별은 ");
		
		if(gender != null) {
			if(gender.equals("M")) {
				out.println("<span id='gender'>남자</span>입니다. <br>");
			}else {
				out.println("<span id='gender'>여자</span>입니다. <br>");
			}			
		}else {
			out.println("선택을 안했습니다. <br>");
		}
		
		out.print("좋아하는 음식은 ");
		if(foods != null) {
			out.println("<ul>");
			for(int i=0; i<foods.length; i++) {
				out.printf("<li>%s</li>", foods[i]);
			}
			out.println("</ul>");
		}else {
			out.println("없습니다.");
		}
		
		out.println("</body>");
		out.println("</html>");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
