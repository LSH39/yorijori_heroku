<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>

  <!-- mixed content 문제 해결을 위해 -->
  <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">

  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Green Bootstrap Template - Index</title>
  <meta content="" name="description">
  <meta content="" name="keywords">


<!-- header 및 기본 CSS-->
<link rel="stylesheet" href="resources/css/mainpage/header.css">
<!-- 부트스트랩용 jQuery
<script type="text/javascript" src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script> -->
<!-- 부트스트랩 icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<!-- Favicons -->
<link href="resources/img/mainpage/favicon.png" rel="icon">
<link href="resources/img/mainpage/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<!-- slick css -->
<link rel="stylesheet" type="text/css" href="resources/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="resources/slick/slick-theme.css"/>
<!-- Vendor CSS Files -->
<link href="resources/vendor/animate.css/animate.min.css" rel="stylesheet">
<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="resources/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="resources/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
<link href="resources/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="resources/css/mainpage/style.css" rel="stylesheet">

</head>



<div class="header-wrap">
<!-- ======= 최상단 부분 ======= -->
  <section id="topbar" class="d-flex align-items-center">
    <div class="container d-flex justify-content-center justify-content-md-between">
      <div class="contact-info d-flex align-items-center">
      </div>
      <div class="social-links d-none d-md-block">
      <c:choose>
		<c:when test="${empty sessionScope.m }">
		  
	        <a href="/joinCommon.do" class="join">회원가입</a>
	        <a href="/loginFrm.do" class="login">로그인</a>
        </c:when>

		<c:when test="${sessionScope.m.memberLevel ==  3 }">
	        <a href="/admin.do">관리자 페이지 </a>
	        <a class="qna chat" id="chatAdmin">1:1문의하기 
	        <c:if test="${sessionScope.m.memberId == 'adminchat01' }"><span class="chatAlarm">+<span id="chatAdminAlarm"></span></span></c:if>
	        </a>
	       	<a href="/logout.do" class="logout">로그아웃</a>
	       	<!-- LSH -->
			<%@include file = "/WEB-INF/views/chat/chatAdmin.jsp" %>
		</c:when>
		<c:when test="${sessionScope.m.memberLevel ==  1 }">
			<a href="/mypage.do?memberNickname=${sessionScope.m.memberNickname }" class="mypage">[${sessionScope.m.memberNickname }]님</a>
	        <a href="/membershipView.do?memberNo=${sessionScope.m.memberNo }" class="subscribe" style="color:#8E44AD;">월간구독</a>
	        <a class="qna chat" id="chatUser">1:1문의하기 <span class='chatAlarm'>+<span id='chatUserAlarm'></span></span></a>
	       	<a href="/logout.do" class="logout">로그아웃</a>
	       	<!-- LSH -->
			<%@include file = "/WEB-INF/views/chat/chatUser.jsp" %>
		</c:when>
       	<c:otherwise>
	       	<a href="/selPage.do?memberNickname=${sessionScope.m.memberNickname }" class="mypage">[${sessionScope.m.memberNickname }]님</a>
	        <a href="/membershipView.do?memberNo=${sessionScope.m.memberNo }" class="subscribe" style="color:#8E44AD;">월간구독</a>
	        <a class="qna chat" id="chatUser">1:1문의하기 <span class='chatAlarm'>+<span id='chatUserAlarm'></span></span></a>
	       	<a href="/logout.do" class="logout">로그아웃</a>
	       	<!-- LSH -->
	       	<%@include file = "/WEB-INF/views/chat/chatUser.jsp" %>
       	</c:otherwise>
       </c:choose>
      </div>
    </div>
  </section>
  <!-- ======= 헤더 ======= -->
  <header id="header" class="d-flex align-items-center">
    <div class="container d-flex align-items-center">

      
      <a href="/" class="logo me-auto"><img src="resources/img/mainpage/logo_header.png" alt="" class="img-fluid"></a>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto" href="/siteInfo.do">서비스소개</a></li>
          <li><a class="nav-link scrollto" href="#" id="show-category">레시피</a></li>
          <li class="dropdown"><a href="#"><span>밀키트</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="/milkitList.do?boardNo=1">신상품</a></li>
              <li><a href="/milkitList.do?boardNo=2">베스트 상품</a></li>
            </ul>
          </li>
          <li><a class="nav-link scrollto " href="/cookingClsList.do?reqPage=1">클래스</a></li>
           <li class="dropdown"><a href="#"><span>이벤트</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a class="nav-link" onclick="chkDate();">경연대회투표</a></li>
              <li><a class="nav-link" onclick="chkDate2();">우승자 발표</a></li>
              <li><a href="/contestWinner.do">역대 우승자</a></li>
            </ul>
          </li>
          <li class="dropdown" style="padding-right:15px;"><a href="#"><span>커뮤니티</span> <i class="bi bi-chevron-down"></i></a>
            <ul>

              <li><a href="/noticeList.do?reqPage=1">공지사항</a></li>
              <li><a href="/freeboardList.do?reqPage=1&orderIndex=0">자유게시판</a></li>
              <li><a href="/randomMenuFrm.do">메뉴추천</a></li>
            </ul>
          </li>
          <li>
          <form action="/mainpageSearch.do" method="get" id="headersearchBar">
          <input type="text" class="nav-link scrollto" id="header-mainsearch" name="keyword" placeholder="검색" autocomplete="off" style="color:#8E44AD;"></li>
          <input type="submit" id="headersearchsubmit" style="display: none;"></input>
          <label for="headersearchsubmit"><img class="main-search-icon" src="/resources/img/mainpage/search_icon.png" style="width: 25px; height: 25px; top: 13px; left: 74%; position: absolute;"></label>
          </form>
          <li><a class="nav-link scrollto" href="/cart.do"><img src="resources/img/mainpage/cart.png" class="img-fluid" style="width: 40px;"></a></li>
          <c:choose>
          <c:when test="${not empty sessionScope.m }">
          	<li><a class="getstarted scrollto" href="/recipeWrite.do">레시피 작성</a></li>
          </c:when>
          <c:otherwise>
          	<li><a class="getstarted scrollto" onclick="loginAlert();">레시피 작성</a></li>
          </c:otherwise>
          </c:choose>
          
   
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

	

    </div>
    
  </header><!-- End Header -->
  <form action="/recipeBoard.do" method="get">
		<div class="main-recipe-category">
			<div class="main-recipe-category-box">
				<div>
				<ul>
					<li class="main-recipe-category-1">
						<h3>
							<span>상황에 맞는 요리</span>
						</h3>
						<ul>
							<li>
								<label><input type="radio" name="situation" value="1"/> 술안주</label>
							</li>
							<li>
								<label><input type="radio" name="situation" value="2"/> 다이어트</label>
							</li>
							<li>
								<label><input type="radio" name="situation" value="3"/> 손님초대</label>
							</li>
							<li>
								<label><input type="radio" name="situation" value="4"/> 혼밥/자취</label>
							</li>
							<li>
								<label><input type="radio" name="situation" value="5"/> 간식</label>
							</li>
							<li>
								<label><input type="radio" name="situation" value="6"/> 유아식</label>
							</li>
							<li>
								<label><input type="radio" name="situation" value="7"/> 비건/채식</label>
							</li>
							<li>
								<label><input type="radio" name="situation" value="8"/> 기타</label>
							</li>	
						</ul>
					</li>
				</div>
				<div>
					<li class="main-recipe-category-2">
						<h3>
							<span>재료별 요리</span>
						</h3>
						<ul>
							<li>
								<label><input type="radio" name="material" value="1"/> 육류</label>
							</li>
							<li>
								<label><input type="radio" name="material" value="2"/> 채소류</label>
							</li>
							<li>
								<label><input type="radio" name="material" value="3"/> 해산물</label>
							</li>
							<li>
								<label><input type="radio" name="material" value="4"/> 달걀/유제품</label>
							</li>
							<li>
								<label><input type="radio" name="material" value="5"/> 면/만두</label>
							</li>
							<li>
								<label><input type="radio" name="material" value="6"/> 콩/두부</label>
							</li>
							<li>
								<label><input type="radio" name="material" value="7"/> 과일</label>
							</li>
							<li>
								<label><input type="radio" name="material" value="8"/> 기타</label>
							</li>
						</ul>
					</li>		
				</div>
				<div>
					<li class="main-recipe-category-3">
						<h3>
							<span>난이도별 요리</span>
						</h3>
						<ul>
							<li>
								<label><input type="radio" name="recipeLevel" value="1"/> 상</label>
							</li>
							<li>
								<label><input type="radio" name="recipeLevel" value="2"/> 중</label>
							</li>
							<li>
								<label><input type="radio" name="recipeLevel" value="3"/> 하</label>
							</li>
						</ul>
					</li>		
				</ul>
				</div>
			</div>
			<div class="main-main-recipe-category-btn-area">
				<button type="submit" class="recipe-btn-search">검색하기</button>
				<button type="button" class="main-recipe-category-close">닫기</button>
			</div>
		</div>
	</form>
  </div>
  
     <!-- 따라다니는 우측 퀵 메뉴 (로그인시에만) -->
  <c:choose>
  	<c:when test="${not empty sessionScope.m }">
  		<div class="quickmenu"> 
		  	<ul>
		  		<li><img src="/resources/img/mainpage/delivery.jpg" style="width:80px;height:110px;"> <a style="margin-bottom: 85px;">새벽배송</a></li>
		  		<li><a href="/recentProducts.do?memberId=${sessionScope.m.memberId }"><img src="/resources/img/mainpage/basket.png"> 최근 본 상품</a></li>
		  		<li><a href="/profile.do?memberId=${sessionScope.m.memberId }"><img src="/resources/img/mainpage/q_mark.png"> 내 프로필</a></li>
		  		<li><a href="/mydmList.do?dmReceiver=${sessionScope.m.memberNickname }"><img src="/resources/img/mainpage/message.png"> 내 메세지</a></li>
		  	</ul>
		 </div>
  	</c:when>
  </c:choose>
  
  
  <script>
  	function scrollrecipe(){
  		if($("html").scrollTop()==0){
  			 $('.main-recipe-category').css("top","120px");
  			$('.main-recipe-category').hide();
  		}else{
  			$('.main-recipe-category').css("top","80px");
  		}
  	}
  	$(document).scroll(function(){
  		scrollrecipe();
  	})
  	$(function(){
  		scrollrecipe();
  	})
  	  $('#show-category').on('click', function(){
  		  $('.main-recipe-category').toggle();
  	  });
  	$('.main-recipe-category-close').on('click', function(){
  		$('.main-recipe-category').hide();
  	})
	  $('.main-recipe-category').on('click', 'input:radio', function () {
	    $(this).parent('label').parent('li').toggleClass('checked', this.checked);
	  });
  	
	
  	//로그인 alert
  	function loginAlert(){
  		alert("로그인 해주세요.");
  		location.href="/loginFrm.do";
  	}
  	
  	//현재 일자 체크 (대회 투표기간 확인)
  	function chkDate(){
  		var today = new Date();
  		var date = today.getDate();
  		if(date >= 1 && date <= 31){
  			location.href="/contestList.do?reqPage=1&orderIndex=0";
  		}else {
  			alert("대회 투표기간이 아닙니다.");
  		}
  		
  	}
	
	//현재 일자 체크 (우승자발표 날짜 및 시간 확인 25일 12시 30분 오픈)
  	function chkDate2(){
  		var today = new Date();
  		var date = today.getDate();
  		var hours = today.getHours(); //시간
  		var minutes = today.getMinutes();
  		if((date >= 25 && hours >= 12 && minutes >=30) || date>= 26 && date <= 31){
  			location.href="/contestResult.do";
  		}else {
  			alert("우승자 발표기간이 아닙니다.");
  		}
  		
  	}
	
	//검색어 글자 길이 제한 (2글자 이상)
	$(".main-search-icon").on("click", function(){
		var keyword = $("#header-mainsearch").val();
		if(keyword.length < 2){
			alert("두 글자 이상 입력해주세요.");
			return false;
		}
	})
	
	/* sql에서 date타입 에러로 주석처리
  	//방문자수 기록용 쿠키 스크립트
  	function setCookie(cname,cvalue,exdays){
  	    var d = new Date();
  	    d.setTime(d.getTime()+(exdays*24*60*1000));
  	    var expires = "expires=" +d.toUTCString();
  	    document.cookie = cname+"="+cvalue+";"+expires +"; path=/";
  	}
  	function getCookie(cname){
  	    var name = cname+"=";
  	    var decodedCookie = decodeURIComponent(document.cookie);
  	    var ca = decodedCookie.split(';');
  	    for(var i =0; i<ca.length;i++){
  	        var c = ca[i];
  	        while(c.charAt(0)==' '){
  	            c = c.substring(1);
  	        }
  	        if(c.indexOf(name)==0){
  	            return c.substring(name.length,c.length);
  	        }
  	    }
  	    return "";
  	}

	
  	if(getCookie("visit")==0){
  	    
  		setCookie("visit","1","1");

  	  $.ajax({
			url:"visitCount.do",
			type:"post",
			data : {},
			success: function(data){
				
				
			},
			error:function(){
				console.log("err");
			}
			
			
		});
  	    
  	}else{
  		if(getCookie("login")==0 && ${ not empty sessionScope.m }){
  	        
  	    	setCookie("login","1","1");
  	      $.ajax({
  			url:"loginCount.do",
  			type:"post",
  			data : {},
  			success: function(data){
  				
  				
  			},
  			error:function(){
  				console.log("err");
  			}
  			
  			
  		});
  	}
  	}
  	//쿠키 스크립트 끝
  	*/
</script>
