<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>피자 주문 페이지</h1>
	<h2>오늘의 날짜</h2>
	<%@ include file="includedPage.jsp" %>

	<br><br>

	<!-- localhost:8888/JSP/confirmPizza.do -->
	<form action="/JSP/confirmPizza.do">

		<fieldset>
			<legend>주문자정보</legend>
			<table>
				<tr>
					<th>이름</th>
					<td><input type="text" name="userName" required></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="phone" required></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address" size="40" required></td>
				</tr>
				<tr>
					<th>요청사항</th>
					<td><textarea name="message" cols="30" rows="5" style="resize:none"></textarea></td>
				</tr>
			</table>
		</fieldset>

		<fieldset>
			<legend>주문 정보</legend>
			<table>
				<tr>
					<th>피자</th>
					<td>
						<select name="pizza">
							<option>콤비네이션피자</option>
							<option>치즈피자</option>
							<option>포테이토피자</option>
							<option>고구마피자</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>토핑</th>
					<td>
						<input type="checkbox" name="topping" value="고구마무스"> 고구마무스
						<input type="checkbox" name="topping" value="파인애플"> 파인애플
						<input type="checkbox" name="topping" value="치즈크러스트"> 치즈크러스트
						<input type="checkbox" name="topping" value="치즈바이트"> 치즈바이트
					</td>
				</tr>
				<tr>
					<th>사이드</th>
					<td>
						<input type="checkbox" name="side" value="콜라"> 콜라
						<input type="checkbox" name="side" value="사이다"> 사이다
						<input type="checkbox" name="side" value="핫소스"> 핫소스
						<input type="checkbox" name="side" value="피클"> 피클
						<input type="checkbox" name="side" value="파마산치즈가루"> 파마산치즈가루
					</td>
				</tr>
			</table>
		</fieldset>

		<br><br>
		<button type="submit">주문</button>

	</form>
	
	
	
</body>
</html>