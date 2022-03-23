<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/product/milkitFrm2.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src ="/resources/summernote/jquery-3.3.1.js"></script>
	<script src ="/resources/summernote/summernote-lite.js"></script>
	<script src = "/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<div class="main">
		<h1>밀키트 판매 등록</h1>
		<form action="/insertMilkit.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="milkitWriter" value="${sessionScope.m.memberNo }">
		<input type="hidden" name="recipeNo" value="${recipeNo }">
		<div class="milkitFrm">
		<label for="milkitName">밀키트 이름</label>
		<input type="text" id="milkitName" name="milkitName">
		</div>
		<div class="milkitFrm">
		<label for="milkitComment">밀키트 한줄설명</label>
		<input type="text" id="milkitComment" name="milkitComment" placeholder="밀키트를 소개할 수 있는 한줄 설명을 입력해주세요">
		</div>
		<div class="milkitFrm">
		<label >대표이미지</label>	
		<input type="file" id="uploadImg" name="uploadImg" accept=".jpg,.jpeg,.png,.gif" onchange="loadImg(this);"><br>
		<img id="img" >
		</div>
		<div class="milkitFrm">
		<span class="priceWrap">
		<label for="milkitPrice">가격</label>
		<input type="text" id="milkitPrice" name="milkitPrice" placeholder="숫자만 입력해주세요"> 원
		
		</span>
		<span id="stock">재고수량</span>
		<input type="text" id="milkitStock" name="milkitStock" placeholder="숫자만 입력해주세요"> 개
		</div>
		<p id="comment"></p>
		<div class="milkitFrm">
		<label>상세설명</label>
		</div>
		<textarea id="summernote" name="milkitContent" ></textarea>
		<div id="insertBtn"><input type="submit" value="등록하기" onclick="return subBtn()"></div>
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
	$(function() {
		$('#summernote').summernote({
			height: 400,
			lang:"ko-KR",
			disableResizeEditor: true,
			callbacks: {
				onImageUpload : function(files, editor, welEditable) {       
					for (var i = 0; i < files.length; i++) {
						sendFile(files[i], this);
				}
				}
			}
		});
	});
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({                                                             
			data : form_data,
			type : "POST",
			url : "/image.do",
			cache : false,
			contentType : false,
			enctype : 'multipart/form-data',                                 
			processData : false,
			success : function(data) {                    
				console.log(data);
				  $(el).summernote('editor.insertImage', data);

				}
		});
	}
	function subBtn() {
		  $("#comment").html("");
		  var result = true;
		  var priceReg = /^[0-9]{1,}$/;
          var priceVal = $("#milkitPrice").val();
          if(!(priceReg.test(priceVal))){
             $("#comment").html("숫자만 입력해주세요");
             $("#comment").css("color","red");
             result = false;
          }
          var stockReg = /^[0-9]{1,}$/;
          var stockVal = $("#milkitStock").val();
          if(!(stockReg.test(stockVal))){
        	  $("#comment").html("숫자만 입력해주세요");
              $("#comment").css("color","red");
              result = false;
          }
	 	if(result == false){
	 		console.log(result);
	 		alert("양식을 확인해주세요");
	 		return false;
	 	}
		if($("#milkitName").val()=="" || $("#milkitComment").val()=="" || $("#uploadImg").val()=="" || $("#summernote").val()==""){
			 alert("빈칸없이 작성해주세요"); 
			 return false;
		}
		}
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>