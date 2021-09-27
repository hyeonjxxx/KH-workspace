<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% // 스크립틀릿 : 이안에 일반적인 자바코드 작성 가능 (변수 선언 및 초기화, 제어문 등등)
		int sum = 0;
	
		for(int i=1; i<=100; i++){
			sum += i;
		}
		
		System.out.println("덧셈끝! 결과 : " + sum);
	%>
	
	<p>
		화면으로 출력하고자 한다면 <br>
		스크립틀릿 이용해서 출력 가능 : <% out.println(sum); %> <br>
		표현식(출력식)으로 출력 가능 : <%= sum %>
	</p>
	
	<%
		String[] name = {"김말똥", "홍길동", "이순신", "강개순"};
	%>
	
	<h5>배열의 길이 : <%= name.length %></h5>

	<h4>반복문을 이용해서 요소를 만들어 화면에 출력</h4>
	
	<ul>
		<%--  
		<% for(int i=0; i<name.length; i++){ %>
			<li><%= name[i] %></li>
		<% } %>
		--%>
		
		<% for(String str : name){ %>
			<li><%= str %></li>			
		<% } %>
		
	</ul>
	
	
	
</body>
</html>




