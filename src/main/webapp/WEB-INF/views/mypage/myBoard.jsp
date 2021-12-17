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
	height: 3px;
	width: 800px;
}

/* 메인 콘텐츠 설정 */
.main-content{
    width: 875px;
}
/*후기*/
.board{
    width:800px;
    height:100px;
   
}
.re{
    width:800px;
    height:60px; 
    
}
.butt{
    text-align: right;
    margin-top: 10px;
    
}
#del,#upd{
    background-color: rgb(196, 191, 227);
    border: none;
}
</style>
</head>
<body>
     <jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="main">
     	<c:choose>
		<c:when test="${sessionScope.m.memberLevel==1}">
      	   <jsp:include page="/WEB-INF/views/mypage/memberNavi.jsp" />	
        </c:when>

       	 <c:otherwise>
   	   <jsp:include page="/WEB-INF/views/mypage/sellerNavi.jsp" />	
        
       	</c:otherwise>
       </c:choose>  
		<!-- 메인 콘텐츠 -->
		<div class="main-content">
			<h3 id="h_hotel">내가 작성한 게시판</h3>
			<div id="line2"></div>
			<br>
				<h5>작성 게시글 수 : <span style="color: rgb(159, 144, 207);">${totalCount }</span>개</h5>
			<div class="board">


				<table border="1" class="re">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
             <c:forEach items="${list}" var="fb" varStatus="i">
					<tr>
						<td>${fb.freeNo}</td>
						<td><a href="/freeView.do?freeNo=${fb.freeNo}">${fb.freeTitle}</a></td>
						<td>${fb.freeContent}</td>
						<td>${fb.regDate}</td>
						<td>${fb.freeReadcount}</td>

					</tr>
					</c:forEach>

				</table>

			</div>
			    <div class="pagenation">
						${pageNavi }
					</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>