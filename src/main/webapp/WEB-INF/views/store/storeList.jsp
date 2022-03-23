<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qg5b1hs250"></script>
<meta charset="UTF-8">
<title>오프라인 매장</title>
<style>
	.map-section{
		width:800px;
		height:500px;
	}
	
	.container{
		margin-top: 70px;
		margin-bottom: 70px;
	}
	
	.clsfrm-btn.active{
	background-color: rgb(159, 144, 207) !important;
	border-color: rgb(159, 144, 207) !important;
	color: #fff !important;
	}
	
	.clsfrm-btn{
	color: rgb(159, 144, 207) !important;
	}
	

</style>
</head>
<body>
<script>
	$(function(){
		//좌표
		const seoulPos = new naver.maps.LatLng(37.5016547, 127.0261282);
		const kyeonggiPos = new naver.maps.LatLng(37.20065462924724, 127.09789671402015);
		const incheonPos = new naver.maps.LatLng(37.3818040889175, 126.65776461239007);
		const chungnamPos = new naver.maps.LatLng(36.3701615, 127.3373161);
		const kwangjuPos = new naver.maps.LatLng(35.16056863692235, 126.88265768652336);
		const busanPos = new naver.maps.LatLng(36.8194985142584, 127.1560887704907);
		
		//서울
		var seoulOptions = {
		    center: seoulPos,
		    zoom: 17
		};
		
		//경기
		var kyeonggiOptions = {
		    center: kyeonggiPos,
		    zoom: 17
		};
		
		//인천
		var incheonOptions = {
		    center: incheonPos,
		    zoom: 17
		};
		
		//충남
		var chungnamOptions = {
		    center: chungnamPos,
		    zoom: 17
		};
		
		//광주
		var kwangjuOptions = {
		    center: kwangjuPos,
		    zoom: 17
		};
		
		//부산
		var busanOptions = {
		    center: busanPos,
		    zoom: 17
		};
	
		var seoul = new naver.maps.Map('seoul', seoulOptions);
		var kyeonggi = new naver.maps.Map('kyeonggi', kyeonggiOptions);
		var incheon = new naver.maps.Map('incheon', incheonOptions);
		var chungnam = new naver.maps.Map('chungnam', chungnamOptions);
		var kwangju = new naver.maps.Map('kwangju', kwangjuOptions);
		var busan = new naver.maps.Map('busan', busanOptions);
		
		var seoulMarker = new naver.maps.Marker({
		    position: seoulPos,
		    map: seoul
		});
		var kyeonggiMarker = new naver.maps.Marker({
		    position: kyeonggiPos,
		    map: kyeonggi
		});
		var incheonMarker = new naver.maps.Marker({
		    position: incheonPos,
		    map: incheon
		});
		var chungnamMarker = new naver.maps.Marker({
		    position: chungnamPos,
		    map: chungnam
		});
		var kwangjuMarker = new naver.maps.Marker({
		    position: kwangjuPos,
		    map: kwangju
		});
		var busanMarker = new naver.maps.Marker({
		    position: busanPos,
		    map: busan
		});
		

		
	});
</script>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container">
		<div style="display:flex;justify-content: center;margin-bottom:70px;">
			<div style="position:relative;">
				<img src="./resources/img/store/storeheader.jpg" style="width:883px;">
				<div style="position:absolute;top:72px;left:57px;">
					<h3 style="color:white;text-shadow:1px 1px 1px #000;">이제 오프라인 에서</h3>
					<h3 style="color:white;text-shadow:1px 1px 1px #000;"><span style="color:#8E44AD;text-shadow:1px 1px 1px #fff;">요리조리</span>와 함께하세요!</h3>
				</div>
			</div>
		</div>
	<div class="d-flex align-items-start" style="justify-content: center;">
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<button class="nav-link clsfrm-btn active" id="seoul-tab" data-bs-toggle="pill" data-bs-target="#seoul" type="button" role="tab" aria-controls="seoul" aria-selected="true">서울</button>
    		<button class="nav-link clsfrm-btn" id="kyeonggi-tab" data-bs-toggle="pill" data-bs-target="#kyeonggi" type="button" role="tab" aria-controls="kyeonggi" aria-selected="false">경기</button>
    		<button class="nav-link clsfrm-btn" id="incheon-tab" data-bs-toggle="pill" data-bs-target="#incheon" type="button" role="tab" aria-controls="incheon" aria-selected="false">인천</button>
	   		<button class="nav-link clsfrm-btn" id="chungnam-tab" data-bs-toggle="pill" data-bs-target="#chungnam" type="button" role="tab" aria-controls="chungnam" aria-selected="false">충남</button>
	   		<button class="nav-link clsfrm-btn" id="kwangju-tab" data-bs-toggle="pill" data-bs-target="#kwangju" type="button" role="tab" aria-controls="kwangju" aria-selected="false">광주</button>
	   		<button class="nav-link clsfrm-btn" id="busan-tab" data-bs-toggle="pill" data-bs-target="#busan" type="button" role="tab" aria-controls="busan" aria-selected="false">부산</button>
  		</div>
  		<div class="tab-content" id="v-pills-tabContent">
    		<div class="tab-pane fade show active map-section" id="seoul" role="tabpanel" aria-labelledby="seoul">
    		</div>
    		<div class="tab-pane fade map-section" id="kyeonggi" role="tabpanel" aria-labelledby="kyeonggi">
    		</div>
	   		<div class="tab-pane fade map-section" id="incheon" role="tabpanel" aria-labelledby="incheon">
	   		</div>
    		<div class="tab-pane fade map-section" id="chungnam" role="tabpanel" aria-labelledby="chungnam">
    		</div>
       		<div class="tab-pane fade map-section" id="kwangju" role="tabpanel" aria-labelledby="kwangju">
    		</div>
       		<div class="tab-pane fade map-section" id="busan" role="tabpanel" aria-labelledby="busan">
    		</div>
  		</div>
	</div>	
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />	
</body>
</html>