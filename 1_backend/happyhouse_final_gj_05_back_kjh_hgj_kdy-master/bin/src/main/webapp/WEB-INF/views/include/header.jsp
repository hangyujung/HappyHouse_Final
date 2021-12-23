<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- jquery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Bootstrap & Custom CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%-- <link rel="stylesheet" href="${root}/css/style.css"> --%>

<!-- Google Map & Check Box	 -->
<script type="application/javascript"
	src="https://zelkun.tistory.com/attachment/cfile8.uf@99BB7A3D5D45C065343307.js"></script>
<script async
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB3orX8_61MJpFJ7vZ6sf5nCqgnJyKWook&callback=initMap&libraries=&v=weekly">
       </script>
       
<!-- fontawesome -->
<script src="https://kit.fontawesome.com/b596fe4108.js" crossorigin="anonymous"></script>

<!-- Core theme JS-->
<script src="/js/location.js"></script>
<script src="/js/map.js"></script>




<title>HappyHouse</title>
</head>
<body> 
<header>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-dark">

		<div class="container-fluid">
		<a class="navbar-brand" href="${root}/">HappyHouse</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<ul class="navbar-nav me-auto mb-2 mb-md-0">
					<li class="nav-item"><a class="nav-link active" href="${root}/house/">아파트 거래 정보</a></li>
					<c:if test="${empty userinfo}">
						<li class="nav-item"><a class="nav-link active primary"
							style="color: $purple;" aria-current="page"
							href="${root }/user/register">회원가입</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="${root }/user/login">로그인</a></li>
					</c:if>
					<c:if test="${!empty userinfo}">
						<li class="nav-item">
							<span class="nav-link active">${userinfo.name}님 안녕하세요.</span>
						</li>
						<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="${root }/user/mypage">마이페이지</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page"
							href="${root}/user/logout">로그아웃</a>
						</li>						
						<li class="nav-item">
							<a class="nav-link active" aria-current="page"
							href="${root}/house/mark">내 관심지역</a>
						</li>		
					</c:if>
					<c:if test="${userinfo.userId eq 'admin' }">
						<li class="nav-item"><a class="nav-link active" aria-current="page"
								href="${root}/user/search">회원 검색</a></li>
						<li class="nav-item"><a class="nav-link active" aria-current="page"
								href="${root}/user/list">회원 목록</a></li>
					</c:if>
				</ul>
				<form class="d-flex">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-warning" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>

</header>
	<%-- 

  <div class="container-fluid">
    <a class="navbar-brand" href="${root}/index.jsp">HappyHouse</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <ul class="nav justify-content-start">
	<li class="nav-item"><a class="nav-link active" href="${root}/apart?act=list">아파트 거래 정보</a></li>
	</ul>
    <div class="collapse navbar-collapse navAndsearch d-flex justify-content-end" id="navbarSupportedContent">
      <ul class="nav justify-content-end">
      <c:if test="${empty loginUser}">
	 	  <li class="nav-item">
		    	<a class="nav-link active" aria-current="page" href="${root}/user?act=mvregister">회원가입</a>
		  </li>
		  <li class="nav-item">
		  	<a class="nav-link active" aria-current="page" href="${root}/user?act=mvlogin">로그인</a>
		  </li>
      </c:if>
	 <c:if test="${!empty loginUser}">
	 	  <li class="nav-item">
		    	<span class="nav-link active">${loginUser.uname}님 안녕하세요.</span>
		  </li>
		  <li class="nav-item">
		  	<a class="nav-link active" aria-current="page" href="${root}/user?act=mypage&userid=${userinfo.userId}">마이페이지</a>
		  	<a class="nav-link active" aria-current="page" href="${root}/user?act=logout">로그아웃</a>
		  </li>
      </c:if>
	</ul>
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>
 --%>
