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
	width: 875px;
}

/* 메인 콘텐츠 설정 */
.main-content{
    width: 875px;
}
.classForm{
  width:875px;
  boder:3px solid black;
  font-size:12px;
 

  }
  .main{
  margin-bottom:40px;
  }

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="main">
       <jsp:include page="/WEB-INF/views/mypage/memberNavi.jsp" />   
        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <h3 id="h_hotel">클래스 예약내역</h3>
            <div id="line2"></div><br>
            <table border="1" class="classForm">
                <tr>
                    <th>예약번호</th>
                    <th>요리클래스</th>
                    <th>클래스시작일</th>
                    <th>클래스종료일</th>
                    <th>수강료</th>
                    <th>수업시간</th>
                    <th>수업장소</th>
                    <th>상태</th>
                    <th>예약수정</th>
                    <th>예약취소</th>
                </tr>
                    <c:forEach items="${list}" var="mcr" varStatus="i">
                <tr>
                    <td>${mcr.rsrvNo }</td>
                    <td>${mcr.classTitle }</td>                    
                    <td>${mcr.classStart }</td>
                    <td>${mcr.classEnd }</td>
                    <td>${mcr.classPrice }</td>
                    <td>${mcr.classTime }</td>
                    <td>${mcr.classLocation}</td>
                    <td>${mcr.classStatus }</td>
                    <td><button value="수정" id="modify"><a href="#">수정</a></button></td>
                    <td><button value="취소" id="delete"><a href="#">삭제</a></button></td>
                </tr>
            
                </c:forEach>
            </table>

        </div>
        
        </div>
      <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>