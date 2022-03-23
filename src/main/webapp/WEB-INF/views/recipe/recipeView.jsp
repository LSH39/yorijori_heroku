<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="/resources/css/recipe/recipeView.css">
<style>
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="main">
		<div id="modal-wrap" style="display: none;">
			<h1>신고하기</h1>
			<div id="modal-content">
				<h5>신고사유</h5>
				<div class="modalInput">
					<input type="radio" name="reportComment" value="재료가 부적합함"
						id="report1"><label for="report1">재료가 부적합함</label> <input
						type="radio" name="reportComment" value="내용이 부적절함" id="report2"><label
						for="report2">내용이 부적절함</label> <input type="radio"
						name="reportComment" value="홍보성 게시글" id="report3"><label
						for="report3">홍보성 게시글</label>
				</div>
				<div class="modalInput">
					<input type="radio" name="reportComment" value="중복된 게시글"
						id="report4"><label for="report4">중복된 게시글</label> <input
						type="radio" name="reportComment" value="욕설이 포함됨" id="report5"><label
						for="report5">욕설이 포함됨</label>
				</div>
				<div id="modal-btn">
					<button id="reportBtn">신고하기</button>
					<button id="cancelBtn">닫기</button>
				</div>
			</div>
		</div>
		<div class="mainImg">
			<img src="/resources/upload/recipe/${rb.filepath }" id="titleImg">
			<div id="count">
				<span id="countImg"><img src="/resources/img/recipe/eye.png"
					width="20px"></span><span id="countText"> ${rb.readCount }</span>
			</div>				
		</div>
		<c:if test="${sessionScope.m.memberNo eq rb.recipeWriter }">
		<div id="update">
				<span><a href="/updateRecipe.do?recipeNo=${rb.recipeNo }&memberNo=${sessionScope.m.memberNo}">수정</a></span>
					<span><a href="/deleteRecipe.do?recipeNo=${rb.recipeNo }">삭제</a></span>
			</div>
			</c:if>
		<c:if test="${sessionScope.m.memberNo != null }">
			<c:if test="${rb.likeCheck eq 0 }">
				<div class="checkImg">
					<span id="heart"><img src="/resources/img/recipe/heart.png"></span>
					<span class="report"><img
						src="/resources/img/recipe/report.png"></span>
				</div>
			</c:if>
			<c:if test="${rb.likeCheck eq 1 }">
				<div class="checkImg">
					<span id="heart2"><img
						src="/resources/img/recipe/heart2.png"></span> <span class="report"><img
						src="/resources/img/recipe/report.png"></span>
				</div>
			</c:if>
		</c:if>
		<div class="rbList">
		 	<a href="/profile.do?memberId=${rb.memberId }">
			<img  src="/resources/upload/member_profile/${rb.profile }" id="profile">
			<p id="rbName">${rb.nickname }</p>
			</a>
			<p id="rbTitle">${rb.recipeTitle }</p>
			<p id="rbSub">${rb.subhead }</p>
			<div class="rbImg">
				<p>
					<img src="/resources/img/recipe/watch.png" width="20px"><img
						src="/resources/img/recipe/star.png" width="20px">
				</p>
				<p>
					<span class="text">40분</span> <span class="text"> <c:choose>
							<c:when test="${rb.recipeLevel eq 1}">상</c:when>
							<c:when test="${rb.recipeLevel eq 2}">중</c:when>
							<c:when test="${rb.recipeLevel eq 3}">하</c:when>
						</c:choose></span>
				</p>
			</div>
		</div>

		<div class="mList">
			<hr>
			<p id="mTitle">[ 재료 ]</p>
			<ul>
				<c:forEach items="${rb.MList}" var="m">
					<li>- ${m.materialName } <span class="amount">
							${m.MAmount}</span></li>
				</c:forEach>
			</ul>
			<hr>
		</div>
		<div class="recipeNavi">
			<ul>
				<li class="view">상세정보</li>
				<li class="view">댓글</li>
				<li class="view">관련상품</li>
			</ul>
		</div>

		<div class="rcList" style="display: none;">
			<div class="rcInput">
				<c:if test="${sessionScope.m.memberNo != null}">
					<form>
						<textarea name="rcContent" id="rcContent"></textarea>
						<input type="hidden" value="${sessionScope.m.memberNo }"
							id="memberNo"> <input type="button" value="댓글작성"
							id="insertBtn">
					</form>
				</c:if>
			</div>
			<c:forEach items="${list}" var="rc">
				 <div class="comments">
					<img src="/resources/img/recipe/person.png" width="30px"> <span
						class="rcName">${rc.nickname }</span> <span class="rcDate">${rc.rcDate }</span>
					<p class="rcContents">${rc.rcContentBr }</p>
					<textarea id="updateContent" name="rcContent" class="form-control"
						style="display: none;">${rc.rcContent }</textarea>
					<button style="display: none;" id="updateBtn">수정완료</button>
					<c:if test="${sessionScope.m.memberNo == rc.memberNo}">
						<p class="commentsBtn">
							<a href="javascript:void(0)"
								onclick="updateComment(this,'${rc.RCommentNo}');">수정</a> <a
								href="javascript:void(0)"
								onclick="deleteComment(this,'${rc.RCommentNo}');">삭제</a>
						</p>
					</c:if>
				</div>
			</c:forEach>
		</div>
		<c:if test="${rb.recipeVideo != null }">
		<div id="recipeVideo">
		<iframe width="703" height="395" src="https://www.youtube.com/embed/${rb.recipeVideo }" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		</c:if>
		
		<div class="contentsWrap">
			<c:forEach items="${rb.RList }" var="rc" varStatus="i">
				<div class="contents">
					<div class="conNum">${i.count }</div>
					<div class="conText">${rc.rContentBr }</div>
					<img src="/resources/upload/recipeContent/${rc.filepath }">
					
				</div>
				
			</c:forEach>
		</div>

		<div class="product" style="display: none;">
			
			<c:forEach items="${rb.PList }" var="p">
				<div class="milkit">
					<c:if test="${sessionScope.m.memberNo != null}">
						<a
							href="/milkitView.do?productNo=${p.productNo }&memberNo=${sessionScope.m.memberNo}&recipeNo=${p.recipeNo}">
							<img src="/resources/upload/product/${p.filepath }">
							<p class="pTitle">${p.milkitName }</p>
							<p class="pComment">${p.milkitComment}</p>
							<p class="mPrice"><fmt:formatNumber value="${p.milkitPrice}" />원</p>
						</a>
					</c:if>
					<c:if test="${sessionScope.m.memberNo == null}">
						<a
							href="/milkitView.do?productNo=${p.productNo }&memberNo=0&recipeNo=${p.recipeNo}">
							<img src="/resources/upload/product/${p.filepath }">
							<p class="pTitle">${p.milkitName }</p>
							<p class="pComment">${p.milkitComment}</p>
							<p class="mPrice">
								<fmt:formatNumber value="${p.milkitPrice}" />
								원
							</p>
						</a>
					</c:if>
					<hr>
				</div>
			</c:forEach>
		</div>

	</div>
	<script>
		window.onload = function() {
			$(".view").eq(0).css("font-size", "28px");
			$(".view").eq(0).css("background-color", "#9A86B3");
			$(".view").eq(0).css("color", "#6D5874");
		}

		var memberNo = $("#memberNo").val();

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
			$(".rcList").css("display", "none");
			$(".contentsWrap").css("display", "block");
			$(".product").css("display", "none");
			$("#recipeVideo").css("display", "block");
		});
		$(".view").eq(1).click(function() {
			selectOne(1)
			$(".rcList").css("display", "block");
			$(".contentsWrap").css("display", "none");
			$(".product").css("display", "none");
			$("#recipeVideo").css("display", "none");
		});
		$(".view").eq(2).click(function() {
			selectOne(2)
			$(".rcList").css("display", "none");
			$(".contentsWrap").css("display", "none");
			$(".product").css("display", "block");
			$("#recipeVideo").css("display", "none");
		});

		$("#insertBtn").click(function() {
			var rcContent = $("#rcContent").val();
			var recipeNo = ${rb.recipeNo};
			var memberNo = $("#memberNo").val();
			$.ajax({
				url : "/insertComment.do",
				data : {
					rcContent : rcContent,
					recipeNo : recipeNo,
					memberNo : memberNo
				},
				type : "post",
				success : function(data) {
					if (data > 0) {
						alert("댓글 작성 완료");
					} else {
						alert("댓글 작성 실패");
					}
					location.reload();
				}
			});
		});
		function updateComment(obj, rCommentNo) {
			$(obj).parent().prev().show();
			$(obj).parent().prev().prev().show();
			$(obj).parent().prev().prev().prev().hide();
			$(obj).hide();
			$(obj).parent().prev().attr("onclick","updateComplete(this,'" + rCommentNo + "');");
			$(obj).next().html("취소");
			$(obj).next().attr("onclick","updateCancel(this,'" + rCommentNo + "');");
		}
		function updateCancel(obj, rCommentNo) {
			$(obj).parent().prev().hide();
			$(obj).parent().prev().prev().hide();
			$(obj).prev().show();
			$(obj).html("삭제");
			$(obj).attr("onclick", "deleteComment(this,'" + rCommentNo + "');");
		}
		function updateComplete(obj, rCommentNo) {
			var rcContent = $("#updateContent").val();
			console.log(rcContent);
			$.ajax({
				url : "/updateComment.do",
				data : {
					rCommentNo : rCommentNo,
					rcContent : rcContent
				},
				type : "post",
				success : function(data) {
					if (data > 0) {
						alert("수정완료");
					} else {
						alert("수정실패");
					}
					location.reload();
				}
			});

		}
		function deleteComment(obj, rCommentNo) {
			if (confirm("댓글을 삭제하시겠습니까?")) {
				$.ajax({
					url : "/deleteComment.do",
					data : {
						rCommentNo : rCommentNo
					},
					type : "post",
					success : function(data) {
						if (data > 0) {
							alert("삭제완료");
						} else {
							alert("삭제실패");
						}
						location.reload();
					}
				});
			}
		}
		$("#heart").click(function() {
			var recipeNo = ${rb.recipeNo};
			$.ajax({
				url : "/insertLike.do",
				data : {
					memberNo : memberNo,
					recipeNo : recipeNo
				},
				type : "post",
				success : function(data) {
					if (data > 0) {
						location.reload();
					}
				}
			})
		});
		$("#heart2").click(function() {
			var recipeNo = ${rb.recipeNo};
			$.ajax({
				url : "/deleteLike.do",
				data : {
					recipeNo : recipeNo,
					memberNo : memberNo
				},
				type : "post",
				success : function(data) {
					location.reload();
				}
			})
		});
		$(".report").click(function() {
			$("#modal-wrap").show();
		});

		$("#reportBtn").click(function() {
			console.log("dd");
			var recipeNo = ${rb.recipeNo}	;

			var reportComment = $("input[name=reportComment]:checked").val();
			var reportCheck = ${rb.reportCheck};
			if (reportCheck == 0) {
				if (reportComment != null) {
					$.ajax({
						url : "/insertReport.do",
						data : {
							memberNo : memberNo,
							recipeNo : recipeNo,
							reportComment : reportComment
						},
						type : "post",
						success : function(data) {
							if (data > 0) {
								alert("신고되었습니다");

							}
						}
					});
				} else {
					alert("신고사유를 체크해주세요");
				}
			} else {
				alert("신고는 각 레시피당 한 번만 가능합니다");
			}
			location.reload();
		});

		$("#cancelBtn").click(function() {
			$("#modal-wrap").hide();
		});
		

	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>