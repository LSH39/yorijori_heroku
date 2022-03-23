<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/product/milkitList.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="main">
<h1>밀키트</h1>
<input type="hidden" id="loginCheck" value="${sessionScope.m.memberNo }">
<input type="hidden" id="levelCheck" value="${sessionScope.m.memberLevel }" >

	<p id="total">총  <fmt:formatNumber value="${totalCount}"/>개</p>
		<div id="make"><button >밀키트 만들기</button></div>
	<div class="milkitList">
	<c:forEach items="${list }" var="p">
	<div class="milkit">
	<a href="/milkitView.do?productNo=${p.productNo }&recipeNo=${p.recipeNo}">
		<img src="/resources/upload/product/${p.filepath }">
		<p class="name">${p.milkitName}</p>
		<p class="price"><fmt:formatNumber value="${p.milkitPrice}"/>원</p>
		<p class="comment">${p.milkitComment }</p></a>
	</div>
	</c:forEach>
	<div id="moreProduct"></div>
	</div>
	 <div class="btnWrap" ><button currentCount="6" totalCount="${totalCount }" value="7" id="more">판매중인 밀키트 더보기</button></div>
	</div>
	 <script>
	 $("#more").click(function(){
		 	var boardNo = ${boardNo};
		 	console.log(boardNo);
		 	var start = $(this).val();
			$.ajax({
				url : "/moreProduct.do",
				data : {start:start,
						boardNo:boardNo},
				type : "post",
				success : function(data){			
					for(var i=0;i<data.length;i++){
						var price = data[i].milkitPrice.toLocaleString('ko-KR')
						var html ="";
						html += "<div class='milkit'><a href='/milkitView.do?productNo="+data[i].productNo+"&recipeNo="+data[i].recipeNo+"'>";	
						html += "<img src='/resources/upload/product/"+data[i].filepath+"'>";
						html += "<p class='name'>"+data[i].milkitName+"</p>";
						html += "<p class='price'><span >"+price+"</span><span>원</span></p>";
						html += "<p class='comment'>"+data[i].milkitComment+"</p></div>";
						$("#moreProduct").append(html);	
					}

					$("#more").val(Number(start)+3);
					var curr = Number($("#more").attr("currentCount"));
					$("#more").attr("currentCount", curr + data.length);
					var totalCount = $("#more").attr("totalCount");
					var currCount = $("#more").attr("currentCount");
					if(curr == totalCount){				
						$("#more").prop("disabled",false);
						alert("마지막 페이지 입니다.");
					}else if(totalCount<7){
						alert("마지막 페이지 입니다.");
					}
				}
			});
		});
	 $("#make").click(function() {
			var login = $("#loginCheck").val();
			var level = $("#levelCheck").val();
			if(login == ""){
				alert("로그인 후 이용해주세요");
				$(location).attr("href","/loginFrm.do");	
			}else if(!(level==2 || level == 3 )){
				alert("밀키트 작성이 불가능한 등급입니다.");
			}else{
				$(location).attr("href","/milkitFrm1.do?memberNo="+login);
			}	
			
		});
	 </script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>