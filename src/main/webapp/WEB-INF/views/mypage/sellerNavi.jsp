<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
    background-color: rgb(224, 219, 239);
    margin-right: 60px;
}
.main-left-box>h2{
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
    display: none;
}
.subnavi>li>a:hover{
		 background-color:rgb(177, 109, 204);
		 }
</style>
</head>
<body>
<div class="main-left-box">
			<h2>마이페이지</h2>
			<ul>
				<li>
					<ul class="subnavi">
						<li><a href="/selPage.do?memberId=${sessionScope.m.memberId }">내정보 조회 및 수정<span>&gt;</span></a></li>
						<li><a href="/myOrderList.do?memberNo=${sessionScope.m.memberNo }&reqPage=1" id="lf-click">내 구매내역<span>&gt;</span></a></li>
						<li><a href="/mycouponList.do?memberNo=${sessionScope.m.memberNo }&reqPage=1">쿠폰함<span>&gt;</span></a></li>
						<li><a href="/delSelFrm.do?">회원탈퇴<span>&gt;</span></a></li>
						<li><a href="/mydmList.do?dmReceiver=승민전문가">내 쪽지함<span>&gt;</span></a></li>
						<li><a href="/myChatList.do?chatRecive=${sessionScope.m.memberNo }">내 채팅내역<span>&gt;</span></a></li>
						<li><a href="/followList.do?memberNo=${sessionScope.m.memberNo }">follwer 게시글<span>&gt;</span></a></li>
						<li><a href="/myLikeList.do?memberNo=${sessionScope.m.memberNo }&reqPage=1">찜한 레시피<span>&gt;</span></a></li>			
						<li><a href="/myRecipe.do?recipeWriter=${sessionScope.m.memberNo }">내 작성 레시피<span>&gt;</span></a></li>
						<li><a href="/myitemReview.do?memberNo=${sessionScope.m.memberNickname }">구매밀키트 후기<span>&gt;</span></a></li>
					    <li><a href="/myBoardList.do?freeWriter=${sessionScope.m.memberId }&reqPage=1" id="lf-click">내 작성 게시글<span>&gt;</span></a></li>
						              
					</ul>
				</li>
				<li><span>클래스/판매</span>
					<ul class="subnavi">
						<li><a href="#">내 요리클래스<span>&gt;</span></a></li>
					    <li><a href="/myItem.do?milkitWriter=111">내 판매밀키트<span></span></a></li>
						<li><a href="/sellList.do?memberNo=5" id="lf-click">내 판매내역<span>&gt;</span></a></li>
					    <li><a href="/totalSell.do?memberNo=111" id="lf-click">내 판매량통계<span></span></a></li> 
					 

					</ul></li>
			</ul>
		</div>
</body>
</html>