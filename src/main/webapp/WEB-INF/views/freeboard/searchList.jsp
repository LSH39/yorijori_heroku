<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 - 검색결과</title>
<!-- 공통 CSS-->
<link rel="stylesheet" href="resources/css/mainpage/common.css">
<link rel="stylesheet" href="resources/css/notice/noticeList.css">
<!-- 페이지 전용 CSS -->
<link rel="stylesheet" href="resources/css/freeboard/BoardList.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
  <main id="main">
    <section class="inner-page">
      <div class="container">
      	<div class="row">
	      	<div class="col sidemenu">
				<h1>커뮤니티</h1>
				<div class="sidemenubox">
					<ul class="nav flex-column">
						<li class="nav-item"><a href="/noticeList.do?reqPage=1">공지사항 <span> &gt;</span></a></li>
						<li class="nav-item active"><a href="/freeboardList.do?reqPage=1&orderIndex=0">자유게시판 <span> &gt;</span></a></li>
						<li class="nav-item"><a href="#">추천메뉴 <span> &gt;</span></a></li>
					</ul>
				</div>
	      	</div>
	      	<div class="col-10 main-content">
	      		<div class="main-content-title">
	      			<h2>자유게시판 <span> 회원분들의 즐거운 커뮤니티 공간!</span></h2>
	      			<c:choose>
	      				<c:when test="${not empty sessionScope.m }">
	      					<a href="/freeWriteFrm.do"><button class="btn-main">글 작성하기</button></a>
	      				</c:when>
	      			</c:choose>
	      		</div>
	      		<div class="board-table">
	      			<div class="board-count">
	      				<c:choose>
	      					<c:when test="${totalCount ne 0 }">
	      						<h5>검색결과 : <span style="color: rgb(159, 144, 207);">${totalCount }</span>개</h5>
	      					</c:when>
	      					<c:otherwise>
	      						<h4>검색결과가 없습니다.</h4>
	      					</c:otherwise>
	      				</c:choose>
						</div>
	      			</div>
	      			<table class="table table-hover">
	      				<thead>
	      					<tr>
	      						<th scope="col">번호</th>
	      						<th scope="col">제목</th>
	      						<th scope="col">추천</th>
	      						<th scope="col">작성자(닉네임)</th>
	      						<th scope="col">작성일</th>
	      						<th scope="col">조회</th>
	      					</tr>
	      				</thead>
	      				<tbody>
	      					<c:forEach items="${list }" var="f" varStatus="i">
	      						<tr>
	      							<td>${start+i.index }</td>
	      							<td><a href='/freeView.do?freeNo=${f.freeNo }'>
											${f.freeTitle } [${f.fcCount }]
										</a>
									</td>
									<td>${f.freeLikeCount }</td>
									<td>${f.memberNickname }</td>
									<td>${f.regDate }</td>
									<td>${f.freeReadcount }</td>
								</tr>
							</c:forEach>
	      				</tbody>
	      			</table>
					<div class="pagi">
						${pageNavi }
					</div>
					<form action="/freeSearch.do" method="get">
					<div class="board-search row">
						<div class="col-9">
							검색어 
								<input type="radio" id="searchtype-1" name="searchtype" class="searchtype" value="title">
								<label for="searchtype-1">제목</label>
								<input type="radio" id="searchtype-2" name="searchtype" class="searchtype" value="content">
								<label for="searchtype-2">내용</label>
								<input type="radio" id="searchtype-3" name="searchtype" class="searchtype" value="writerId">
								<label for="searchtype-3">작성자(ID)</label>
								<input type="radio" id="searchtype-4" name="searchtype" class="searchtype" value="writerNickname">
								<label for="searchtype-4">작성자(닉네임)</label>
						</div>
						<div class="col">
							<input type="search" class="tk-search" name="searchword">
							<button class="btn-main btn-search my-2 my-sm-0" type="submit"><img src="resources/img/mainpage/search_icon_w.png" style="width: 25px; height: 25px;"></button>
						</div>
					</div>
					</form>
	      		</div>
	      	</div>
	      </div>
    </section>

  </main><!-- End #main -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script>
	$(function(){
		
		//검색어 선택했는지 확인
		$(".btn-search").on("click", function(){
			var radioSearch = $("input[name='searchtype']").is(":checked");
			if(radioSearch != true){
				alert("검색어 선택 후 버튼을 눌러주세요!");
				return false;
			}
		});
	});
</script>
</body>
</html>