<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/product/milkitView.css">
<script type="text/javascript"	src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="main">
	
		<div id="modal-wrap" style="display:none;">	
					<p>장바구니에 담겼습니다.</p>
				<div id="modal-btn">
					<button id="reportBtn"><a href="/cart.do">장바구니 가기</a></button>
					<button id="cancelBtn">계속 쇼핑하기</button>
				</div>	
	
		</div>
		<c:if test="${p.memberLevel eq 3 }">
		<p id="win">경연대회 우승작</p>
		</c:if>
	<input type="hidden" id="loginCheck" value="${sessionScope.m.memberNo }">
		<div id="title">
			<div id="titleImg">
				<img src="/resources/upload/product/${p.filepath }">
				<c:choose>
					<c:when test="${not empty sessionScope.m }">
						<input type="hidden" name="memberId" class="memberId" value="${sessionScope.m.memberId }">
					</c:when>
				</c:choose>
				<input type="hidden" name="productNo" class="productNo" value="${p.productNo }">
				<c:if test="${sessionScope.m.memberNo == p.milkitWriter }">
				 <p id="update"><a href="/updateMilkit.do?productNo=${p.productNo }">수정</a> <a href="/deleteMilkit.do?productNo=${p.productNo} "> 삭제</a></p>
				 </c:if>
			</div>
			<div id="titleText">
				<p id="pName">${p.milkitName }</p>
				<p id="pComment">${p.milkitComment }</p>
				<p id="price">
					<fmt:formatNumber value="${p.milkitPrice}" />
					원
				</p>
				<input type="hidden" id="milkitPrice" value="${p.milkitPrice }">
				<hr>
				<p>
					<span class="boldTxt">판매자</span> <span class="thinTxt"><a href="/profile.do?memberId=${p.memberId }" >${p.nickname }</a></span>
				</p>
				<p id="order">
					<span class="boldTxt">구매수량</span> <span id="count">
						<button>-</button> <span id="amount">1</span>
						<button>+</button>
					</span>
				</p>
				<hr>
				<p id="amountPrice">
					<span class="boldTxt">총 상품금액:</span> <span id="totalPrice"><fmt:formatNumber
							value="${p.milkitPrice}" />원</span>
				</p>
				<c:if test="${p.milkitStock != 0 }">
					<button id="cart">장바구니 담기</button>
				</c:if>
				<c:if test="${p.milkitStock eq 0 }">
					<button id="soldOut">
						<a href="#">일시품절된 상품입니다</a>
					</button>
				</c:if>
			</div>
		</div>
		<div class="viewNavi">
			<ul>
				<li class="view">상품설명</li>
				<li class="view">리뷰</li>
				<li class="view">관련레시피</li>
			</ul>
		</div>
		<div class="pContent">
			<div id="detail">${p.milkitContent}</div>
		</div>
		<div class="review" style="display: none;">
							<!-- 
			<c:forEach items="${p.RList }" var="rv">
				<div class="rvContent">
					<div class="star">
						<c:choose>
							<c:when test="${rv.reviewRate eq 1 }">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
							</c:when>
							<c:when test="${rv.reviewRate eq 2 }">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
							</c:when>
							<c:when test="${rv.reviewRate eq 3}">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
							</c:when>
							<c:when test="${rv.reviewRate eq 4}">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-off.png">
							</c:when>
							<c:otherwise>
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
							</c:otherwise>
						</c:choose>
						<span class="reviewDate"> ${rv.reviewDate }</span>
		</div>
					<p class="content">
						<span class="text">${rv.reviewContent }</span> <span class="user"><img
							src="/resources/img/recipe/person.png" width="60px">${rv.memberNickname }</span>
					</p>
					<hr>
				</div>
			</c:forEach>		
							 -->
							 
	<c:choose>
		<c:when test="${not empty list }">					 
			<table class="table reviewTable">
				<tr>
					<th style="width: 7%;">번호</th>
					<th style="width: 55%;">내용</th>
					<th style="width: 18%;">닉네임</th>
					<th style="width: 15%;">평점</th>
					<th style="width: 5%;"></th>
				</tr>
				<c:forEach items="${list }" var="review" varStatus="i">
				<tr>
					<td>${i.count }</td>
					<td>
						<div class="review-content">
							<span>${review.reviewContent }</span>
						</div>
					</td>
					<td>${review.memberNickname }</td>
					<td>
						<div class="star">
						<c:choose>
							<c:when test="${review.reviewRate eq 5}">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">	
							</c:when>
							<c:when test="${review.reviewRate eq 4}">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-off.png">	
							</c:when>
							<c:when test="${review.reviewRate eq 3}">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">	
							</c:when>
							<c:when test="${review.reviewRate eq 2}">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">	
							</c:when>
							<c:when test="${review.reviewRate eq 1}">
								<img src="/resources/img/product/star-on.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">
								<img src="/resources/img/product/star-off.png">	
							</c:when>
						</c:choose>
						</div>
					</td>
					<td>
						<c:if test="${sessionScope.m.memberNickname eq review.memberNickname }">											
							<a class="btn-close reviewDelete" style="text-indent:-9999px; display:inline-flex; width:1em; height:24px; padding:0px;">X<input type="hidden" class="deleteLinkVal" value="${review.reviewNo }"></a>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
			</c:when>
			<c:otherwise>
				<table class="table reviewTable">
					<tr>
						<th style="text-align:center;">등록된 리뷰가 없어요!</th>
					</tr>
				</table>
			</c:otherwise>
		</c:choose>
			<table class="table table-borderless">
				<tr>
					<td colspan="2" class="col-8">
						<input type="hidden" name="productNo" value="${p.productNo }" id="productNo">
						<input type="hidden" name="memberNickname" value="${sessionScope.m.memberNickname }" id="memberNickname">
						<input type="hidden" name="memberLevel" value="${sessionScope.m.memberLevel }" id="memberLevel">
						<input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }" id="memberNo">
						
						<c:choose>
							<c:when test="${ empty sessionScope.m }">
								<input type="text" id="needToLogin" class="form-control" readonly value="로그인 해주세요!">
							</c:when>
							<c:otherwise>
								<input type="text" name="reviewContent" id="reviewContent" class="form-control" maxlength="1000">
							</c:otherwise>
						</c:choose>
					</td>							
					<td class="col-2">
						<select class="form-select form-select-md" name="reviewRate" id="reviewRate">
							<option value="1">★☆☆☆☆</option>
							<option value="2">★★☆☆☆</option>
							<option value="3">★★★☆☆</option>
							<option value="4">★★★★☆</option>
							<option value="5">★★★★★</option>
						</select>
					</td>							
					<td class="col-2">
						<div class="d-grid gap-2 writeSection">
							<c:choose>
								<c:when test="${empty sessionScope.m }">
									<button type="button" id="reviewLogin" class="btn btn-secondary btn-md">작성</button>
								</c:when>
								<c:when test="${not empty sessionScope.m and orderStat == -1 and reviewChk eq false}">
									<button type="button" id="reviewRsrv" class="btn btn-secondary btn-md">작성</button>
								</c:when>
								<c:when test="${orderStat == 4 and reviewChk eq false}">
									<button type="button" id="reviewWrite" class="btn btn-md clsfrm-btn">작성</button>											
								</c:when>
								<c:when test="${orderStat == 4 and reviewChk eq true}">
									<button type="button" id="reviewAlrdy" class="btn btn-secondary btn-md">작성</button>											
								</c:when>
							</c:choose>
						</div>
					</td>							
				</tr>
			</table> 			
		</div>
		
			<div class="recipe" style="display: none;">
				<c:forEach items="${p.rbList }" var="rb">
					<div class="rbContent">
						<c:if test="${sessionScope.m.memberNo != null}">
							<a
								href="/recipeView.do?recipeNo=${rb.recipeNo }&memberNo=${sessionScope.m.memberNo}">
								<img src="/resources/upload/recipe/${rb.filepath }">
								<p class="rbTitle">${rb.recipeTitle }</p>
								<p class="rbSub">${rb.subhead }</p>
							</a>
						</c:if>
						<c:if test="${sessionScope.m.memberNo == null}">
							<a href="/recipeView.do?recipeNo=${rb.recipeNo }&memberNo=0">
								<img src="/resources/upload/recipe/${rb.filepath }">
								<p class="rbTitle">${rb.recipeTitle }</p>
								<p class="rbSub">${rb.subhead }</p>
							</a>
						</c:if>
						<hr>
					</div>
				</c:forEach>
			</div>
		</div>
		<script>
			var productAmount = 1;
			var productPrice = ${p.milkitPrice};
			$("#count>button").click(
					function() {
						productAmount = Number($("#amount").html());
						if($(this).html() == "+" && productAmount>9){
							alert("최대 구매수량은 10개입니다.")
						}
						else if ($(this).html() == "+"  ) {
							$("#amount").html(++ productAmount);
								
						} else {
							if (productAmount != 1) {
								$("#amount").html(-- productAmount);
							}
						}

						var price = Number($("#milkitPrice").val());
						 productPrice =  productAmount * price;
						$("#totalPrice").html(
								productPrice.toLocaleString('ko-KR') + "원");
					});
			window.onload = function() {
				$(".view").eq(0).css("font-size", "28px");
				$(".view").eq(0).css("background-color", "#9A86B3");
				$(".view").eq(0).css("color", "#6D5874");
			}
			function initTab() {
				var frms = $(".view");
				for (var i = 0; i < frms.length; i++) {
					$(".view").eq(i).css("font-size", "25px");
					$(".view").eq(i).css("background-color", "#C4BFE3");
					$(".view").eq(i).css("color", "#8E44AD");
				}
			}
			function selectOne(i) {
				initTab();
				$(".view").eq(i).css("font-size", "28px");
				$(".view").eq(i).css("background-color", "#9A86B3");
				$(".view").eq(i).css("color", "#6D5874");
			}

			$(".view").eq(0).click(function() {
				selectOne(0);
				$(".pContent").css("display", "block");
				$(".review").css("display", "none");
				$(".recipe").css("display", "none");
			});
			$(".view").eq(1).click(function() {
				selectOne(1);
				$(".pContent").css("display", "none");
				$(".review").css("display", "block");
				$(".recipe").css("display", "none");
			});

			$(".view").eq(2).click(function() {
				selectOne(2);
				$(".pContent").css("display", "none");
				$(".review").css("display", "none");
				$(".recipe").css("display", "block");
			});
			
			//최근 본 상품 기록용
			$(function(){
				var memberId = $(".memberId").val();
				var productNo = $(".productNo").val();
				if(memberId != null){
					$.ajax({
						url: "/insertRecentProduct.do",
						method: "get",
						data: {memberId:memberId, productNo:productNo},
						success: function(data){
							console.log(data);
						}
					});
				}
				
				//성승민 자바스크립트 추가용
			
				//리뷰 이미 작성했을때
				$(document).on("click", "#reviewAlrdy", function(){
					alert("이미 리뷰를 작성하셨습니다!");
				});
				
				//구매는 안했을때
				$(document).on("click", "#reviewRsrv", function(){
					alert("밀키트를 구매한 회원만 작성할 수 있습니다!");
				});
				
				//비회원 로그인
				$(document).on("click", "#reviewLogin", function(){
					alert("로그인 하세요!");
				});
				
				//리뷰 작성 버튼
				$(document).on("click", "#reviewWrite", function(){
					let productNo = $("#productNo").val();
					let memberNickname = $("#memberNickname").val();
					let reviewContent = $("#reviewContent").val();
					let reviewRate = $("#reviewRate").val();
					
					console.log(productNo);
					console.log(memberNickname);
					console.log(reviewContent);
					console.log(reviewRate);
					
					if(reviewContent == ''){
						alert("공백은 안돼요");
						return;
					}
					
					$.ajax({
						url:"/insertPurchaseReview.do",
						type : "post",
						data : {productNo:productNo, memberNickname:memberNickname, reviewContent:reviewContent, reviewRate:reviewRate},
						success : function(data){
							console.log(data);
							if(data==1){
								console.log("성공!(테스트용)");
							}else if(data==0){
								console.log("실패!(테스트용)");						
							}

						$(".reviewTable").load(location.href+" .reviewTable");
						$(".writeSection").load(location.href+" .writeSection");
						//$(".reviewScore").load(location.href+" .reviewScore");
						
						},
						complete : function(){
							$("#reviewContent").val("");
						}
					});
				});
				
				//리뷰 삭제 AJAX
				$(document).on("click", ".reviewDelete", function(){
					//let reviewNoParam = $(this).attr("href");
					let reviewNo = $(this).children(".deleteLinkVal").val();

					$.ajax({
						url : "/deletePurchaseReview.do",
						type : "post",
						data : {reviewNo:reviewNo},
						success : function(data){
							$(".reviewTable").load(location.href+" .reviewTable");
							$(".writeSection").load(location.href+" .writeSection");
							//$(".reviewScore").load(location.href+" .reviewScore");
						}
					});
					
				});
				
			});
			
			$("#cart").click(function() {
				var memberNo = $("#loginCheck").val();
				var productNo = ${p.productNo};
				
				if(memberNo != ""){
					$.ajax({
						url:"/insertCart.do",
						data:{productNo:productNo,
							memberNo:memberNo,
							productPrice:productPrice,
							productAmount:productAmount},
						type:"post",
						success:function(data){
							if(data==1){
								$("#modal-wrap").css("display","block");
							}else{
								alert("장바구니 담기 실패");
							}
						}
					});
				}else{
					alert("로그인 후 이용해주세요");
					$(location).attr("href","/loginFrm.do");
				}
			});
			$("#cancelBtn").click(function() {
				$("#modal-wrap").hide();
			});

			
		</script>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>