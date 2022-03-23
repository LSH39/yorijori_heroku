<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<form action="/updateRecipeFrm.do" method="post"	enctype="multipart/form-data">
			<input type="hidden" name="recipeNo" value="${rb.recipeNo }">
			<div class="recipeFrm">
				<label for="recipeTitle">레시피 제목 </label>
				<input type="text" id="recipeTitle" name="recipeTitle" value="${rb.recipeTitle }">
			</div>
			<div class="recipeFrm">
				<label for="subhead">요리 한줄설명</label> 
				<input type="text" id="subhead" name="subhead" value="${rb.subhead }">
			</div>
			<div class="recipeFrm">
				<label for="uploadImg">대표이미지</label> 
				<input type="hidden" name="filepath" value="${rb.filepath }">
				<img id="img" src="/resources/upload/recipe/${rb.filepath }"  width="150px">
				<span id="imgName">${rb.filepath }</span>
				<input type="file" id="uploadImg" name="uploadImg" onchange="loadImg(this);" 
					accept=".jpg,.jpeg,.png,.gif" > 
					
			</div>
			<div class="recipeFrm">
				<label for="recipeVideo">동영상 링크</label>
				<input type="text" name="recipeVideo" value="${rb.recipeVideo }">
			</div>
			<div class="recipeFrm">
				<label>음식정보</label>
				<div id="recipeFrm1">
					<p>음식이름</p>
					<input type="text" id="foodName" name="foodName" value="${rb.foodName }">
					 <input type="text" id="recipeTime" name="recipeTime"
						value="${rb.recipeTime }">소요
				</div>
				<div id="recipeFrm2">
					<p>재료정보</p>
					<c:forEach items="${rb.MList }" var="m">
					<div class="materialBox">
						<input type="hidden" name="mNoList" value="${m.materialNo }">
						<input type="text"  name="mNameList" value="${m.materialName }"> 
						<input type="text"	name="mAmountList" value="${m.MAmount }">
					</div>
					
					</c:forEach>
				
					<div id="newInput"></div>
				
					<p id="plusBtn">재료추가</p>
				</div>
			</div>
			<div class="recipeFrm">
				<p>카테고리</p>
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
			
			<c:forEach items="${rb.RList }" var="rc" varStatus="i">
				<div class="cookOrder">		
				<c:set var="num" value="${num+1 }"></c:set>			
					<p>STEP${i.count }</p>
					<input type="hidden" name="rcNoList" value="${rc.RFileNo }">
					<textarea name="rContentList">${rc.recipeContent}</textarea><br>
					<img src="/resources/upload/recipeContent/${rc.filepath }" width="150px">
					<span>${rc.filepath }</span>					
				</div>
			</c:forEach>
				<div class="newContent"></div>
				<p id="plusBtn2">순서추가</p>
			</div>
			<div id="btn"><input type="submit" id="submitBtn" value="등록하기" onclick="return subBtn()"></div>
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
			var mName2 = $("input[name='mNameList2']").length;
			var rContent2 = $("textarea[name='rContentList2']").length;
			
			for(i=0; i<rContent; i++){
				if($("textarea[name='rContentList']").eq(i).val()==""){
					alert("조리순서를 빈칸없이 작성해주세요");
					return false;
				}
			}
			for(i=0; i<rContent2; i++){
				if($("textarea[name='rContentList2']").eq(i).val()==""){
					alert("조리순서를 빈칸없이 작성해주세요");
					return false;
				}
			}
			
			for(i=0; i<mName;i++){
				if($("input[name='mNameList']").eq(i).val()=="" ){
					alert("재료이름를 빈칸없이 작성해주세요");
					return false;
				}
			}	
			for(i=0; i<mName2;i++){
				if($("input[name='mNameList2']").eq(i).val()=="" ){
					alert("재료이름를 빈칸없이 작성해주세요");
					return false;
				}
			}	
		 	if($("#recipeTitle").val()=="" || $("#subhead").val()=="" ||  $("#foodname").val()=="" || $("#recipeTime").val() =="" ){
		 		     alert("빈칸없이 작성해주세요"); 
					 return false;
				}else if( $("#situation").val()=="" || $("#material").val()=="" || $("#recipeLevel").val()=="" ){
			 		     alert("카테고리를 선택해주세요"); 
						 return false;
				}
			}
			
		$(function() {
			$("#plusBtn").click(function() {
				var mHTML = "<div class='materialBox'>"
				+ "<input type='text' name='mNameList'>" 
				+ " <input type='text'  name='mAmountList'> </div>";
				$("#newInput").append(mHTML);
			});
			
			var orderNum = ${num};
			$("#plusBtn2").click(function() {
				var contentHTML = "<div class='cookOrder'> <p>STEP"+(++orderNum)+"</p>"
					+ "<textarea name='rContentList' ></textarea >"
					+ " <input type='file' name='files' accept='.jpg,.jpeg,.png,.gif' multiple>"
					+ "<img class='recipeImg'></div>";
				$(".newContent").append(contentHTML);
				
		});
			$("#uploadImg").change(function() {
				$("#imgName").css("display","none");
			});
			
		});
		</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>