<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.js"></script>
<style>
#line2 {
	background-color: gray;
	height: 3px;
	width: 800px;
}

#confirm {
	width: 800px;
	height: 80px;
	margin-top: 100px;
	margin-bottom: 50px;
	background-color: rgb(247, 247, 229);
}

.h_left {
	width: 350px;
	height: 300px;
	float: left;
	margin-left: 30px;
	margin-top: 20px;
}

.h_right {
	width: 350px;
	height: 300px;
	float: left;
	margin-left: 30px;
	margin-top: 20px;
}
/* 메인 영역 */
.main1 {
	width: 1200px;
	margin: 0 auto;
	margin-top: 50px;
	overflow: hidden;
	margin-bottom:40px;
}

.main1>div {
	float: left;
}
/* 메인 내부 서브 네비 */
.main-left-box {
	width: 230px;
	padding: 23px;
	box-sizing: border-box;
	background-color: rgb(224, 219, 239);
	margin-right: 60px;
}

.main-left-box>h2 {
	margin: 0;
	height: 50px;
	cursor: default;
	border-bottom: 3px solid #565c54;
	margin-bottom: 25px;
}

.main-left-box ul {
	list-style-type: none;
	padding: 0;
}

.main-left-box ul>* {
	text-indent: 5px;
}

.main-left-box>ul>li>span {
	font-family: 'ns_b';
	font-size: 18px;
	cursor: default;
	display: block;
	border-bottom: 1px dotted #b9a989;
	padding-bottom: 8px;
	margin-bottom: 8px;
}

.subnavi {
	margin-bottom: 25px;
}

.subnavi a {
	display: block;
	text-decoration: none;
	font-size: 15px;
	line-height: 23px;
	margin-bottom: 2px;
	position: relative;
}

.subnavi a>span {
	position: absolute;
	right: 10px;
	font-size: 10px;
	font-family: 'ns_b';
	display: none;
}


#confirm {
	width:600px;
	height: 300px;
    margin: 0 auto;
	margin-bottom: 50px;
    background-color: rgb(244, 232, 250);
    
}
.cer{
    width:450px;
    height: 100px;
    margin:0 auto;
    margin-top:80px;
    text-align:center;
   
}
#img{
    background-color: purple;
    color:white;
    width:150px;
    height: 30px;
    border: none;
    font-size: 11px;
    float: left;
    margin-right:10px;
  
}
.buttons{
    margin-left:150px;
    margin-top:10px;
    
}
#uu{
  background-color: #d696e2;
  width:400px;
  height:200px;
  
  
  
    
}
#nn{
text-align:center;
}

/* 메인 콘텐츠 설정 */
.main-content {
	width: 875px;
	margin-top:80px;
  background-color: rgb(244, 232, 250);
}
#delbutton{
   background-color:rgb(126, 30, 166);
   color:whitesmoke;
   margin-left: 90px;
   border:none;
   width:150px;
   height:40px;
   

}
</style>
<script>
$(function() {
	
	
     $("#delBtn").click(function() {
		//alert("수정하시겠습니까?");
		$(".delFile").hide();
		$(this).next().show();
		$("[name=status]").val(2);
});


});

</script>
<script>
function loadImg(obj) {
	  var files = obj.files;
	  console.log(files);
	  if(files.length != 0){
		  var reader = new FileReader();
		  reader.readAsDataURL(files[0]);
		  reader.onload = function(e) {
			$("#pp").attr("src",e.target.result);
			$("#pp").css("height","150px");
			$("#upfile").css("display","none");
			
		}
	  }
	}
		$(function() {
			$("#rePro").click(function(e) {
				e.preventDefault();
				$("#myProfile").click();
			});	
				
		});
		function subBtn() {
			if($("input[name='upfile']").val()==""){
				alert("변경할 파일을 선택해주세요");
				return false;
			}
		
		}
			

	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="main1">
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
			<h2 id="nn"><프로필 사진 변경></h2>
		

			<div id="confirm">
				<form action="updateProfile.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="memberId" value="${m.memberId}">
						
					<div class="uu">
						<table border="1" class="cer">
							<tr>
								<td><img id="pp" src="resources/upload/member_profile/${m.profilePath}" width="150px" ></td>
								  
							<td>
				             <c:choose>
							<c:when test="${not empty m.profilePath }">
								<img src="resources/img/mypage/file.png" width="16px" class="delFile">
								<span class="delFile">${m.profilePath}</span>
							
								<button type="button" id="delBtn"
									class="btn btn-primary btn-sm delFile">바꾸기</button>

								<input type="file" name="upfile" id="upfile" style="display: none;" onchange="loadImg(this);"accept=".jpg,.jpeg,.png,.gif" style="display: none;" >
								<input type="hidden" name="oldFilepath" value="${m.profilePath}"
									placeholder="프로필">
							</c:when>
							<c:otherwise>
								<input type="file" class="form-control" id="upfile" name="upfile" accept=".gif, .jpg, .png, .jpeg" multiple>
							</c:otherwise>
						</c:choose>
						</td>	

							</tr>
						</table>
					
						<div class="buttons">
						 
							<button type="submit" id="delbutton" onclick="return subBtn()">프로필 변경</button>
						</div>
						
			
						
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>