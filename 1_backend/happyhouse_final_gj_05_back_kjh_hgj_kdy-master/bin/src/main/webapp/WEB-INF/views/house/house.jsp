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
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark rounded">
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
				
				
					<div id="condition">
					
					<!-- search -->
					<label for="sido">시도 :</label>
					<select id="sido" class="form-select">
						<option value="0">선택</option>
					</select>
					<label for="gugun">구군 :</label>
					<select id="gugun" class="form-select">
						<option value="0">선택</option>
					</select>
					<label for="dong">읍면동 :</label>
					<select id="dong" class="form-select">
						<option value="0">선택</option>
					</select>
					
					
					<label for="year">건축년도:</label>
					<select id="year" class="form-select">
						<option value="0">선택</option>
					</select>
					
				
					<button type="button" id="aptSearchBtn" class="btn btn-secondary">검색</button>
					
					<!-- <button type="button" id="aptYearSearchBtn" class="btn btn-secondary">검색</button> -->
					 

					<label for=name>아파트명:</label>
					<form id="name">
						<input type="text" id="aptName" name="aptName" placeholder="예)  반포 자이"/>
					<button type="button" id="aptNameSearchBtn" class="btn btn-secondary">검색</button>
					</form>
					<button type="button" id="chargeBtn" class="btn btn-secondary"><i class="fas fa-charging-station"></i></button>
					</div>

					<!-- table -->
					<table class="table mt-2">
						<colgroup>
							<col width="200">
							<col width="250">
							<col width="*">
							<col width="200">
							<col width="200">
							<c:if test="${!empty userinfo}">
								<col width="100">
							</c:if>
						</colgroup>	
						<thead class="tab">
							<tr>
								<th>번호</th>
								<th>아파트이름</th>
								<th class="text-center">주소</th>
								<th>건축연도</th>
								<th>최근거래금액</th>
								<c:if test="${!empty userinfo}">
									<th>관심지역</th>
								</c:if>
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
				
				
				
				let colorArr = ['table-primary','table-success','table-danger'];
				$(document).ready(function(){	
					setDateBox();
					$.get(root + "/map/sido"
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
							});
						}
						, "json"
					);
				});
				
				
			 function setDateBox(){
			        var dt = new Date();
			        var year = "";
			        var com_year = dt.getFullYear();
			        // 발행 뿌려주기
			        $("#year").append("<option value=''>년도</option>");
			        // 올해 기준으로 -1년부터 +5년을 보여준다.
			        for(var y = 1961; y <= (com_year-1); y++){
			            $("#year").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
			        }
			    }


				$(document).on("click", "#chargeBtn", function() {
					$.get(root + "/map/charge"
							,function(data, status){
								displayChargeMarkers(data);
							}
							, "json"
					);
				});
				
				
				$(document).on("change", "#sido", function() {
					$.get(root + "/map/gugun"
							,{sido: $("#sido").val()}
							,function(data, status){
								$("#gugun").empty();
								$("#gugun").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
								});
							}
							, "json"
					);
				});
				$(document).on("change", "#gugun", function() {
					$.get(root + "/map/dong"
							,{gugun: $("#gugun").val()}
							,function(data, status){
								$("#dong").empty();
								$("#dong").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
								});
							}
							, "json"
					);
				});
				

				
				
				$(document).on("change", "#dong", function() {
					$.get(root + "/map/apt"
							,{dong: $("#dong").val()}
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
										str +=`<td class="cart" id=`+vo.aptCode+`><i class="far fa-heart"></i></td></tr>`;
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
				});
				
				
				
	

				$(document).on("change", "#year", function() {
					if($("#dong").val()=="0"){
						return;
					}
					var param = {
							dong: $("#dong").val(),
							year: $("#year").val()
					};
					$.get(root + "/map/year"
							,param
							,function(data, status){
								console.log(data);
								if(data.length==0){
									return;
								}
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
										str +=`<td class="cart" id=`+vo.aptCode+`><i class="far fa-heart"></i></td></tr>`;
									}else if(!user){
										str +=`</tr>`;
									}
									//console.log(str);
									$("tbody").append(str);
								});
								
								displayMarkers(data);
							}
							, "json"
					);
				});
		

				$(document).on("click", "#aptNameSearchBtn", function() {
					if(!$("#aptName").val()){
						alert('검색어를 입력해주세요.');
						return;
					}					
					$.get(root + "/map/name"
							,{word : $("#aptName").val()}
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
										str +=`<td class="cart" id=`+vo.aptCode+`><i class="far fa-heart"></i></td></tr>`;
									}else if(!user){
										str +=`</tr>`;
									}
									//console.log(str);
									$("tbody").append(str);
								});
								displayMarkers(data);
							}
							, "json"
					);
				});
		
				
				// 관심지역 등록
				$(document).on("click", ".cart", function(e) {

					// 클릭된 요소의id값 가져오기
					let id = e.currentTarget.getAttribute('id');
					var param = {
							aptCode:id,
							userNo:user
					};
					$.ajax({
					   url: root + "/map/cart",
					   type: 'PUT',
					   data : param,
					   success: function(response) {
						   console.log(response);
						   alert('관심지역으로 등록되었습니다.');
					   },
						error:function(error){
							console.log('실패');
							alert('관심지역으로 등록되어있는 지역입니다.');
						}
					});
				});
				
			
				 
				 $(document).on("click", "#aptSearchBtn", function() {
						var param = {
								serviceKey:'5FnhblQWI5avAYT+/GNqtd2qm5D+mA2v9Z/nsOcn3G6p6RKQCTUuCiZbpKje1/0K73ZPlKXL/bHouJI6xYGnrQ==',
								pageNo:encodeURIComponent('1'),
								numOfRows:encodeURIComponent('100'),
								LAWD_CD:encodeURIComponent($("#gugun").val()),
								DEAL_YMD:encodeURIComponent('202110')
						};
						$.get('http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'
								,param
								,function(data, status){
									console.log(data);
									var items = $(data).find('item');
									var jsonArray = new Array();
									items.each(function() {
										var jsonObj	= new Object();
										jsonObj.aptCode = $(this).find('일련번호').text();
										jsonObj.aptName = $(this).find('아파트').text();
										jsonObj.dongCode = $(this).find('법정동읍면동코드').text();
										jsonObj.buildYear = $(this).find('건축년도').text();
										jsonObj.jibun = $(this).find('지번').text();
										jsonObj.recentPirce = $(this).find('거래금액').text();

										jsonObj = JSON.stringify(jsonObj);
										//String 형태로 파싱한 객체를 다시 json으로 변환
										jsonArray.push(JSON.parse(jsonObj));
										
									});
									console.log(jsonArray);
									//displayMarkers(jsonArray);
									
								}
								, "xml"
						);
						
						
						
						
					/* var xhr = new XMLHttpRequest();
					var url = 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev';
					var queryParams = '?' + encodeURIComponent('serviceKey') + '='+encodeURIComponent(' API KEY ');
					queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); 
					queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); 
					queryParams += '&' + encodeURIComponent('LAWD_CD') + '=' + encodeURIComponent($("#gugun").val()); 
					queryParams += '&' + encodeURIComponent('DEAL_YMD') + '=' + encodeURIComponent('202110'); 
					xhr.open('GET', url + queryParams);
					xhr.onreadystatechange = function () {
					    if (this.readyState == 4) {
					    	console.log(this.responseXML);
					        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
					    }
					};

					xhr.send(''); */ 
				});
				</script>
				</div>
			</div>
		</section>

</body>
</html>