<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>SSAFY House</title>

<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800"
	rel="stylesheet" type="text/css" />
	
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${root}/user/css/styles.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
</head>
<body>
	<%-- 
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="${root}/index.jsp">SSAFY House</a>
		</div>
	</nav> --%>
	<!-- Page Header-->
	<header class="masthead">
		<div class="container position-relative px-4 px-lg-5 py-1">
			<div class="row gx-3 gx-lg-5 justify-content-center">
				<div class="col-md-10 col-lg-8 col-xl-7">
					<div class="page-heading">
						<h1>SIGN IN</h1>
					</div>
				</div>
			</div>
		</div>
	</header>
	<!-- Main Content-->
	<main class="mb-5">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-md-10 col-lg-8 col-xl-7">
				<form id="memberform" class="text-left mb-3" method="post" action="">
					<div class="mb-3">
						<label for="inputID" class="form-label">ID *</label> <input
							type="text" class="form-control" id="userid" name="userid"
							placeholder="아이디 입력">
					</div>
					<div class="mb-3">
						<label for="inputPassword" class="form-label">Password *</label> <input
							type="password" class="form-control" id="userpwd" name="userpwd"
							placeholder="영문 숫자 포함 6자리 이상 16자리 이하">
					</div>
					<div class="text-danger mb-2">${msg}</div>
					<button type="submit" class="btn btn-primary">SignIn</button>
					<button type="reset" class="btn btn-secondary">Reset</button>
				</form>
			</div>
		</div>
	</div>
	</main>
	
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="${root}/user/js/scripts.js"></script>
</body>

<script>

</script>

</html>
