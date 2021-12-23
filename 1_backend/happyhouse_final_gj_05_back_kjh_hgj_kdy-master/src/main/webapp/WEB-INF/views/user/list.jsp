<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br><br><br><br>
	<h1>회원 목록</h1>
	<ol>
		<c:if test="${!empty userlist }">
			<c:forEach var="info" items="${userlist}">
				<li><c:out value="이름: ${info.name} ID: ${info.userId} 비밀번호: ${info.password} 이메일: ${info.address} 휴대폰번호: ${info.phone}"></c:out>
			</c:forEach>
		</c:if>
	</ol>
</body>
</html>