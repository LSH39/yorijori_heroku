<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/product/milkitFrm1.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="main">
	<h1>밀키트 판매 등록</h1>
	<h3>내가 작성한 레시피</h3>
	<hr>
	<form action="/milkitFrm2.do" method="post" onsubmit="return btn()">
	<c:forEach items="${list}" var="rb">
		<div class="recipe">
		<div class="recipeImg"> 
		<input type="radio" name="recipeNo" value="${rb.recipeNo }">
		<img src="/resources/upload/recipe/${rb.filepath }">
		</div>
		<div class="recipeText">
		<p class="title">${rb.recipeTitle }</p>
		<p class="name">${rb.foodName }</p>
		<p class="comment">${rb.subhead }</p>
		</div>
		</div>
	</c:forEach>	
	<div id="nextBtn"><input type="button" value="다음페이지"  onclick="submitBtn();" id="btn"></div>
	</form>
	</div>
<script>
	function submitBtn() {
		if($('input:radio[name=recipeNo]').is(':checked')){
			$("#btn").prop("type", "submit");
		}else{
			alert("레시피를 선택해주세요!");
		}
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>