<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="container">
		<%@ include file="/WEB-INF/views/include/header.jsp" %>
		<c:if test="${!empty products}">
			<table>
			<c:forEach var="item" items="${products}">
				
				<tr>
					<td>${item.no}</td>
					<td><a href="${root}/product/update?no=${item.no}">${item.name}</a></td>
					<td>${item.price}</td>
					<td>${item.desc}</td>
				</tr>
			</c:forEach>
			</table>
		</c:if>
		<div class="m-3 row justify-content-center">${navigation.navigator}</div>
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	
	<%-- <div class="container">
		<%@ include file="/WEB-INF/views/include/header.jsp" %>

		<ul id="list">
		
		</ul>
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	<div class="m-3 row justify-content-center">${navigation.navigator}</div>
	<script>
	function load(){
		$.ajax({
			url:"${root}/rest/product/pg=1/key=/word=",
			type:"get",
			success:function(res){
				console.log(res);
				$("#list").empty();
				$.each(res, function(idx, item){
					$("#list").append("<li id='"+item.no+"'>"+ item.name+", "+item.price+", "+item.desc);
				})
			},
			error:function(){}
		});
	}
	// 초기 화면 로딩
	load();
	</script> --%>
</body>
</html>