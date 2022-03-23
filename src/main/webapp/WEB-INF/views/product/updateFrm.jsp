<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/product/updateFrm.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src ="/resources/summernote/jquery-3.3.1.js"></script>
	<script src ="/resources/summernote/summernote-lite.js"></script>
	<script src = "/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
  <div class="main">
		<h1>밀키트 수정</h1>
		<form action="/updateFrm.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productNo" value="${p.productNo}">
		<div class="milkitFrm">
		<label for="milkitName">밀키트 이름</label>
		<input type="text" id="milkitName" name="milkitName" value="${p.milkitName}">
		</div>
		<div class="milkitFrm">
		<label for="milkitComment">밀키트 한줄설명</label>
		<input type="text" id="milkitComment" name="milkitComment" value="${p.milkitComment}">
		</div>
		<div class="milkitFrm">
		<label >대표이미지</label>
        <input type="hidden" name="filepath" value="${p.filepath }">
		<img id="titleImg" src="/resources/upload/product/${p.filepath }" width="150px">
        <span id="imgName">${p.filepath }</span>
		<input type="file" id="uploadImg" name="uploadImg" accept=".jpg,.jpeg,.png,.gif" onchange="loadImg(this);">
		</div>
		<div class="milkitFrm">
		<span class="priceWrap">
		<label for="milkitPrice">가격</label>
		<input type="text" id="milkitPrice" name="milkitPrice" value="${p.milkitPrice}"> 원
		</span>
		<span id="stock">재고수량</span>
		<input type="text" id="milkitStock" name="milkitStock"  value="${p.milkitStock}"> 개		
		</div>
		<p id="comment"></p>
		<div class="milkitFrm">
		<label for="summernote">상세설명</label>
		</div>
		<textarea id="summernote" name="milkitContent" >${p.milkitContent}</textarea>
		
		<div id="updateBtn"><input type="submit" value="수정하기" onclick="return subBtn()"></div>
		</form>
	</div>
<script>
function loadImg(obj) {
	var files = obj.files;
	if(files.length != 0){
		var reader = new FileReader();
		reader.readAsDataURL(files[0]);
		reader.onload = function(e) {
			$("#titleImg").attr("src",e.target.result);
			$("#titleImg").css("height","150px");
			$("#titleImg").css("width","150px");
		}
	}
}

$("#uploadImg").change(function() {
	$("#imgName").css("display","none");
});
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
	if($("#milkitName").val()=="" || $("#milkitComment").val()==""  || $("#summernote").val()==""){
		 alert("빈칸없이 작성해주세요"); 
		 return false;
	}
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>