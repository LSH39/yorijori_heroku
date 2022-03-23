<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/recipe/recipeFrm.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="main">
		<h1>레시피 등록</h1>
		<form action="/recipeFrm.do" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="recipeWriter" value="${sessionScope.m.memberNo }">
			<div class="recipeFrm">
				<label for="recipeTitle">레시피 제목 </label>
				<input type="text" id="recipeTitle" name="recipeTitle" placeholder="예) 맛있는 소고기 미역국 끓이기 ">
			</div>
			<div class="recipeFrm">
				<label for="subhead">요리 한줄설명</label> 
				<input type="text" id="subhead" name="subhead" placeholder="레시피를 소개할 수 있는 한줄 설명을 입력해주세요">
			</div>
			<div class="recipeFrm">
				<label for="uploadImg">대표이미지</label> 
				<img id="img" >
				<input type="file" id="uploadImg" name="uploadImg" onchange="loadImg(this);"
					accept=".jpg,.jpeg,.png,.gif"  >
					
			</div>
			<div class="recipeFrm">
				<label for="recipeVideo">유튜브 링크<br>(생략가능)</label>
				https://youtu.be/
				<input type="text" name="recipeVideo" placeholder="xsTFsunt6-8">
			</div>
		<div class="recipeFrm">
				<label>음식정보</label>
				<div id="recipeFrm1">
					<p>음식이름</p>
					<input type="text" id="foodName" name="foodName" placeholder="음식명을 입력하세요" maxlength="20">
					 <input type="text" id="recipeTime" name="recipeTime"
						placeholder="조리시간 예) 60분">소요
				</div>
				<div id="recipeFrm2">
					<p>재료정보</p>
					<div class="materialBox">
						<input type="text"  name="mNameList"placeholder="예) 고추장"> 
						<input type="text"	name="mAmountList" placeholder="예) 2T">
					</div>
					<div class="materialBox">
						<input type="text" name="mNameList" placeholder="예) 양파"> 
						<input type="text" name="mAmountList" placeholder="예) 1/2개">
					</div>
					<div class="materialBox">
						<input type="text" name="mNameList" placeholder="예) 닭가슴살">
						<input type="text" name="mAmountList" placeholder="예) 300g">
					</div>
					
					<div class="newInput"></div>
					<p id="plusBtn">재료추가</p>
            </div>
				</div>
			<div class="recipeFrm">
				<label>카테고리</label>
				<select name="situation" id="situation">
					<option selected value="">상황별</option>
					<option value="1">술안주</option>
					<option value="2">다이어트</option>
					<option value="3">손님초대</option>
					<option value="4">혼밥/자취</option>
					<option value="5">간식</option>
					<option value="6">유아식</option>
					<option value="7">비건/채식</option>
					<option value="8">기타</option>
				</select> <select name="material" id="material">
					<option selected value="">재료별</option>
					<option value="1">육류</option>
					<option value="2">채소류</option>
					<option value="3">해산물</option>
					<option value="4">달걀/유제품</option>
					<option value="5">면/만두</option>
					<option value="6">콩/두부</option>
					<option value="7">과일</option>
					<option value="8">기타</option>
				</select> <select name="recipeLevel" id="recipeLevel">
					<option selected value="">난이도별</option>
					<option value="1">상</option>
					<option value="2">중</option>
					<option value="3">하</option>
				</select>
			</div>
			<div class="recipeFrm">
			<label>조리방법</label>
				<div class="cookOrder">
					<p style="margin-top: 50px;">STEP1</p>
					<textarea name="rContentList"></textarea>
					<input type="file" name="files" accept=".jpg,.jpeg,.png,.gif" 
						multiple> 
				</div>
				<div class="newContent"></div>
				<p id="plusBtn2">순서추가</p>
			</div>
			<div id="btn"><input type="submit" value="등록하기" onclick="return subBtn()" id="submitBtn"></div>
		</form>
	</div>
	<script>
		function loadImg(obj) {
		  var files = obj.files;
		  if(files.length != 0){
			  var reader = new FileReader();
			  reader.readAsDataURL(files[0]);
			  reader.onload = function(e) {
				$("#img").attr("src",e.target.result);
				$("#img").css("height","200px");
				$("#img").css("width","200px");
			}
		  }
		}
		
		
		function subBtn() {
			var mName = $("input[name='mNameList']").length;
			var rContent = $("textarea[name='rContentList']").length;
			
			for(i=0; i<rContent; i++){
				if($("textarea[name='rContentList']").eq(i).val()=="" || $("input[name='files']").eq(i).val()==""){
					alert("조리순서를 빈칸없이 작성해주세요");
					return false;
				}
			}
			
			for(i=0; i<mName;i++){
				if($("input[name='mNameList']").eq(i).val()==""){
					alert("재료이름를 빈칸없이 작성해주세요");
					return false;
				}
			}	
			
		 	if($("#recipeTitle").val()=="" || $("#subhead").val()=="" || $("#uploadImg").val()=="" || $("#foodname").val()=="" || $("#recipeTime").val() ==""){
					 alert("빈칸없이 작성해주세요"); 
					 return false;
				}else if( $("#situation").val()=="" || $("#material").val()=="" || $("#recipeLevel").val()=="" ){
		 		     alert("카테고리를 선택해주세요"); 
					 return false;
			}
			}
			
		$(function() {	
			var orderNum = 1;
			
			$("#plusBtn").click(function() {
				console.log("22");
				var mHTML = "<div class='materialBox'>"
				+ "<input type='text' name='mNameList'>" 
				+ " <input type='text'  name='mAmountList' > </div>";
				console.log(mHTML);
				$(".newInput").append(mHTML);
			});
			
				
			$("#plusBtn2").click(function() {
				var contentHTML = "<div class='cookOrder'> <p>STEP"+(++orderNum)+"</p>"
					+ "<textarea name='rContentList' '></textarea >"
					+ " <input type='file' name='files' accept='.jpg,.jpeg,.png,.gif' multiple></div>";
				$(".newContent").append(contentHTML);
				
		});
			
		});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>