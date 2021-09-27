package com.kh.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PizzaServlet
 */
@WebServlet("/confirmPizza.do")
public class PizzaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PizzaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// 1) 전달값 중에 한글이 있을 경우 대비 인코딩 utf-8 (post방식일때만)
		//request.setCharacterEncoding("utf-8");
		
		// 2) 요청시 전달온 값을 뽑기 (request의 parameter영역으로부터)
		//	  >> request.getParameter("키값") : 밸류값(String 타입)
		//	  >> request.getParameterValues("키값") : 밸류값들(String[] 타입)
		String userName = request.getParameter("userName");	// "홍길동"
		String phone = request.getParameter("phone");		// "01011112222"
		String address = request.getParameter("address");	// "서울시 관악구"
		String message = request.getParameter("message");	// "빨리" / ""
		
		String pizza = request.getParameter("pizza");		// "콤비네이션피자"
		String[] toppings = request.getParameterValues("topping"); // ["", ""] / null
		String[] sides = request.getParameterValues("side");// ["", "", ""] / null
				
		// 3) 요청처리 (비즈니스로직처리)
		// >> service >> dao >> sql문 실행
		// 요청 처리 다 했다는 가정하에 
		int price = 0;
		
		switch(pizza) {
		case "콤비네이션피자" : price += 5000; break;
		case "치즈피자" : price += 6000; break;
		case "포테이토피자" : 
		case "고구마피자" : price += 7000; break;
		}
		
		if(toppings != null) {
			for(int i=0; i<toppings.length; i++) {
				switch(toppings[i]) {
				case "고구마무스" : price += 2000; break;
				case "파인애플" :
				case "치즈크러스트" : price += 3000; break;
				case "치즈바이트" : price += 4000; break;
				}
			}
		}
		
		if(sides != null) {
			for(int i=0; i<sides.length; i++) {
				switch(sides[i]) {
				case "콜라" : 
				case "사이다" : price += 2000; break;
				case "핫소스" : 
				case "파마산치즈가루" : price += 300; break;
				case "피클" : price += 500; break;
				}
			}
		}
		
		// 4) 요청처리 후 결과를 가지고 사용자가 보게될 응답페이지 만들기 혹은 jsp위임
		//    응답페이지에 필요한 데이터 => request의 attribute에 담아서 전달
		request.setAttribute("userName", userName);
		request.setAttribute("phone", phone);
		request.setAttribute("address", address);
		request.setAttribute("message", message);
		
		request.setAttribute("pizza", pizza);
		request.setAttribute("toppings", toppings);
		request.setAttribute("sides", sides);
		
		request.setAttribute("price", price);
	
		// 응답페이지(jsp)를 선택하기
		RequestDispatcher view = request.getRequestDispatcher("views/05_pizzaPayment.jsp");
		// 선택된 view에 request, response 전달하면서 포워딩
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
