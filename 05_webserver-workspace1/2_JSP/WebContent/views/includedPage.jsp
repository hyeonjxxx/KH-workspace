<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h5{color:green}
	h1{color:red}
</style>
</head>
<body>
	
	<%
		Date now = new Date();
	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		String today = sdf.format(now); // "2021년 03월 26일"
	%>
	
	<h5><%= today %></h5>
	
	<% String message = "메롱"; %>
	
</body>
</html>




