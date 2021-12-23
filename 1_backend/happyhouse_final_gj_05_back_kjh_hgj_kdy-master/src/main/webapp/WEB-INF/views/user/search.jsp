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
	<form id="searchform" class="text-left mb-3" method="post" action="">
		<div class="mb-3">
			<!--<select name="selectOption">
				<option value="ID" selected="ID">아이디</option>
				<option value="name" selected="name">이름</option>
				<option value="address" selected="address">이메일</option>
				<option value="phone" selected="phone">휴대폰 번호</option>
			</select>-->
			<input type="text" class="form-control" name="userid"
				placeholder="ID로 검색">
		</div>
		<button type="submit" class="btn btn-primary">검색</button>
	</form>
	
	<form id="resultform" class="text-left mb-3" method="post" action="">
		<div class="mb-3">
			<label for="inputName" class="form-label">ID </label>
			<input readonly="readonly" type="text" class="form-control" id="userid" name="userid"
				value = "${searchresult.userId}">
		</div>
		<div class="mb-3">
			<label for="inputName" class="form-label">Name </label>
			<input readonly="readonly" type="text" class="form-control" id="username" name="username"
				value = "${searchresult.name}">
		</div>
		<div class="mb-3">
			<label for="inputAddress" class="form-label">Address </label>
			<input readonly="readonly" type="email" class="form-control" id="emailid" name="address"
				value = "${searchresult.address}">
		</div>
		<div class="mb-4">
			<label for="inputPhoneNo" class="form-label">Phone Number </label>
			<input readonly="readonly" type="text" class="form-control" id="phone" name="phone"
				value = "${searchresult.phone}">
		</div>
	</form>

</body>
</html>