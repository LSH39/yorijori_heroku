<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>yorijori</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/admin/sidenavi.jsp" />
	<div class="container">
	 
    <div style="background-color: #F7F7E5; height: 200px;">
        <div style="float: left;">
            <img src="#" style="width: 200px;">
        <button class="btn btn-warning">로고 변경하기</button>
        
        </div>
        <div style="float: right;">
            <h5>notice</h5>
            <table class="table table-hover">
                <tr class="table-warning">
                    <td><a href="#">제목제목제목제목제목</a></td>
                    <td><a href="#">조회수</a></td>
                    
                </tr>
                </table>
        </div>
    </div>
    
    <table class="table table-hover">
        <tr class="table-warning">
            <td><a href="#">회원관리</a></td>
            <td><a href="#">방문자 통계</a></td>
            <td><a href="#">밀키트 통계</a></td>
            <td><a href="#">쿠폰</a></td>
        </tr>
        <tr class="table-warning">
            <td><a href="allmember.do">전체회원조회</a></td>
            <td><a href="#"></a></td>
            <td><a href="#"></a></td>
            <td><a href="#">쿠폰발행</a></td>
        </tr>
        <tr class="table-warning">
            <td><a href="#">블랙리스트관리</a></td>
            <td><a href="#"></a></td>
            <td><a href="#"></a></td>
            <td><a href="#">쿠폰 관리</a></td>
        </tr>
        <tr class="table-warning">
            <td><a href="#">전문가 가입 승인</a></td>
            <td><a href="#"></a></td>
            <td><a href="#"></a></td>
            <td><a href="#"></a></td>
        </tr>
        <tr class="table-warning">
            <td><a href="#">탈퇴요청 승인</a></td>
            <td><a href="#"></a></td>
            <td><a href="#"></a></td>
            <td><a href="#"></a></td>
        </tr>


    </table>
    
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>