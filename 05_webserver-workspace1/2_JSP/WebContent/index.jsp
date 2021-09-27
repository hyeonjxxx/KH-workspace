<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- HTML 주석 : 개발자 도구 탭에 노출됨 -->
	<%--  JSP 주석 : 개발자 도구 탭에 노출안됨 --%>

	<h1>* JSP (Java Server Page)</h1>
	
	<p>
		JSP란, HTML형식 내에 자바코드를 사용할 수 있는 "자바 언어"로 <br>
		서블릿(Java코드)에서 응답화면(html)을 구현했던 복잡함을 간단하게 해결 가능 <br>
		=> 즉, JSP의 가장 큰 장점은 Servlet에서는 비즈니스 로직 처리에만 집중하고 <br>
		     응답화면을 만들어(프레젠테이션로직)내는건 JSP에서 집중하게끔 분리할 수 있는 것
	</p>
	
	<hr>
	
	<h1>JSP Elements 표현법</h1>
	
	<h2>1. JSP 스크립팅 원소 (Scripting Element)</h2>
	<p>JSP페이지에서 자바 코드를 기술할 수 있게 해주는 기능</p>
	<ol>
		<li>
			선언문 : &lt;%!  자바코드  %&gt; <br>
			멤버변수와 메소드를 선언하기 위해 사용 <br><br>
		</li>
		<li>
			스크립틀릿 : &lt;%  자바코드   %&gt; <br>
			JSP에서 자바코드를 기술하기 위한 제일 기본적인 표현법<br><br>
		</li>
		<li>
			표현식(출력식) : &lt;%=  자바코드   %&gt; <br>
			자바에서 작성한 값(또는 메소드 호출)을 화면에 출력하기 위해 사용
		</li>
	</ol>
	
	<a href="views/01_ScriptingElement.jsp">View details &raquo;</a>
	
	<hr>
	
	<h2>2. 지시어 (Directive) &lt;%@ page|include|taglib 속성="속성값" 속성="속성값" .. %&gt;</h2>
	<p>현재 해당 JSP 페이지의 전체 정보를 기술할 때 쓰임</p>
	
	<ol>
		<li>
			page 지시자 : 현재의 JSP페이지를 처리하는데 필요한 각종 속성을 기술하는 부분 (JSP문서의 최상단에 위치) <br>
			<ul>
				<li>language : 현재 jsp에서 사용할 스크립트 언어 유형을 지정</li>
				<li>contentType : 웹 브라우저가 받아 볼 페이지의 형식, 인코딩 방식 지정</li>
				<li>pageEncoding : jsp파일에 기록된 자바코드의 인코딩 방식을 지정</li>
				<li>import : 자바와 import와 같은 의미</li>
				<li>errorPage / isErrorPage : 오류페이지 관련 </li>
			</ul>
			<a href="views/02_directivePage.jsp">View details &raquo;</a>
		</li>
		<li>
			include 지시자 : 현재 jsp에서 또다른 jsp를 포함하고자 할 때 사용하는 지시자 <br>
			<a href="views/03_directiveInclude.jsp">View details &raquo;</a>
		</li>
		<li>
			taglib 지시자 : JSP의 기능을 좀 더 확장할 수 있는 인자로 추가적인 라이브러리 등록 구문
		</li>
	</ol>
	
	<hr>
	
	<h2>피자주문페이지  --주문요청--> 요청받아서 처리해주는 Servlet --> 피자결제페이지(응답페이지) </h2>
	<a href="views/04_pizzaOrderForm.jsp">피자주문페이지</a>
	
	
	
	
	
	
	
	
	
</body>
</html>