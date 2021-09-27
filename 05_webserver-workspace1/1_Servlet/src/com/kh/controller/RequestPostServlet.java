package com.kh.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RequestPostServlet
 */
@WebServlet("/test2.do")
public class RequestPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 요청시 전달값들은 request의 parameter라는 영역에 담겨있음
		// **** POST방식 같은 경우 request 담겨있는 값들을 뽑기 "전"에 !!! 인코딩을 UTF-8로  ****
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");				// "김말똥"	/ ""
		String gender = request.getParameter("gender");			// "M" "F"	/ null
		int age = Integer.parseInt(request.getParameter("age"));// "20"=>20 / ""=>오류
		String city = request.getParameter("city");		// "서울"
		double height = Double.parseDouble(request.getParameter("height")); 
		
		String[] foods = request.getParameterValues("food");
		
		System.out.println("name : " + name);
		System.out.println("gender : " + gender);
		System.out.println("age : " + age);
		System.out.println("city : " + city);
		System.out.println("height : " + height);
		
		if(foods != null) {
			for(int i=0; i<foods.length; i++) {
				System.out.println(foods[i]);
			}
		}
		
		// 요청처리 다 했다는 가정하에 사용자가 응답페이지 만들어서 사용자에게 출력
		
		// Servlet : Java 코드 내에 html을 기술
		// JSP(Java Server Page) : html내에 Java코드 기술가능 
		
		// 여기서 곧바로 응답화면(html) 안만들고 JSP로 떠넘겨서 만들꺼임!!
		// 단, 그 응답화면(jsp)에서 보여져야할 데이터들을 주섬주섬 담아서 보내줘야됨!!
		// 주섬주섬 담기위한 공간? : request의 attribute영역에 담기 (키-밸류 형태로 담아야됨)
		// request.setAttribute("키값", 밸류값);
		request.setAttribute("name", name);
		request.setAttribute("gender", gender);
		request.setAttribute("age", age);
		request.setAttribute("city", city);
		request.setAttribute("height", height);
		request.setAttribute("foods", foods);
		
		// 응답할 뷰 jsp 선택
		RequestDispatcher view = request.getRequestDispatcher("views/responsePage.jsp");
		view.forward(request, response);
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
