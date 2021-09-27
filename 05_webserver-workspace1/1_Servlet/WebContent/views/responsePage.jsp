<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% // 이구문을 스크립틀릿(scriptlet)이라고 해서 html내에 자바코드를 기술할 수 있는 영역

	// request의 attribute담겨있는 데이터를 뽑을거임!!
	// request.getAttribute("키값") : Object (그에 해당하는 밸류값 반환)
	String name = (String)request.getAttribute("name");
	String gender = (String)request.getAttribute("gender");
	int age = (int)request.getAttribute("age");
	String city = (String)request.getAttribute("city");
	double height = (double)request.getAttribute("height");
	String[] foods = (String[])request.getAttribute("foods");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h2{color:red;}
	#name{color:orange; font-weight:bold}
	#age{color:green;}
	#city{color:pink;}
	#height{color:navy;}
	#gender{color:purple;}
</style>
</head>
<body>
	<h2>개인 정보 결과 화면</h2>
	
	<span id="name"><%= name %></span>님은 
	<span id="age"><%= age %></span>살이며, 
	<span id="city"><%= city %></span>에 사는 
	키는 <span id="height"><%= height %></span>cm 이고 
	
	성별은
	<% if(gender != null){ %>
		<% if(gender.equals("M")){ %>	
			<span id="gender">남자</span>입니다. <br>
		<% }else{ %>
			<span id="gender">여자</span>입니다. <br>		
		<% } %>
	<% }else{ %>
		선택하지 않았습니다. <br>
	<% } %>
	
	좋아하는 음식은
	<% if(foods != null){ %>	
		<ul>
			<% for(int i=0; i<foods.length; i++){ %>
				<li><%= foods[i] %></li>
			<% } %>
		</ul>
	<% }else{ %>	
		없습니다. <br>
	<% } %>
	
</body>
</html>


