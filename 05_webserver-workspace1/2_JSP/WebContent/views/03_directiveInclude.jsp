<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>include 테스트</h1>

	현재날짜
	<%@ include file="includedPage.jsp" %>
	
	메세지 : <%= message %>
	
	

	
</body>
</html>