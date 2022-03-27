<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/resources/css/chat/Chat.css" rel="stylesheet" type="text/css">
<link href="/resources/css/chat/ChatAdmin.css" rel="stylesheet" type="text/css">

<!-- adminHome -->
<div class="chatFrm shadow" id="chatFrmAdminHome">
    <div class="chatTop"><p>요리조리 1:1 문의 목록</p></div>
    <div class="chatMain">
        <table id="chatAdminHomeTbl">
            <!-- ajax로 추가 -->
        </table>

    </div>
    <div class="chatBottom">
        <br>
    </div>
</div>

<!-- admin -->
<div class="chatFrm shadow" id="chatFrmAdmin">
    <div class="chatTop"><p>요리조리 1:1 문의</p></div>
    <div class="chatMain scrollBottom">
        <table id="chatAdminTbl">
            <!-- WebSocket으로 추가 -->
        </table>
    </div>
    <div class="chatBottom">
        <textarea id="chatText"></textarea>
        <button id="chatEnter"></button>
    </div>
</div>

<script>
	var sessionMemberNo = ${sessionScope.m.memberNo};
	var adminNo;
	var selectUser;
	var sendMsg;
	var sendTextBefore;
	var ws;
	var webSocketType;
	var startNo = 0;
	var enter = 0;
	
    $(function(){
        $("#chatFrmAdminHome").css("display","none").prop("on",false);
        $("#chatFrmAdmin").css("display","none").prop("on",false);
	    $(".chatAlarm").css("display","inline");
	    $.ajax()
	    // heroku websocket 주소
	    var host = location.origin.replace(/^http/, 'ws');
	    this.connection = new WebSocket(host+"/chatWebsocket.do");
        //ws = new WebSocket("ws://khdsa1.iptime.org:18080/chatWebsoket.do");
        ws.onopen = startChat;  // ws.onopen 은 웹소켓 연결시 자동으로 실행됨
        ws.onmessage = receiveMsg;
        ws.onclose = endChat;
    });

    $("#chatAdmin").click(function(){
    	if(sessionMemberNo == adminNo){
	    	openChat();
			// chat
	        if($("#chatFrmAdminHome").prop("on") == false){
	        	if($("#chatFrmAdmin").prop("on") == false){
		            $("#chatFrmAdminHome").css("display","block").prop("on",true);
		            if(startNo>1){
		            	$("#chatAdminHomeTbl").children().remove();
			           	reStartChat();
		            }
	        	}else{
	                $("#chatFrmAdmin").css("display","none").prop("on",false);
	                $("#chatAdminTbl").children().remove();
	                closeChat();
	        	}
	        }else{
	        	$("#chatFrmAdminHome").css("display","none").prop("on",false);
	            $("#chatAdminHomeTbl").children().remove();
	            $("#chatFrmAdmin").css("display","none").prop("on",false);
	            $("#chatAdminTbl").children().remove();
	            closeChat();
	        }
			startNo += 1;
    	}else{
    		alert("채팅관리자만 접근 가능합니다.");
    	}
    });
    
    function startChat(){
    	webSocketType = "start";
		var data = {type:"start",memberNo:sessionMemberNo};
	    ws.send(JSON.stringify(data));
	}
    function receiveMsg(param){
		appendChat(param.data);
	}
	function endChat(){
		
	}
	
	function reStartChat(){
		webSocketType = "reStart";
		var data = {type:"reStart",memberNo:sessionMemberNo};
	    ws.send(JSON.stringify(data));
	}
	
	function openChat(){
	   	webSocketType = "openChat";
		var data = {type:"openChat",memberNo:sessionMemberNo};
	    ws.send(JSON.stringify(data));
	}
	
	function closeChat(){
	   	webSocketType = "closeChat";
		var data = {type:"closeChat"};
	    ws.send(JSON.stringify(data));
	}
	
	function appendChat(textMsg){
		var msg = JSON.parse(textMsg);
		// adminNo
		if(msg.adminNo != null){
			adminNo = msg.adminNo;
		}
		// alarm
		$("#chatAdminAlarm").text(msg.alarm);
		// chat
		if(msg.appendMsg == "addListMsg"){
			if($("#chatFrmAdmin").prop("on") == false){
				$("#chatAdmin").click();  // close
				$("#chatAdmin").click();  // open				
			}
		}else{
			if(webSocketType == "start" || webSocketType == "reStart"){
				$("#chatAdminHomeTbl").append(msg.appendMsg);
			}else if(webSocketType == "chat"){
		      	$("#chatFrmAdminHome").css("display","none").prop("on",false);
		        $("#chatAdminHomeTbl").children().remove();
				$("#chatAdminTbl").append(msg.appendMsg);
				$(".scrollBottom").scrollTop($(".scrollBottom")[0].scrollHeight);  // div scroll bottom으로
			}
		}
		// enter
		if(enter == 1){
			$("#chatText").val("");
			sendMsg = "";
			sendTextBefore = "";
		}
		enter = 0;
		startNo += 1;
	}
	
    // ajax로 불러온 새로운 데이터에 function을 적용하려면, $(document).on() 사용
    $(document).on("mouseenter",".chatHomeTr",function(){
    	$(this).css("background-color","#E0DBEF").css("cursor","pointer");
        $(this).next().css("background-color","#E0DBEF");
    }).on("mouseleave",".chatHomeTr",function(){
    	$("#chatAdminHomeTbl tr").css("background-color","#FFFFFF");
    }).on("mouseenter",".chatHomeTr+",function(){
    	$(this).css("background-color","#E0DBEF").css("cursor","pointer");
        $(this).prev().css("background-color","#E0DBEF");
    }).on("mouseleave",".chatHomeTr+",function(){
    	$("#chatAdminHomeTbl tr").css("background-color","#FFFFFF");
    });
	
 	// user이름 갖고옴. ajax로 채팅 데이터 가져오기, 웹소켓 연동
    $(document).on("click",".chatHomeTr",function(){
    	selectUser = $(this).children().eq(0).text();
    	chatAdmin(selectUser);
    }).on("click",".chatHomeTr+",function(){
    	selectUser = $(this).prev().children().eq(0).text();
    	chatAdmin(selectUser);
    });
    
 	function chatAdmin(selectUser){
 		var alarm = 0;
		$("#chatAdminAlarm").text(alarm);
 		$("#chatFrmAdminHome").css("display","none").prop("on",false);
        $("#chatAdminHomeTbl").children().remove();
        $("#chatFrmAdmin").css("display","block").prop("on",true);
        webSocketType = "chat";
        var data = {type:"selectUser",selectUser:selectUser, sessionMemberNo:sessionMemberNo, alarm:alarm};
      	ws.send(JSON.stringify(data));
 	}
	
    $("#chatEnter").click(function(){
    	enter = 1;
    	var alarm = 0;
		$("#chatAdminAlarm").text(alarm);
    	if(sendMsg.trim() != ""){
		    var sender = sessionMemberNo;
		    var receiver = selectUser;
		    var data = {type:"chat", chatSend:sender, selectUser:selectUser, chatContent:sendMsg, alarm:alarm};
		    ws.send(JSON.stringify(data));
		}
    }); 
	
	$("#chatText").keyup(function(){  // textarea 글자수 제한 (엔터 포함)
		var sendText = $(this).val();
		var sendMsgBr = sendText.replace(/(\n|\r\n)/g,"<br>");
		// 글자수
		var maxByte = 1000;  // max
	    var textVal = sendMsgBr;
	    var textLen = 0;  // 문자 갯수 check
	    var totalByte=0;
	    for(var i=0; i<textVal.length; i++){
	    	var eachChar = textVal.charAt(i);
	        var uniChar = escape(eachChar) //유니코드 형식으로 변환
	        if(uniChar.length>4){
	        	// 한글 : 3Byte
	            totalByte += 3;
	        }else{
	        	// 영문,숫자,특수문자 : 1Byte
	            totalByte += 1;
	        }
	        // 문자 갯수 check
	        if(totalByte<=maxByte){
	        	textLen = i+1;
	        }
	    }
	    // 결과처리
	    if(totalByte>maxByte){
	    	alert("최대 1000Byte까지만 입력가능합니다.");
	    	$(this).val(sendTextBefore);
        }else{
        	sendTextBefore = sendText;  // 전역변수 sendTextBefore
        	sendMsg = sendMsgBr;
        }
	});
</script>