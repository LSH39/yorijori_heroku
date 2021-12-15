<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<p>총 <fmt:formatNumber value="${totalCount}"/>개</p>
	<c:if test="${sessionScope.m.memberNo != null}">	
		<div><a href="/milkitFrm1.do?memberNo=${sessionScope.m.memberNo }">밀키트 만들기</a></div>
	</c:if>
	<c:forEach items="${list }" var="p">
	<div>	
		<p><img src="/resources/upload/product/${p.filepath }"></p>
		<p>${p.milkitName}</p>
		<p><fmt:formatNumber value="${p.milkitPrice}"/>원</p>
		<p>${p.milkitComment }</p>
	</div>
	</c:forEach>
	 <div class="btnWrap" ><button class="moreBtn"  currentCount="6" totalCount="${totalCount }" value="7" id="more">리워드 프로젝트 더보기</button></div>
	 <script>
	 $("#more").click(function(){
		 	var boardNo = ${boardNo};
			var start = $(this).val();
			var seleted = $("#selected").val();
			$.ajax({
				url : "/moreProduct.do",
				data : {start:start,
					boardNo:boardNo},
				type : "post",
				success : function(data){
					for(var i=0;i<data.length;i++){
						
					}
					$("#more").val(Number(start)+3);
					var curr = Number($("#more").attr("currentCount"));
					$("#more").attr("currentCount", curr + data.length);
					var totalCount = $("#more").attr("totalCount");
					var currCount = $("#more").attr("currentCount");
					if(currCount == totalCount){
						$("#more").css("display", "none");
						$("#more").prop("disabled",false);
					}
				}
			});
		});
	 </script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>