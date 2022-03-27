<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
var checkId=0; var checkPw=0; var checkEmail=0; var checkName=0; var checkNickname=0;
var checkPhone=0; var checkBirth=0; var checkAddr=0; var checkFile=0; var checkBox=0;

$(function(){
    $("#memberId").focus();
    $("#addressDetail").prop("readonly",true);
    $("#pw_hidden").prop("checked", false);
    $("#pw_hidden2").prop("checked", false);
});

function idCheck(obj) {
    obj.value=obj.value.replace(/[^a-z0-9]/g,'');
    var inputId = $("#memberId").val();
    $(".join_check").eq(0).css("color","#FF0000");
    checkId = 0;

    if(inputId == ""){
        $(".join_check").eq(0).text("아이디를 입력해주세요.");
    }else if(/[a-z]$/.test(inputId.substr(0,1)) == false){
        $(".join_check").eq(0).text("아이디는 영어소문자로 시작해주세요.");
    }else{
        if(/[a-z]{1}[a-z0-9]{7,29}$/.test(inputId) == true){
            $.ajax({
                type: "post",
                url: "/joinSearch.do",
                data: {memberId:inputId},
                success: function (data) {
                    if(data == 0){
                    	$(".join_check").eq(0).text("사용가능한 아이디입니다.").css("color","#0000FF");
                    	checkId = 1;
                    }else{
                    	$(".join_check").eq(0).text("이미 사용중인 아이디입니다.");
                    }
                }
            });
        }else if(/^[\W\w]{8,}$/.test(inputId) == false){
            $(".join_check").eq(0).text("최소 8자리를 입력해주세요.");
        }else{
            $(".join_check").eq(0).text("다시 입력해주세요.");
        }
    }
}

function pwCheck(obj){
    obj.value=obj.value.replace(/[^a-z0-9#?!@$%^&*-]/g,'');
    var inputPw = $("#memberPw").val();
    $(".join_check").eq(1).css("color","#FF0000");
    checkPw = 0;

    if(inputPw == ""){
        $(".join_check").eq(1).text("비밀번호를 입력해주세요.");
    }else{
        if(/(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/.test(inputPw) == true){
            if(inputPw == $("#memberPw2").val()){
                $(".join_check").eq(1).text("비밀번호가 일치합니다.").css("color","#0000FF");
                checkPw = 1;
            }else{
                $(".join_check").eq(1).text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
            }
        }else if(/^[\W\w]{8,}$/.test(inputPw) == false){
            $(".join_check").eq(1).text("최소 8자리를 입력해주세요.");
        }else{
            $(".join_check").eq(1).text("조건에 맞게 다시 입력해주세요.");
        }
    }
}
function pwCheck2(obj){
    obj.value=obj.value.replace(/[^a-z0-9#?!@$%^&*-]/g,'');
    var inputPw = $("#memberPw").val();
    var inputPw2 = $("#memberPw2").val();
    $(".join_check").eq(1).css("color","#FF0000");
    checkPw = 0;

    if(/(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/.test(inputPw) == true){
        if(inputPw2 == inputPw){
            $(".join_check").eq(1).text("비밀번호가 일치합니다.").css("color","#0000FF");
            checkPw = 1;
        }else{
            $(".join_check").eq(1).text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
        }
    }else{
        $(".join_check").eq(1).text("조건에 맞게 다시 입력해주세요.");
    }
}

function emailCheck(obj) {
    obj.value=obj.value.replace(/[^a-zA-Z0-9]/g,'');
    var inputEmail = $("#memberEmail").val();
    checkEmail = 0;
    $("#modalbtn").text("인증요청");
    $("#modalbtn").prop("disabled", false);

    if(inputEmail == ""){
        $(".join_check").eq(2).text("이메일을 입력해주세요.").css("color","#FF0000");
    }else{
        $(".join_check").eq(2).text("이메일을 인증해주세요.").css("color","#FF0000");
    }
}
// email Modal
var mailKey;
$("#modalbtn").click(function(){
    $("#enter_btn").css("display","none");
    $("#modalCheck").prop('readonly', false);
    $("#modalCheck").val("");
    $("#tf_p").text("masterKey : yori12").css("color","#444444");  // masterKey 설정
    checkEmail = 0;

    var email = $("#memberEmail").val();
    if(email == ""){
        $(".join_check").eq(2).text("이메일을 입력해주세요.");
        return;
    }else{
        var inputEmail = email+"@"+$("[name=domain]").val();
        $.ajax({
            type: "post",
            url: "/joinSearch.do",
            data: {memberEmail:inputEmail},
            success: function (data) {
                if(data == 0){
                	$("#modalbtn").append("<span class='spinner-border spinner-border-sm' role='status' aria-hidden='true'></span>");
                	var subject="요리조리 메일 인증";
                	var receiver = inputEmail;
                	$.ajax({
                        type: "post",
                        url: "/mailSend.do",
                        data: {subject:subject, receiver:receiver},
                        success: function (data) {
                        	$("#modalbtn").children().remove();
                        	mailKey = data;  // mailKey:인증번호
                         	$('#exampleModalCenter').modal({backdrop: 'static', keyboard: false}).modal('show');
                            
                        }
                    });
                }else{
                	$(".join_check").eq(2).text("이미 등록된 이메일입니다.");
                }
            }
        });
    }
});
$("#check_btn").click(function(){
    var modalKey = $("#modalCheck").val();
    if(modalKey == mailKey || modalKey == 'yori12'){  // masterKey 설정
        $("#tf_p").text("인증 완료되었습니다.").css("color","#0000FF");
        $("#modalCheck").prop('readonly', true);
        $("#enter_btn").css("display","block");
    }else{
        $("#tf_p").text("올바른 인증번호를 입력해주세요.").css("color","#FF0000");
    }
});
$("#enter_btn").click(function(){
    $(".join_check").eq(2).text("이메일 인증 완료").css("color","#0000FF");
    $('#exampleModalCenter').modal('hide');
    $("#modalbtn").text("인증완료");
    $("#modalbtn").prop("disabled", true);
    checkEmail = 1;
});
$("#close_btn").click(function(){
    $(".join_check").eq(2).text("이메일을 인증해주세요.").css("color","#FF0000");
    $('#exampleModalCenter').modal('hide');
    checkEmail = 0;
});

$("#memberName").on("keyup change", function(){
    $(this).val($(this).val().replace(/[^가-힣]/g,''));
    var inputName = $("#memberName").val();
    checkName = 0;

    if(inputName == ""){
        $(".join_check").eq(3).text("이름을 입력해주세요.");
    }else{
        if(inputName.length > this.maxLength){
            inputName = inputName.slice(0, this.maxLength);
            $("#memberName").val(inputName);
        }
        if(/[가-힣]{2,4}$/.test(inputName) == true){
            $(".join_check").eq(3).text("");
            checkName = 1;
        }else if(/^[\W\w]{2,}$/.test(inputName) == false){
            $(".join_check").eq(3).text("최소 2자리를 입력해주세요.");
        }else{
            $(".join_check").eq(3).text("다시 입력해주세요.");
        }
    }
});

$("#memberNickname").on("keyup change", function(){
    var inputNickname = $("#memberNickname").val();
    $(".join_check").eq(4).css("color","#FF0000");
    checkNickname = 0;

    if(inputNickname == ""){
        $(".join_check").eq(4).text("닉네임을 입력해주세요.");
    }else{
        if(inputNickname.length > this.maxLength){
            inputNickname = inputNickname.slice(0, this.maxLength);
            $("#memberNickname").val(inputNickname);
        }
        if(/[\W\w]{2,10}$/.test(inputNickname) == true){
        	$.ajax({
                type: "post",
                url: "/joinSearch.do",
                data: {memberNickname:inputNickname},
                success: function (data) {
                    if(data == 0){
                    	$(".join_check").eq(4).text("사용가능한 닉네임입니다.").css("color","#0000FF");
                    	checkNickname = 1;
                    }else{
                    	$(".join_check").eq(4).text("이미 사용중인 닉네임입니다.");
                    }
                }
            });
        }else if(/^[\W\w]{2,}$/.test(inputNickname) == false){
            $(".join_check").eq(4).text("최소 2자리를 입력해주세요.");
        }else{
            $(".join_check").eq(4).text("다시 입력해주세요.");
        }
    }
});

$("#memberPhone").on("keyup change", function(){
    $(this).val($(this).val().replace(/[^0-9-]/g,''));
    var inputPhone = $("#memberPhone").val();
    $(".join_check").eq(5).css("color","#FF0000");
    checkPhone = 0;

    if(inputPhone == ""){
        $(".join_check").eq(5).text("휴대폰 번호를 입력해주세요.");
    }else{
        if(/^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/.test(inputPhone) == true){
        	$.ajax({
                type: "post",
                url: "/joinSearch.do",
                data: {memberPhone:inputPhone},
                success: function (data) {
                    if(data == 0){
                    	$(".join_check").eq(5).text("사용가능한 번호입니다.").css("color","#0000FF");
                    	checkPhone = 1;
                    }else{
                    	$(".join_check").eq(5).text("이미 등록된 번호입니다.");
                    }
                }
            });
        }else{
            $(".join_check").eq(5).text("올바른 휴대폰 번호를 입력해주세요.");
        }
    }
});

$("#memberBirth").on({
    keydown: function(e){
        return false;
    },
    focus : function(){
        $(".join_check").eq(6).text("");
        checkBirth = 0;
        var today = new Date();
        var maxDay = (today.getFullYear()-15)+"-"+(today.getMonth()+1)+"-"+("0"+(today.getDate()-1)).slice(-2);
        $("#memberBirth").prop("max",maxDay);
    },
    focusout: function(){
        if($("#memberBirth").val() != ""){
            checkBirth = 1;
        }else{
            $(".join_check").eq(6).text("생년월일을 선택해주세요.");
        }
    }
});

$("#address_btn").click(function(){
    $("#addressDetail").prop("readonly",true);
    new daum.Postcode({
        oncomplete: function(data) {
            $("#postcode").val(data.zonecode);
            $("#addressRoad").val(data.roadAddress);
            $("#addressDetail").val("").prop("readonly",false).focus();
            checkAddr = 1;
        }
    }).open();
});

// file
var regex = new RegExp("(.JPG|.jpg|.JPEG|.jpeg|.PNG|.png|.GIF|.gif)$");
var maxSize = 10*1024*1024;  // 파일크기
var pathSize = 30;  // 파일명
function fileChange(file){
    $(".join_check").eq(8).text("");
    checkFile = 0;
    if(file.files[0]!=null){
        var filename = file.files[0].name;
        if(filename.length > pathSize){
            $("#certificatePath").val("");
            $("#filename").val("");
            $(".join_check").eq(8).text("파일명이 너무 깁니다. 파일을 다시 선택해주세요.");
        }else if(file.files[0].size >= maxSize){
            $("#certificatePath").val("");
            $("#filename").val("");
            $(".join_check").eq(8).text("10MB미만의 파일만 등록 가능합니다.");
        }else if(regex.test(filename) == false){
            $("#certificatePath").val("");
            $("#filename").val("");
            $(".join_check").eq(8).text("파일 확장자를 확인해주세요.");
        }else{
            $("#filename").val(filename);
            checkFile = 1;
        }
    }else{
        $("#certificatePath").val("");
        $("#filename").val("");
        $(".join_check").eq(8).text("파일을 선택해주세요.");
    }
}


var selectbox = $(".joinCheckbox");
function checkAll(){
    if(selectbox.eq(0).is(":checked") == true){
        for(var i=0; i<selectbox.length; i++){
            selectbox.eq(i).prop("checked", true);
            checkBox = 1;
        }
    }else{
        for(var i=0; i<selectbox.length; i++){
            selectbox.eq(i).prop("checked", false);
            checkBox = 0;
        }
    }
}
function check(){
    if(selectbox.eq(1).is(":checked")&&selectbox.eq(2).is(":checked")&&selectbox.eq(3).is(":checked")&&selectbox.eq(4).is(":checked") == true){
        if(selectbox.eq(5).is(":checked") == true){
            selectbox.eq(0).prop("checked", true);
        }else{
            selectbox.eq(0).prop("checked", false);
        }
        checkBox = 1;
    }else{
        selectbox.eq(0).prop("checked", false);
        checkBox = 0;
    }
}

function textarea(num) {
    for(var i=0; i<4; i++){
        $(".textarea").eq(i).css("display","none");
    }
    $(".textarea").eq(num-1).css("display","block");
}


$("#pw_hidden+span").click(function(){
	if($("#pw_hidden").is(":checked") == false){
		$(this).prev().prev().attr("type","text");
		$("#pw_hidden").prop("checked", true);
	}else{
		$(this).prev().prev().attr("type","password");
		$("#pw_hidden").prop("checked", false);
	}
});

$("#pw_hidden2+span").click(function(){
	if($("#pw_hidden2").is(":checked") == false){
		$(this).prev().prev().attr("type","text");
		$("#pw_hidden2").prop("checked", true);
	}else{
		$(this).prev().prev().attr("type","password");
		$("#pw_hidden2").prop("checked", false);
	}
});

</script>