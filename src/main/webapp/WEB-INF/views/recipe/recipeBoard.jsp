<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/recipe/recipeBoard.css"> 
   <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
     

</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="main">
    <h1>레시피</h1>
	<div id="recipeList">
		
		<input type="hidden" id="loginCheck" value="${sessionScope.m.memberNo }">
		
		<c:forEach items="${list }" var="rb" varStatus="i">	 	
	     <div class="recipe">
	     <c:if test="${sessionScope.m.memberNo != null }">
            <a href="/recipeView.do?recipeNo=${rb.recipeNo }&memberNo=${sessionScope.m.memberNo}">
         </c:if>
         <c:if test="${sessionScope.m.memberNo == null }">
         	 <a href="/recipeView.do?recipeNo=${rb.recipeNo }&memberNo=0">
         </c:if>
             <img src="/resources/upload/recipe/${rb.filepath }">
             
             <p class="name">${rb.nickname }</p>
            <p class="title">${rb.recipeTitle }</p>  
            
            <div class="info">
            <div>
            <p class="infoText">조회수</p>
            <p>${rb.readCount }회</p>  
            </div> 
            <div >
             <p class="infoText">조리시간</p>
            <p>${rb.recipeTime }</p>  
            </div>
            <div>
             <p class="infoText">난이도</p>
             <c:if test="${rb.recipeLevel eq 1}">
            <p>상</p>  
            </c:if>
             <c:if test="${rb.recipeLevel eq 2}">
              <p >중</p>  
              </c:if>
                <c:if test="${rb.recipeLevel eq 3}">
              <p>하</p>  
              </c:if>
            </div>
        </div>
      </a>
      </a>
    </div>
		</c:forEach>
		<div id="moreRecipe"></div>
		</div>
		<div class="btnWrap" ><button currentCount="6" totalCount="${totalCount }" value="7" id="more">레시피 더보기</button></div>
	</div>		
	<script>
	 $("#more").click(function(){
		 	var start = $(this).val();
		 	var situation = ${c.situationNum};
		 	var material = ${c.materialNum};
		 	var recipeLevel = ${c.levelNum};
		 	var loginCheck = $("#loginCheck").val();
		 	console.log(loginCheck);
			$.ajax({
				url : "/moreRecipe.do",
				data : {start:start,
					situation:situation,
					 material: material,
					 recipeLevel:recipeLevel
						},
				type : "post",
				success : function(data){			
					for(var i=0;i<data.length;i++){
						var html ="";
						if(loginCheck == ""){
							console.log(loginCheck);
							html += "<div class='recipe'><a href='/recipeView.do?recipeNo="+data[i].recipeNo+"&memberNo=0'>";
							html += "<img src='/resources/upload/recipe/"+data[i].filepath+"'>";
							html +=" <p class='name'>"+data[i].nickname+"</p> <p class='title'>"+data[i].recipeTitle+"</p>"; 
							html += "<div class='info'><div><p class='infoText'>조회수</p> <p>"+data[i].readCount+"회</p></div> ";
							html +="<div>  <p class='infoText'>조리시간</p> <p>"+data[i].recipeTime+"</p></div>";
							html +="<div> <p class='infoText'>난이도</p>";
							if(data[i].recipeLevel == 1){
								html +="<p>상</p>";
							}else if(data[i].recipeLevel == 2){
								html +="<p>중</p>";
							}else{
								html +="<p>하</p>";
							}
							html +="</div></div></a></div>";
							$("#moreRecipe").append(html);	
						}else{
							html += "<div class='recipe'><a href='/recipeView.do?recipeNo="+data[i].recipeNo+"&memberNo="+loginCheck+"'>";
							html += "<img src='/resources/upload/recipe/"+data[i].filepath+"'>";
							html +=" <p class='name'>"+data[i].nickname+"</p> <p class='title'>"+data[i].recipeTitle+"</p>"; 
							html += "<div class='info'><div><p class='infoText'>조회수</p> <p>"+data[i].readCount+"회</p></div> ";
							html +="<div>  <p class='infoText'>조리시간</p> <p>"+data[i].recipeTime+"</p></div>";
							html +="<div> <p class='infoText'>난이도</p>";
							if(data[i].recipeLevel == 1){
								html +="<p>상</p>";
							}else if(data[i].recipeLevel == 2){
								html +="<p>중</p>";
							}else{
								html +="<p>하</p>";
							}
							html +="</div></div></a></div>";
							$("#moreRecipe").append(html);	
						}
						
					}
					
					$("#more").val(Number(start)+3);
					var curr = Number($("#more").attr("currentCount"));
					$("#more").attr("currentCount", curr + data.length);
					var totalCount = $("#more").attr("totalCount");
					var currCount = $("#more").attr("currentCount");
					if(curr == totalCount){				
						$("#more").prop("disabled",false);
						alert("마지막 페이지 입니다.");
					}else if(totalCount < 7){
						$("#more").prop("disabled",false);
						alert("마지막 페이지 입니다.");
					}
				}
			});
		});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>