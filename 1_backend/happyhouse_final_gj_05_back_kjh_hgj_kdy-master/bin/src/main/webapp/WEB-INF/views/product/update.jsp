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
		
		<h2>상품 등록</h2>
		<form action="${root}/product/update" method="POST">
			<input type="hidden" name="no" id="no" placeholder="상품명을 입력하세요." value="${product.no}"/><br>
			<input type="text" name="pName" id="pName" placeholder="상품명을 입력하세요." value="${product.name}"/><br>
			<input type="text" name="pPrice" id="pPrice" placeholder="상품가격을 입력하세요." value="${product.price}"/><br>
			<input type="text" name="pDesc" id="pDesc" placeholder="상품설명을 입력하세요." value="${product.desc}"/><br>
			<input type="submit" value="수정하기"/> 
			<input type="button" id="delete" value="삭제하기"/> 
		</form>
		
		<script>
				
			$('#delete').on('click',function(){
				location.replace('${root}/product/delete?no=${product.no}');					
			});
		
		</script>
		
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>