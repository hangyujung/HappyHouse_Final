<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Framework Project</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="img/favicon.ico">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/apt.css">
	<link rel="stylesheet" href="/css/house.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>



		<!-- nav start -->
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark rounded" style="margin-top: 100px;">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="#">Home</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
						동네 정보
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">APT 매매</a>
						<a class="dropdown-item" href="#">APT 전월세</a>
						<a class="dropdown-item" href="#">주택 매매</a>
						<a class="dropdown-item" href="#">주택 전월세</a>
						<a class="dropdown-item" href="#">상권 정보</a>
						<a class="dropdown-item" href="#">환경 정보</a>
					</div>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Notice</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">News</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Contact</a>
				</li>
			</ul>
		</nav>

		<section id="index_section">
			<!-- map -->
			<div id="map" style="width:100%;height:500px;"></div>
			<div class="card col-sm-12 mt-1" style="min-height: 850px;">
				<div class="card-body">
				
					<!-- table -->
					<table class="table mt-2">
						<colgroup>
							<col width="200">
							<col width="250">
							<col width="*">
							<col width="200">
							<col width="200">
							<col width="200">
						</colgroup>	
						<thead class="tab">
							<tr>
								<th>번호</th>
								<th>아파트이름</th>
								<th class="text-center">주소</th>
								<th>건축연도</th>
								<th>최근거래금액</th>
								<th>관심지역 삭제</th>
							</tr>
						</thead>
						<tbody id="searchResult" class="tab"></tbody>
					</table>
					

				
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=629ba7de2bc4c7e737eaf4eda1f7c466&libraries=services"></script>
				<script type="text/javascript" src="/js/map.js"></script>
				<script type="text/javascript">
				
				// 회원정보
				var user = '<%=session.getAttribute("userNo")%>';
				console.log(user);
				
				$(document).ready(function(){	
					get();
				});

				function get(){	
					$.get(root + "/map/myMark"
						,function(data, status){
						console.log(data);
						$("tbody").empty();
						$.each(data, function(index, vo) {
							console.log(data);

							let str = `
								<tr>
									<td>`+vo.aptCode+`</td>
									<td>`+vo.aptName+`</td>
									<td>`+vo.sidoName + vo.gugunName + vo.dongName + vo.jibun+`</td>
									<td>`+vo.buildYear+`</td>
									<td>`+vo.recentPrice+`</td>`;
							if(user!='null'){
								str +=`<td class="cart" id=`+vo.aptCode+`><i class="fas fa-times"></i></td></tr>`;
							}else{
								str +=`</tr>`;
							}

							//console.log(str);
							$("tbody").append(str);
						});
						displayMarkers(data);
						}
						, "json"
					);
				}
				
				// 관심지역 등록
				$(document).on("click", ".cart", function(e) {
					var confirm = window.confirm("정말 삭제하시겠습니까?");
					if(confirm){
						//console.log('yes');
						// 클릭된 요소의id값 가져오기
						let id = e.currentTarget.getAttribute('id');
						var param = {
								aptCode:id,
								userNo:user
						};
						$.ajax({
						   url: root + "/map/deleteMark",
						   type: 'DELETE',
						   data : param,
						   success: function(response) {
							   console.log(response);
							   alert('관심지역을 삭제하였습니다.');
							   get();
						   },
							error:function(error){
								console.log('실패');
								alert('관심지역 삭제에 실패하였습니다.');
							}
						}); 
					}else{
						//console.log('no');
						return;
					}
				});
				
				
				
				
				</script>
				</div>
			</div>
		</section>

</body>
</html>