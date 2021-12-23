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
		<%@ include file="/WEB-INF/views/include/header.jsp"%>

		<h2>상품 등록</h2>
		<form>
			<input type="text" id="pName" placeholder="상품명을 입력하세요." /><br>
			<input type="text" id="pPrice" placeholder="상품가격을 입력하세요." /><br> 
			<input type="text" id="pDesc" placeholder="상품설명을 입력하세요." /><br> 
			<input type="button" id="submit" value="제출하기" />
		</form>

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	</div>

	<div id="ajaxResult"></div>
	<script>
		$('#submit').on('click', function() {
			$.ajax({
				url:"${root}/rest/product/",
				type:"post",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(formToObj()),
				success:function(res) {
					//console.log(res);
					if(res.success){						
						$("#ajaxResult").html("추가 성공");
					}else{
						$("#ajaxResult").html("추가 실패");
					}
				},
				error : fail
			});
		})

		function formToObj() {
			let obj = {};
			obj.pName = $("#pName").val();
			obj.pPrice = $("#pPrice").val();
			obj.pDesc = $("#pDesc").val();
			console.log(obj.pName+","+obj.pPrice+","+obj.pDesc)
			return obj;
		}

		function fail() {
			alert("ajax 처리 실패");
		}
	</script>
</body>
</html>