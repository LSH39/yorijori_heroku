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

/* 메인 콘텐츠 설정 */
.main-content{
    width: 875px;
}
/*내 팔로우*/

.followR{
    width:250px;
    height: 350px;
    
    float: left;
    margin-right: 30px;
    margin-bottom:40px;
}
.pt{
    width:250px;
    height: 60px;
    background-color:rgb(224, 224, 224);
}
.pr{
    width:250px;
    height: 160px;
     background-color:rgb(224, 219, 239) ;
  
}
.pw{
    width:250px;
    height: 140px;
    background-color:rgb(224, 219, 239) ;
}
#pp{
    width: 60px;
    height:60px;
    border-radius: 50px;
    margin-left: 30px;
    float: left;
   
}
#nickName{
    float: left;
    margin-left: 15px;
}
#itemI{
    width: 250px;
    height:150px;
}
.noCou{
color:gray;
margin-left:300px;
margin-top:120px;

}
.dd{
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
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
            <h3 id="h_hotel">★my Follow★</h3>
            <div id="line2"></div><br>
            <h5>팔로우 게시글 수: <span style="color: rgb(159, 144, 207);">${totalCount }</span>개</h5>
               <c:choose>
                  	<c:when test="${ not empty list }">
              <c:forEach items="${list}" var="fol" varStatus="i">
            <div class="followR">
        
                <div class="pt">
                 <a href="/profile.do?memberId=${fol.memberId}">
                <img id="pp" src="resources/upload/member_profile/${fol.profilePath }"></a>
                
                    <h5 id="nickName">${fol.memberNickname }</h5>
                    
                </div>
                
                <div class="pr">
                    <a href="/recipeView.do?recipeNo=${fol.recipeNo}&memberNo=${fol.recipeWriter}"> 
                         <img id="itemI" src="resources/upload/recipe/${fol.filepath }">
                    </a>
                </div>
                <div class="pw">
                   <h5 style="color: rgb(126, 30, 166);"> 좋아요 ${fol.cnt }개</h5>
                    <h5 class="dd">#${fol.recipeTitle}</h5>
                    <h5 class="dd">#${fol.subhead}</h5>
                </div>

            </div>
            </c:forEach>
               </c:when>
                
                  	<c:otherwise><h6 class="noCou">팔로워 게시글이 존재하지 않습니다.</h6>
                  	</c:otherwise>
                  	</c:choose>
        </div>
  
        </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>