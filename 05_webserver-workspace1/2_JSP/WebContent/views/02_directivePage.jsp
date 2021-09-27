<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>page 지시자</h1>
	
	<%
		int sum = 0;
	
		for(int i=1; i<=100; i++){
			sum += i;
		}
		
		ArrayList<String> list = new ArrayList<>();
		list.add("Servlet");// 0번 인덱스
		list.add("JSP");    // 1번 인덱스
		
		Date today = new Date(); // 현재 날짜 (년월일시분초) == 시스템날짜		
		
	%>
	
	<p>
		덧셈결과 : <%= sum %> <br>
		오늘날짜 : <%= today %> <br>
		리스트의 길이 : <%= list.size() %> <br>
		list.get(0) : <%= list.get(0) %> 
	</p>
	
	
	<p>
		<%= list.get(10) %>
	</p>	
	
	
</body>
</html>