<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/membership/membershipView.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="main">
        <div class="titleImg">
        <img src="/resources/img/membership/오븐1.png">
        <div class="titleText">
            <p id="first">#요리조리 멤버십</p>
            <p class="second">매달 가장 인기있는 밀키트로</p>
            <p class="second">배송해드려요</p>
            <p id="third">#뭐먹지? 고민 끝!</p>
    </div>
    </div>
    <div class="membership">
    <div >
    <form action="/standardFrm.do" method="post" id="standard">
        <img src="/resources/img/membership/오븐2.jpg">
        <p class="name">STANDARD</p>
        <select name="membershipPrice">
            <option value="12000">1개월 12,000원</option>
            <option value="33000">3개월 33,000원</option>
            <option value="60000">6개월 60,000원</option>
        </select>
        <p class="comment">매 달 2만원 상당의 인기 밀키트를 <br>
            배송해드립니다.</p>
        <input type="hidden" name="membershipLevel" value="STANDARD">
        <button type="submit" >구독하기</button>
        </form>
    </div>
    <div >
    <form action="/premiumFrm.do" method="post" id="premium">
        <img src="/resources/img/membership/premium.jpg">
        <p class="name">PREMIUM</p>
        <select name="membershipPrice">
            <option value="20000">1개월 20,000원</option>
            <option value="55000">3개월 55,000원</option>
            <option value="100000">6개월 100,000원</option>
        </select>
        <p class="comment">매 달 3만원 상당의 인기 밀키트를 <br>
            배송해드립니다.</p>
         <input type="hidden" name="membershipLevel" value="PREMIUM">
         <button type="submit" >구독하기</button>
         </form>
    </div>
</div>
    </div>
   
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>