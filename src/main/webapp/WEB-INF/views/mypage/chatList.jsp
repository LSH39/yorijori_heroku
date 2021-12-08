<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

#line2 {
	background-color: gray;
	height: 1px;
	width: 800px;
}

.h_left{
	width: 350px;
	height: 300px;

	float:left;
	margin-left:30px;
	margin-top:20px;
}
.h_right{
	width: 350px;
	height: 300px;

	float:left;
	margin-left:30px;
	margin-top:20px;
}
/* 메인 영역 */
.main{
    width: 1200px;
    margin: 0 auto;
    margin-top: 50px;
    overflow: hidden;
}
.main>div{
    float: left;
}
/* 메인 내부 서브 네비 */
.main-left-box{
    width: 230px;
    padding: 23px;
    box-sizing: border-box;
    background-color: #f6eabf;
    margin-right: 60px;
}
.main-left-box>h3{
    margin: 0;
    height: 50px;
    cursor: default;
    border-bottom: 3px solid #565c54;
    margin-bottom: 25px;
}
.main-left-box ul{
    list-style-type: none;
    padding: 0;
}
.main-left-box ul>*{
    text-indent: 5px;
}
.main-left-box>ul>li>span{
    font-family: 'ns_b';
    font-size: 18px;
    cursor: default;
    display: block;
    border-bottom: 1px dotted #b9a989;
    padding-bottom: 8px;
    margin-bottom: 8px;
}
.subnavi{
    margin-bottom: 25px;
}
.subnavi a{
    display: block;
    text-decoration: none;
    font-size: 15px;
    line-height: 23px;
    margin-bottom: 2px;
    position: relative;
}
.subnavi a>span{
    position: absolute;
    right: 10px;
    font-size: 10px;
    font-family: 'ns_b';
    display: none;
}
#line2 {
	background-color: gray;
	height: 3px;
	width: 830px;
}

/* 메인 콘텐츠 설정 */
.main-content{
    width: 875px;
}


/*dm*/
.dm{
    width:700px;
    height:100px;
    background-color: rgb(224, 224, 224);
    margin-left: 50px;
}
.pho{
    width:120px;
    height:100px;
    
    float: left;
}
.dmC{
    width:550px;
    height:100px;
    float: left;
   

}
#pic{
    width: 70px;
    height:70px;
    border-radius: 50px;
    margin-left: 30px;
    float: left;
    margin-top: 10px;
   
}
.dContent{
    width:550px;
}
#time{
    text-align: right;
}
#name{
    font-weight: 600;
}
</style>
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="main">
		<div class="main-left-box">
			<h3>마이페이지</h3>
			<ul>
				<li><span>MY INFO</span>
					<ul class="subnavi">
						<li><a href="/introHotel">내정보 조회 및 수정<span>&gt;</span></a></li>
						<li><a href="/membership" id="lf-click">멤버십 정보<span>&gt;</span></a></li>
						<li><a href="/location">쿠폰함<span>&gt;</span></a></li>
						<li><a href="/location">회원탈퇴<span>&gt;</span></a></li>
						<li><a href="/location">오시는 길<span>&gt;</span></a></li>
						<li><a href="/location">오시는 길<span>&gt;</span></a></li>
						<li><a href="/location">오시는 길<span>&gt;</span></a></li>
					</ul></li>
				<li><span>MY WRITE</span>
					<ul class="subnavi">
						<li><a href="/introHotel">내정보 조회 및 수정<span>&gt;</span></a></li>
						<li><a href="/membership" id="lf-click">멤버십 정보<span>&gt;</span></a></li>
						<li><a href="/location">쿠폰함<span>&gt;</span></a></li>
						<li><a href="/location">회원탈퇴<span>&gt;</span></a></li>
						<li><a href="/location">오시는 길<span>&gt;</span></a></li>
						<li><a href="/location">오시는 길<span>&gt;</span></a></li>
						<li><a href="/location">오시는 길<span>&gt;</span></a></li>
					</ul></li>
			</ul>
		</div>
		<!-- 메인 콘텐츠 -->
		<div class="main-content">
			<h3 id="h_hotel">●MY DM ●</h3>
			<div id="line2"></div>
			<br>
			   <c:forEach items="${list}" var="mc" varStatus="i">
			<div class="dm">

				<div class="pho">
					<img id="pic" src="resources/img/mypage/profile.jpeg">
				</div>
				<div class="dmC">
					<table class="dContent">
						<tr>
							<td id="name">${mc.chatSend}</td>
						</tr>
						<tr>
							<td>${mc.chatContent }</td>
						</tr>
						<tr>
							<td id="time">${mc.chatDate }</td>
						</tr>
					</table>
				</div>

			</div>
			</c:forEach>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>