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

.h_left{
	width: 350px;
	height: 300px;

	float:left;
	margin-left:30px;
	margin-top:20px;
}
.h_right{
	width: 350px;
	height: 300px;

	float:left;
	margin-left:30px;
	margin-top:20px;
}
/* 메인 영역 */
.main{
    width: 1200px;
    margin: 0 auto;
    margin-top: 50px;
    overflow: hidden;
}
.main>div{
    float: left;
}
/* 메인 내부 서브 네비 */
.main-left-box{
    width: 230px;
    padding: 23px;
    box-sizing: border-box;
    background-color: rgb(224, 219, 239);
    margin-right: 60px;
}
.main-left-box>h2{
    margin: 0;
    height: 50px;
    cursor: default;
    border-bottom: 3px solid #565c54;
    margin-bottom: 25px;
}
.main-left-box ul{
    list-style-type: none;
    padding: 0;
}
.main-left-box ul>*{
    text-indent: 5px;
}
.main-left-box>ul>li>span{
    font-family: 'ns_b';
    font-size: 18px;
    cursor: default;
    display: block;
    border-bottom: 1px dotted #b9a989;
    padding-bottom: 8px;
    margin-bottom: 8px;
}
.subnavi{
    margin-bottom: 25px;
}
.subnavi a{
    display: block;
    text-decoration: none;
    font-size: 15px;
    line-height: 23px;
    margin-bottom: 2px;
    position: relative;
}
.subnavi a>span{
    position: absolute;
    right: 10px;
    font-size: 10px;
    display: none;
}


/* 클릭 표시 a태그 배경색 #d6c6a5 */

/* 메인 콘텐츠 설정 */
.main-content{
    width: 875px;
}
.mbord{

    width:800px;
    height:700px;
    background-color: rgb(224, 224, 224);
    margin: 0 auto;
    margin-bottom: 40px;
}
.profile{
    width:170px;
    height:200px;
    float:left;
    margin-left:70px;
    margin-top:50px;
}
.myInfo{
    width:450px;
    height:600px;
    background-color:rgb(234, 217, 241);
    float:left;
    margin-top:50px;
}
.mine{
    width:400px;
    text-align: center;
    margin-left: 20px;
    border-spacing: 5px;
}
#update{
    width:150px;
    height: 40px;
    background-color: rgb(254, 250, 255);
    color: rgb(126, 30, 166);
    text-align: center;
    font-weight: 600;
    margin-left: 150px;
    margin-top: 20px;
    border: none;
    border-radius: 20px;
    
}
#rePro{
   background-color:rgb(126, 30, 166);
   color:whitesmoke;
   margin-left: 40px;
   border:none;
   margin-top:10px;
}
#pp{
    width:130px;
    height:150px;
    border-radius: 100px;
    margin-left: 30px;
  
}
.noLevel{
color:red;
font-weight:600;

}
.admin{
color:navy;
font-weight:600;
}
</style>
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
			$("#myProfile").css("display","none");
			
		}
	  }
	}
		$(function() {
			$("#rePro").click(function(e) {
				e.preventDefault();
				$("#myProfile").click();
			});	
			
		     $("#delBtn").click(function() {
				$(".delFile").hide();
				$(this).next().show();
				//$("[name=status]").val(2);
		});
		
	
		});
		
		function subBtn() {
			if($("#profileIntro").val()=="" || $("#memberName").val()=="" || $("#memberEmail").val()=="" || $("#memberPhone").val()==""
				|| $("#memberBirth").val()==""|| $("#postcode").val()==""|| $("#addressRoad").val()==""|| $("#addressDetail").val()==""){
				alert("빈칸 없이 작성해주세요");
				return false;
			}
		
		}
			
	</script>
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
        <div class="mbord">
          <div class="profile">
           <img id="pp" src="resources/upload/member_profile/${rm.profilePath }" width="130px">
     
          </div>
          <div class="myInfo">
                <form action="/updateSeller.do" method="post">
        			<table class="mine" border="1">
								<tr>
								<td>회원소개</td>
								<c:choose>
								<c:when test= "${empty rm.profileIntro }">
								<td><input type="text" name="profileIntro" id="profileIntro"
									onfocus="this.placeholder=''" value="안녕하세요"></td>
							</c:when>
							<c:otherwise>
								<td><input type="text" name="profileIntro" id="profileIntro"
									onfocus="this.placeholder=''" value="${rm.profileIntro }"></td>
							</c:otherwise>
							</c:choose>
							</tr>
							<tr>
								<td>회원아이디</td>
								<td><input type="text" name="memberId" id="memberId"
									onfocus="this.placeholder=''" value="${rm.memberId }" readonly></td>
							</tr>
							<tr>
								<td>회원이름</td>
								<td><input type="text" name="memberName" id="memberName"
									onfocus="this.placeholder=''" value="${rm.memberName }"></td>
							</tr>
							<tr>
								<td>회원이메일</td>
								<td><input type="text" name="memberEmail" id="memberEmail"
									onfocus="this.placeholder=''" value="${rm.memberEmail }"></td>
							</tr>
							<tr>
								<td>회원닉네임</td>
								<td><input type="text" name="memberNickname" id="memberNickname"
									onfocus="this.placeholder=''" value="${rm.memberNickname }" readonly></td>
							</tr>
							<tr>
								<td>휴대폰번호</td>
								<td><input type="text" name="memberPhone" id="memberPhone"
									onfocus="this.placeholder=''"value="${rm.memberPhone }"></td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td><input type="text" name="memberBirth" id="memberBirth"
									onfocus="this.placeholder=''" value="${rm.memberBirth }"></td>
							</tr>
				               <tr>
				                   <td>자격증</td>
				              	<td><input type="text" name="certificatePath" id="certificatePath"
									onfocus="this.placeholder=''" value="${rm.certificatePath }" readonly></td> 	 
				               </tr>
				                
				               <tr>
								<td>우편번호</td>
								<td><input type="text" name="postcode" id="postcode"
									onfocus="this.placeholder=''" value="${rm.postcode }"></td>
							</tr>
							<tr>
								<td>도로명주소</td>
								<td><input type="text" name="addressRoad" id="addressRoad"
									onfocus="this.placeholder=''" value="${rm.addressRoad }"></td>
							</tr>
							<tr>
								<td>상세주소</td>
								<td><input type="text" name="addressDetail" id="addressDetail"
									onfocus="this.placeholder=''" value="${rm.addressDetail }"></td>
							</tr>
							<tr>
								<td>회원등급</td>
								<td>
									<c:choose>

										<c:when test="${m.memberLevel == 1}">
											<input type="text" id="memberLevel"
												onfocus="this.placeholder=''" value="${m.grade }" readonly>
										</c:when>
										<c:when test="${m.memberLevel ==2 }">
											<input type="text" id="memberLevel"
												onfocus="this.placeholder=''" value="${m.grade }" readonly>
										</c:when>
										<c:when test="${m.memberLevel == 3 }">
											<input type="text" id="memberLevel" class="admin"
												onfocus="this.placeholder=''" value="${m.grade }" readonly>
										</c:when>
										<c:when test="${m.memberLevel == 4 }">
											<input type="text" id="memberLevel" class="noLevel"
												onfocus="this.placeholder=''" value="${m.grade }" readonly>
										</c:when>
										<c:when test="${m.memberLevel == 5 }">
											<input type="text" id="memberLevel" class="noLevel"
												onfocus="this.placeholder=''" value="${m.grade }" readonly>
										</c:when>
										<c:when test="${m.memberLevel == 6 }">
											<input type="text" id="memberLevel" class="noLevel"
												onfocus="this.placeholder=''" value="${m.grade }" readonly>
										</c:when>

									</c:choose>
								</td>
								
							</tr>
							<tr>
								<td>포인트내역</td>
								<td><input type="text"  id="memberPoint"
									onfocus="this.placeholder=''" value="${rm.memberPoint }P" readonly></td>
							</tr>
							<tr>
								<td>가입일</td>
								<td><input type="text" name="enrollDate" id="enrollDate"
									onfocus="this.placeholder=''" value="${rm.enrollDate }" readonly></td>
							</tr>

              </table>
              <div class="buttonBox">
              <button type="submit" value="수정하기" id="update" onclick="return subBtn()">수정하기</button>
              </div>
            
  
         </form>
      </div>
 
          </div>

        </div>
        
        </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>