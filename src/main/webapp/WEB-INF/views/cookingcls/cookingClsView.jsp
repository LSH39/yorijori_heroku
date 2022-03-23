<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<!-- 별칭 ccls -->
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/dm/styles.css"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qg5b1hs250&submodules=geocoder"></script>
<!-- 
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3034a6bde601c666de71198a328eaa3e&libraries=services"></script>
 -->

<title>쿠킹클래스 뷰</title>
<style>
	td{
		vertical-align:middle;
	}

	.left{
		width: 66.6666%;
		position:static;
		padding-right: 12px;
		padding-left: 12px;
    	border-radius: 3px;
    	box-shadow: rgb(41 42 43 / 16%) 0px 2px 6px -2px;
    	border: 1px solid rgb(255, 255, 255);
		box-sizing: border-box;
	}
	
	.right{
		width:33.3333%;
		position: static;
		padding-right: 12px;
		padding-left: 12px;
		box-sizing: border-box;

	}
	
	.right-stick{
		display: inline-block;
		position: sticky;
		position: -webkit-sticky;
		top:100px;
		padding: 4px;
		overflow: auto;
	}
	
	.right-stick-content{
		padding: 24px;
    	border-radius: 3px;
    	box-shadow: rgb(41 42 43 / 16%) 0px 2px 6px -2px;
    	border: 1px solid rgb(255, 255, 255);
	}
	
	.class-wrap{
		display:flex;
	}
	
	#payBtn{
		background-color:#8E44AD;
		border-color:#8E44AD;
	}
	
	#payBtn:focus{
		box-shadow: 0 0 0 0.25rem rgb(224 216 239 / 25%);
	}
	
	.vertified{
		background: url('./resources/img/member/sample.png');
    	background-repeat: no-repeat;
	    width: 19px;
    	height: 19px;
	    text-indent: -9999px;
    	display: inline-block;
    	background-position: 0 -368px;
    	margin-left: 5px;
	}
	
	/*여기부터 채팅 목록 css 시작*/
	#result{
	    height: 80%;
    	position: relative;
    	overflow-y: scroll;
	}
	
	.dmList{
		position: fixed !important;
		bottom: 25px !important;
		z-index: 1000000000 !important;
		width: 370px !important;
		height: 80% !important;
		min-height: 520px !important;
		max-height: 680px !important;
		overflow: hidden !important;
		background-color: white !important;
		border-radius: 30px !important;
		box-shadow: rgb(0 0 0 / 30%) 0px 12px 60px 5px !important;
		display:none;
	}
	
	.posRight{
		right: 25px !important;
	}
	
	.scrollBar::-webkit-scrollbar{
		display:none !important;
	}
	
	.dmView{
		position: fixed !important;
		bottom: 25px !important;
		z-index: 1000000000 !important;
		width: 370px !important;
		height: 80% !important;
		min-height: 520px !important;
		max-height: 680px !important;
		overflow: hidden !important;
		background-color: #abc1d1 !important;
		border-radius: 30px !important;
		box-shadow: rgb(0 0 0 / 30%) 0px 12px 60px 5px !important;
		display:none;
	}

	.class-content{
		min-height: 500px;
		overflow: hidden;
	}
	
	.container{
		margin-top: 50px;
		margin-bottom: 50px;
	}
	
	.clsfrm-btn{
	background-color: rgb(159, 144, 207) !important;
	border-color: rgb(159, 144, 207) !important;
	color: #fff !important;
	}
	
	.clsfrm-btn:focus{
		box-shadow: 0 0 0 0.25rem rgb(32 13 253 / 25%) !important;
		border-color: rgb(159, 144, 207) !important;
	}
	
	.clsfrm-btn:active, .clsfrm-btn:hover{
		background-color: rgb(121 109 159) !important;
		border-color: rgb(159, 144, 207) !important;
	}
	
	.star img {
		width: 15px;
	}
	
	.review-content{
    	display: table;
    	table-layout: fixed;
	    width: 100%;
	}

	.review-content > span{
		display: table-cell;
    	overflow: hidden;
    	text-overflow: ellipsis;
    	white-space: nowrap;
	}
</style>
<script>
	$(function(){
		var prePriceComma = $(".classPrice").html();
		var postPriceComma = prePriceComma.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		$(".classPrice").html(postPriceComma);
		
		var dmRoomNo = -1;
		var dmClassNoVal = -1;
		
		//강의장 장소 보기
		$(".showLoc").click(function(){
			var classLocation1 = $("#classLocation1").html();
			var mapOptions = {
				    center: new naver.maps.LatLng(37.3595704, 127.105399),
				    zoom: 15
				};
			var map = new naver.maps.Map('map', mapOptions);
			
			naver.maps.Service.geocode({ address: classLocation1 }, function(status, response) { 
				if (status === naver.maps.Service.Status.ERROR) { 
					console.log('Something wrong!'); 
					} 
				var new_position = new naver.maps.LatLng(response.v2.addresses[0].y, response.v2.addresses[0].x) 
				map.setCenter(new_position); 
				
				var marker = new naver.maps.Marker({ 
					position: new naver.maps.LatLng(response.v2.addresses[0].y, response.v2.addresses[0].x), 
					map: map 
				}); 
			});
			
		});
		
		//리뷰 작성 버튼
		$(document).on("click", "#reviewWrite", function(){
			let classNo = $("#classNo").val();
			let memberNickname = $("#memberNickname").val();
			let reviewContent = $("#reviewContent").val();
			let reviewRate = $("#reviewRate").val();
			
			console.log(classNo);
			console.log(memberNickname);
			console.log(reviewContent);
			console.log(reviewRate);
			
			if(reviewContent == ''){
				alert("공백은 안돼요");
				return;
			}
			
			$.ajax({
				url:"/insertReview.do",
				type : "post",
				data : {classNo:classNo, memberNickname:memberNickname, reviewContent:reviewContent, reviewRate:reviewRate},
				success : function(data){
					console.log(data);
					if(data==1){
						console.log("성공!(테스트용)");
					}else if(data==0){
						console.log("실패!(테스트용)");						
					}
				//location.reload();
				$(".reviewTable").load(location.href+" .reviewTable");
				$(".writeSection").load(location.href+" .writeSection");
				$(".reviewScore").load(location.href+" .reviewScore");
				
				},
				complete : function(){
					$("#reviewContent").val("");
				}
			});
		});
		
		//리뷰 삭제 AJAX
		$(document).on("click", ".reviewDelete", function(){
			//let reviewNoParam = $(this).attr("href");
			let reviewNo = $(this).children(".deleteLinkVal").val();

			$.ajax({
				url : "/deleteReview.do",
				type : "post",
				data : {reviewNo:reviewNo},
				success : function(data){
					$(".reviewTable").load(location.href+" .reviewTable");
					$(".writeSection").load(location.href+" .writeSection");
					$(".reviewScore").load(location.href+" .reviewScore");
				}
			});
			
		});
		
		//클래스 이미 예약했을때
		$("#alreadyPayBtn").click(function(){
			alert("이미 예약한 클래스 입니다!");
		});
		
		//조리꾼은 다른 조리꾼 클래스 수강 불가능
		$(".mlv2").click(function(){
			alert("수강 불가능합니다!");
		});
	
		//리뷰 이미 작성했을때
		$(document).on("click", "#reviewAlrdy", function(){
			alert("이미 리뷰를 작성하셨습니다!");
		});
		
		//리뷰 이미 작성했을때
		$(document).on("click", "#reviewRsrv", function(){
			alert("클래스를 수강한 회원만 작성할 수 있습니다!");
		});
		
		//비회원 로그인
		$(document).on("click", "#reviewLogin", function(){
			alert("로그인 하세요!");
		});
		//강의 결제
		$("#payBtn").click(function(){
			let date = new Date();
			let classPrice = $(".classPrice").html(); //실제 가격
			let classTitle = $("#classTitle").html();
			let memberNickname = $("#clsMemberNickname").val();
			let memberNo = $("#memberNo").val();
			let classNo = $("#classNo").val();
			let classNop = $("#classNop").html();
			let impUid = date.getFullYear()+""+("0"+(date.getMonth()+1)).slice(-2)+""+("0"+date.getDate()).slice(-2)+""+("0"+date.getHours()).slice(-2)+""+("0"+date.getMinutes()).slice(-2)+""+("0"+date.getSeconds()).slice(-2);
			
			IMP.init("imp42282461"); //요리조리 가맹점
			IMP.request_pay({ //결제할 떄 필요한 정보(객체)
				merchant_uid : "상품명_"+date, //거래 아이디
				name : classTitle, //결제 이름 설정함
				amount : 100, //결제 금액 테스트용이니까 100원
				buyer_email : "forestwowch@gmail.com", //구매자 이메일
				buyer_name : "${sessionScope.m.memberName}",
				buyer_phone : "${sessionScope.m.memberPhone}", //구매자 핸드폰 번호
				buyer_addr : "${sessionScope.m.addressRoad} ${sessionScope.m.addressDetail}", //구매자 주소
				buyer_postcode : "${sessionScope.m.postcode}" //구매자 우편번호
			},function(rsp){
				if(rsp.success){
					$.ajax({
						url : "/insertCookingRsrv.do",
						type : "post",
						data : {memberNickname : memberNickname, memberNo : memberNo, classNo : classNo, impUid : impUid, classNop : classNop},
						success : function(data){
							console.log(data);
							if(data==1){
								alert("결제가 완료됐습니다!");
								location.reload();
							}else if(data==0){
								alert("인원수 초과");
								location.href="/";
							}
						}
					});
					//성공시 로직(db결제정보 insert -> 사용자 화면 처리)
					console.log("카드 승인 번호 "+rsp.apply_num);
				}else{
					console.log(impUid);
					//실패시 로직(장바구니에 저장 -> 사용자 화면 처리)
					$.ajax({
						url : "/insertCookingRsrv.do",
						type : "post",
						data : {memberNickname : memberNickname, memberNo : memberNo, classNo : classNo, impUid : impUid, classNop : classNop},
						success : function(data){
							console.log(data);
							if(data==1){
								alert("예약 성공");
								location.reload();
							}else if(data==0){
								alert("인원수 초과");
								location.href="/";
							}
						}
					});
				}
			});
		});	
		
		//문의 목록 AJAX시작 12-23 클래스뷰에서 
		$(".ajaxList, .toList").click(function(){
			dmClassNoVal = -1;
			$(".dmView").hide();
			$(".dmList").toggle();
			let dmSender = $("#memberNickname").val();
			let memberLevel = $("#memberLevel").val();
			
			$.ajax({
				url : "/dmAjaxList.do",
				type : "post",
				data : {dmSender:dmSender, memberLevel:memberLevel},
				success : function(data){
					console.log(data);
					if(data.length == 0){
						let c = "";
						c+="<h3 style='display:flex;justify-content:center;align-items: center;height: 90%;'>문의가 없습니다!</h3>";
						$(".main-screen__list").append(c);
					}else{
						$(".main-screen__list").empty();
	
						for (var i = 0; i < data.length; i++) {
							let b = "";
							b+="<a class='link'>";
							b+="<div class='user-component'>";
							b+="<div class='user-component__column'>";
							if(dmSender == data[i].dmReceiver){ //상대방이 나한테 보낸 메세지
								if(data[i].dmSpic == undefined){ //상대방 프사가 없을때 
									b+="<img class='user-component__profile_img' src='./resources/upload/member_profile/profile_basic.png'/>";								
								}else if(data[i].dmSpic != undefined){ //상대방 프사가 있을때
									b+="<img class='user-component__profile_img' src='./resources/upload/member_profile/"+data[i].dmSpic+"'/>";
								}
							}else if(dmSender == data[i].dmSender){ //내가 상대방한테 보낸 메세지
								if(data[i].dmRpic == undefined){ //상대방 프사가 없을때 
									b+="<img class='user-component__profile_img' src='./resources/upload/member_profile/profile_basic.png'/>";								
								}else if(data[i].dmRpic != undefined){ //상대방 프사가 있을때
									b+="<img class='user-component__profile_img' src='./resources/upload/member_profile/"+data[i].dmRpic+"'/>";
								}
							}
							b+="<div class='user-component__text'>";
							if(dmSender == data[i].dmSender){ //최근 메세지 보낸 사람이 나랑 같으면 상대방으로 이름만 바꿔줌
								b+="<h4 class='user-component__text-name'>"+data[i].dmReceiver+"</h4>";
							} else if(dmSender == data[i].dmReceiver){ //그게 아니면 그대로 둠
								b+="<h4 class='user-component__text-name'>"+data[i].dmSender+"</h4>";
							}
							b+="<h6 class='user-component__text-preview'>"+data[i].dmContent+"</h6>";
							b+="</div></div>";
							b+="<div class='user-component__last'>";
							b+="<span class='user-component__time'>"+data[i].dmDate.substring(11, 16)+"</span>";
							if(dmSender == data[i].dmReceiver && data[i].dmReadFlag == 0){
								if(data[i].dmCnt > 99){
									b+="<div class='dm-badge over-100'>99+</div>";									
								}else if(data[i].dmCnt > 0 && data[i].dmCnt < 100){
									b+="<div class='dm-badge from-1to99'>"+data[i].dmCnt+"</div>";								
								}
							}else{
								b+="<div class='dm-no-badge'>x</div>";							
							}
							b+="</div><input type='hidden' class='dmRoomNoChk' value="+data[i].dmRoomNo+"><input type='hidden' class='dmClassNoChk' value="+data[i].classNo+"></div></a>";
							$(".main-screen__list").append(b);
						}
						
					}
				}
			});
			
		});
		

		
		//문의 목록에서 눌렀을때 문의 채팅 내역 보는거 12-23 문의목록->해당하는 메세지
		$(document).on("click", ".user-component", function(){
				$(".dmList").hide();
				$(".dmView").toggle();
				$(".main-chat").empty();
			dmRoomNo = $(this).find(".dmRoomNoChk").val();
			dmClassNoVal = $(this).find(".dmClassNoChk").val();
			var dmSender = $("#memberNickname").val(); //로그인한 나
			console.log("문의 목록에서 클릭 방번호"+dmRoomNo);
			console.log("문의 목록에서 클릭 클래스명"+dmClassNoVal);
			
				//let dmSender = $("#memberNickname").val(); //나

				$.ajax({
					url : "/selectDmRoomNoAjax.do",
					type : "post",
					data : {dmRoomNo:dmRoomNo, dmSender:dmSender},
					success : function(data){
						console.log(data);
						for (var i = 0; i < data.length; i++) {
							if(dmSender != data[i].dmSender){
								$(".alt-header__title").html(data[i].dmSender);
								if(data[i].dmSpic == undefined){
									$(".main-chat").append("<div class='message-row'>"+
										"<img src='./resources/img/dm/classtest.jpg'/>"+
										"<div class='message-row__content'>"+
										"<span class='message__author'>"+data[i].dmSender+"</span>"+
										"<div class='message__info'>"+
						            	"<span class='message__bubble'>"+data[i].dmContent+"</span>"+
						           		"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span></div></div></div>");
								}else{
									$(".main-chat").append("<div class='message-row'>"+
										"<img src='./resources/upload/member_profile/"+data[i].dmSpic+"'/>"+
										"<div class='message-row__content'>"+
										"<span class='message__author'>"+data[i].dmSender+"</span>"+
										"<div class='message__info'>"+
						            	"<span class='message__bubble'>"+data[i].dmContent+"</span>"+
						           		"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span></div></div></div>");
								}
							}else if(dmSender == data[i].dmSender){
								$(".alt-header__title").html(data[i].dmReceiver);
								$(".main-chat").append("<div class='message-row message-row--own'>"+
										"<div class='message-row__content'>"+
										"<div class='message__info'>"+
						            	"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span>"+
						           		"<span class='message__bubble'>"+data[i].dmContent+"</span></div></div></div>");
							}
						}
						$(".main-screen").scrollTop($(".main-screen").height()+4000);
					}
				});
			});
		
		
		
		
		
		//문의하기 바로 눌렀을때 이전내용 보여줌 12-23
		$(document).on("click", ".doDm", function(){
			classNoVal = -1;
			$(".dmList").hide();
			$(".dmView").toggle();
			let dmReceiver = $(".alt-header__title").html($("#clsMemberNickname").val()); //상대방
			let dmSender = $("#memberNickname").val(); //나
			let classNo = $("#classNo").val(); //해당 클래스 번호
			console.log("dmRoomNo 번호는 과연 "+dmRoomNo);
			$(".main-chat").empty();
			
			//테스트
			classNoVal = classNo;
			console.log("문의하기 눌럿을때 : "+classNoVal);
			
			$.ajax({
				url : "/selectDmAjax.do",
				type : "post",
				data : {classNo:classNo, dmSender:dmSender, dmRoomNo:dmRoomNo },
				success : function(data){
					for (var i = 0; i < data.length; i++) {
						if(dmSender != data[i].dmSender){
							if(data[i].dmSpic == undefined){
								$(".main-chat").append("<div class='message-row'>"+
									"<img src='./resources/img/dm/classtest.jpg'/>"+
									"<div class='message-row__content'>"+
									"<span class='message__author'>"+data[i].dmSender+"</span>"+
									"<div class='message__info'>"+
					            	"<span class='message__bubble'>"+data[i].dmContent+"</span>"+
					           		"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span></div></div></div>");
							}else{
								$(".main-chat").append("<div class='message-row'>"+
									"<img src='./resources/upload/member_profile/"+data[i].dmSpic+"'/>"+
									"<div class='message-row__content'>"+
									"<span class='message__author'>"+data[i].dmSender+"</span>"+
									"<div class='message__info'>"+
					            	"<span class='message__bubble'>"+data[i].dmContent+"</span>"+
					           		"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span></div></div></div>");
							}
						}else if(dmSender == data[i].dmSender){
							$(".main-chat").append("<div class='message-row message-row--own'>"+
									"<div class='message-row__content'>"+
									"<div class='message__info'>"+
					            	"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span>"+
					           		"<span class='message__bubble'>"+data[i].dmContent+"</span></div></div></div>");
						}
					}
					$(".main-screen").scrollTop($(".main-screen").height()+4000);
				}
			});
		});
		
		

		
		//문의 글 내용 엔터키
		$(document).on("keyup", ".dmContent", function(key){
			if(key.keyCode==13){ //keyCode가 13이면 엔터키임
				sendMsg();
				$(".dmContent").val("");
			}
		});
		
		//문의글 내용 화살표 클릭하거나
		$("#message__send").click(function(){
			sendMsg();
			$(".dmContent").val("");
		});
		
		//문의 글 함수 방번호 있는거 12-23
    	function sendMsg(){
			let dmReceiver = $(".alt-header__title").html(); //상대방
			let dmSender = $("#memberNickname").val(); //나
			let classNo = $("#classNo").val(); //해당 클래스 번호
			let dmContent = $(".dmContent").val(); //문의 내용
			
			
			console.log("목록 위에 있는 닉네임 "+dmReceiver);
			console.log("나 "+dmSender);
			console.log("클래스 뷰에서 가져온 클래스번호 "+classNo);
			console.log(dmContent);
			console.log("채팅방 있을때 번호 "+dmRoomNo);
			console.log("목록에서 가져온 클래스번호 "+dmClassNoVal);
			
			//메세지 작성을 할때 필요한 것
			//1. dmReceiver, dmSender<-sessionScope.m.memberId, (classNo)로 사용할것, dmContent
			if(dmContent != ""){
				
					
				//내 클래스에서 목록 받으면 클릭했을때 숫자가 대신 받아짐 
				//
				if(classNo == $("#classNo").val() && dmClassNoVal == -1){
					classNo = classNo;
					console.log("같은 classNo :"+classNo);
					console.log("같은 dmClassNoVal :"+dmClassNoVal);
				}else{
					classNo = dmClassNoVal;
					console.log("다른 classNo :"+classNo);
					console.log("다른 dmClassNoVal :"+dmClassNoVal);
				}
				
				
				//내용 공백 아닐때
				$.ajax({
					url : "/dmSendAjax.do",
					type : "post",
					data : {classNo:classNo, dmReceiver:dmReceiver, dmSender:dmSender, dmContent:dmContent, dmRoomNo:dmRoomNo},
					success : function(data){
						if(data!=0){
							console.log("성공!(테스트용)");
							
						}else if(data==0){
							console.log("실패!(테스트용)");						
						}
						
						//$(".main-screen").load(location.href+" .main-screen");
						//location.reload();
						
						//var dmSender = $("#memberNickname").val(); //나
						//var classNo = $("#classNo").val(); //해당 클래스 번호
						
						//dm번호를 리턴 시키면 
						
						console.log("dmRoomNo이 뭔데요? "+dmRoomNo);
						dmRoomNo = data;
						console.log("세탁한 dmRoomNo은요 "+dmRoomNo);
						$.ajax({
							url : "/selectDmListAjax.do",
							type : "post",
							data : {dmRoomNo:dmRoomNo, dmSender:dmSender },
							success : function(data){
								
								$(".main-chat").empty();
								
								for (var i = 0; i < data.length; i++) {
									if(dmSender != data[i].dmSender){
										if(data[i].dmSpic == undefined){
											
											$(".main-chat").append("<div class='message-row'>"+
												"<img src='./resources/img/dm/classtest.jpg'/>"+
												"<div class='message-row__content'>"+
												"<span class='message__author'>"+data[i].dmSender+"</span>"+
												"<div class='message__info'>"+
								            	"<span class='message__bubble'>"+data[i].dmContent+"</span>"+
								           		"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span></div></div></div>");
										
										}else{
											
											$(".main-chat").append("<div class='message-row'>"+
												"<img src='./resources/upload/member_profile/"+data[i].dmSpic+"'/>"+
												"<div class='message-row__content'>"+
												"<span class='message__author'>"+data[i].dmSender+"</span>"+
												"<div class='message__info'>"+
								            	"<span class='message__bubble'>"+data[i].dmContent+"</span>"+
								           		"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span></div></div></div>");

										}
									}else if(dmSender == data[i].dmSender){
										
										$(".main-chat").append("<div class='message-row message-row--own'>"+
												"<div class='message-row__content'>"+
												"<div class='message__info'>"+
								            	"<span class='message__time'>"+data[i].dmDate.substring(11, 16)+"</span>"+
								           		"<span class='message__bubble'>"+data[i].dmContent+"</span></div></div></div>");
									
									}
								}
								$(".main-screen").scrollTop($(".main-screen").height()+4000);
							}
						});
						
						
					}
				});		
			}

    	}
		

		//빨강 버튼 누를때 숨김
		$(".screen-header_dot").click(function(){
			$(".dmList").hide();
		});
		
		$(".dot-hide").click(function(){
			$(".dmView").hide();
		});
		
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<div class="container">
		<div>
		<h1 style="margin-bottom:50px;">요리 클래스</h1>
			<div class="class-wrap">
				<div class="left position-static">
					<div class="class-content">
					<h5> ${ccls.classContent }</h5>
					<c:forEach items="${ccls.clsFileList }" var="f">
					<h1>파일 이름 : ${f.classFilepath }</h1>
						<img src="./resources/upload/cookingcls/${f.classFilepath }">
					</c:forEach>
					</div>
					<h3>후기</h3>
						<h5 class="reviewScore">평점 : ${reviewAvg }</h5>
					<div class="reviewSection">
						<c:choose>
							<c:when test="${not empty list }">
								<table class="table reviewTable" style="font-size: 14px;">
								<tr>
									<th style="width: 7%;">번호</th>
									<th style="width: 52%;">내용</th>
									<th style="width: 22%;">닉네임</th>
									<th style="width: 14%;">평점</th>
									<th style="width: 5%;"></th>
								</tr>
								<c:forEach items="${list }" var="review" varStatus="i">
								<tr>
									<td>${i.count }</td>
									<td>
										<div class="review-content">
											<span>${review.reviewContent }</span>
										</div>
									</td>
									<td>${review.memberNickname }</td>
									<td>
										<div class="star">								
										<c:choose>
											<c:when test="${review.reviewRate eq 5}">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">	
											</c:when>
											<c:when test="${review.reviewRate eq 4}">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-off.png">	
											</c:when>
											<c:when test="${review.reviewRate eq 3}">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-off.png">
												<img src="/resources/img/cookingcls/star-off.png">	
											</c:when>
											<c:when test="${review.reviewRate eq 2}">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-off.png">
												<img src="/resources/img/cookingcls/star-off.png">
												<img src="/resources/img/cookingcls/star-off.png">	
											</c:when>
											<c:when test="${review.reviewRate eq 1}">
												<img src="/resources/img/cookingcls/star-on.png">
												<img src="/resources/img/cookingcls/star-off.png">
												<img src="/resources/img/cookingcls/star-off.png">
												<img src="/resources/img/cookingcls/star-off.png">
												<img src="/resources/img/cookingcls/star-off.png">	
											</c:when>
										</c:choose>
										</div>
									</td>
									<td>	
									<c:if test="${sessionScope.m.memberNickname eq review.memberNickname }">											
										<a class="btn-close reviewDelete" style="text-indent:-9999px; display:inline-flex; width:1em; height:24px; padding:0px;">X<input type="hidden" class="deleteLinkVal" value="${review.reviewNo }"></a>
									</c:if>
									</td>
								</tr>
								</c:forEach>
							</table>
							</c:when>
							<c:otherwise>
								<table class="table reviewTable">
									<tr>
										<th style="text-align:center;">등록된 리뷰가 없어요!</th>
									</tr>
								</table>
							</c:otherwise>
						</c:choose>
						
						<table class="table table-borderless">
							<tr>
								<td colspan="2" class="col-8" style="width:71%">
									<input type="hidden" name="classNo" value="${ccls.classNo }" id="classNo">
									<input type="hidden" name="memberNickname" value="${sessionScope.m.memberNickname }" id="memberNickname">
									<input type="hidden" name="memberLevel" value="${sessionScope.m.memberLevel }" id="memberLevel">
									<input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }" id="memberNo">
									<input type="hidden" name="clsMemberNickname" value="${ccls.memberNickname }" id="clsMemberNickname">
									
									<c:choose>
										<c:when test="${ empty sessionScope.m }">
											<input type="text" id="needToLogin" class="form-control" readonly value="로그인 해주세요!">
										</c:when>
										<c:otherwise>
											<input type="text" name="reviewContent" id="reviewContent" class="form-control" maxlength="100">
										</c:otherwise>
									</c:choose>
								</td>							
								<td class="col-2" style="width:17%">
									<select class="form-select form-select-md" name="reviewRate" id="reviewRate">
										<option value="1">★☆☆☆☆</option>
										<option value="2">★★☆☆☆</option>
										<option value="3">★★★☆☆</option>
										<option value="4">★★★★☆</option>
										<option value="5">★★★★★</option>
									</select>
								</td>							
								<td class="col-2" style="width:12%">
									<div class="d-grid gap-2 writeSection">
										<c:choose>
											<c:when test="${empty sessionScope.m }">
												<button type="button" id="reviewLogin" class="btn btn-secondary btn-md">작성</button>
											</c:when>
											<c:when test="${not empty sessionScope.m and rsrvChk eq false}">
												<button type="button" id="reviewRsrv" class="btn btn-secondary btn-md">작성</button>
											</c:when>
											<c:when test="${rsrvChk eq true and reviewChk eq false}">
												<button type="button" id="reviewWrite" class="btn btn-md clsfrm-btn">작성</button>											
											</c:when>
											<c:when test="${rsrvChk eq true and reviewChk eq true}">
												<button type="button" id="reviewAlrdy" class="btn btn-secondary btn-md">작성</button>											
											</c:when>

										</c:choose>
									</div>
								</td>							
							</tr>
							
						</table>
					</div>

				</div>
				<div class="right">
					<div class="right-stick">
						<div class="right-stick-content">
							<h5>제목 : <span id="classTitle">${ccls.classTitle }</span></h5>
							<h5>클래스 강사 : ${ccls.memberNickname }<span class="vertified">정품</span></h5>
							<h5>강의 기간 : ${ccls.classStart } ~ ${ccls.classEnd }</h5>
							<h5>가격 : <span class="classPrice">${ccls.classPrice }</span>원</h5>
							<h5>강의 시간 : 
							<c:choose>
							<c:when test="${ccls.classStartTime.substring(0, 2) lt 12 }">
							오전&nbsp;${ccls.classStartTime }
							</c:when>
							<c:when test="${ccls.classStartTime.substring(0, 2) gt 11 }">
							오후
								<c:choose>
									<c:when test="${ccls.classStartTime.substring(0, 2)-12 lt 10}">
									0${ccls.classStartTime.substring(0, 2)-12}${ccls.classStartTime.substring(2, 5) }
									</c:when>
									<c:otherwise>
									${ccls.classStartTime.substring(0, 2)-12}${ccls.classStartTime.substring(2, 5) }
									</c:otherwise>
								</c:choose>
							</c:when>
							</c:choose>~
							<c:choose>
							<c:when test="${ccls.classEndTime.substring(0, 2) lt 12 }">
							오전&nbsp;${ccls.classEndTime }
							</c:when>
							<c:when test="${ccls.classEndTime.substring(0, 2) gt 11 }">
							오후
								<c:choose>
									<c:when test="${ccls.classEndTime.substring(0, 2)-12 lt 10}">
									0${ccls.classEndTime.substring(0, 2)-12}${ccls.classEndTime.substring(2, 5) }
									</c:when>
									<c:otherwise>
									${ccls.classEndTime.substring(0, 2)-12}${ccls.classEndTime.substring(2, 5) }
									</c:otherwise>
								</c:choose>
							</c:when>
							</c:choose>
							</h5>
							<h5>정원 : <span id="classCurrNop">${ccls.classCurrNop }</span>&nbsp;/&nbsp;<span id="classNop">${ccls.classNop }</span></h5>
							<c:choose>
								<c:when test="${not empty ccls.classLocation1 }">
									<h5>장소 : <span id="classLocation1">${ccls.classLocation1}</span></h5>
									<h5> ${ccls.classLocation2}</h5>
								</c:when>
								<c:otherwise>
									<h5>장소 : 비대면 클래스입니다!</h5>
								</c:otherwise>
							</c:choose>
							<div class="d-grid gap-2 mt-4">
								<c:if test="${not empty ccls.classLocation1 && not empty ccls.classLocation2}">
									<button type="button" class="btn clsfrm-btn btn-lg showLoc" data-bs-toggle="modal" data-bs-target="#exampleModal">장소보기</button>
								</c:if>
							</div>
							<div class="d-grid gap-2 mt-4">
								<c:choose>
									<c:when test="${ccls.classCurrNop eq ccls.classNop }">
										<button type="button" class="btn btn-secondary btn-lg" >마감!</button>
									</c:when>
									<c:when test="${sessionScope.m.memberNickname eq ccls.memberNickname}">
										<div class="mt-4 d-grid gap-8 d-md-flex justify-content-md-between">
											<a href="/cookingClsUpdateFrm.do?classNo=${ccls.classNo }" id="" class="btn btn-light btn-lg" >수정하기</a>
											<a href="/cookingClsDelete.do?classNo=${ccls.classNo }" class="btn btn-danger btn-lg" >삭제하기</a>							
										</div>
										<div class="d-grid gap-2 mt-2">
											<button type="button" class="btn btn-lg ajaxList clsfrm-btn">문의 확인</button>
										</div>
									</c:when>
									<c:when test="${empty sessionScope.m  }">									
										<a href="/loginFrm.do" class="btn btn-warning btn-lg" >로그인 하세요!</a>
									</c:when>
									<c:when test="${rsrvChk eq true }">
										<button type="button" id="alreadyPayBtn" class="btn btn-secondary btn-lg" >등록완료</button>									
									</c:when>
									<c:when test="${sessionScope.m.memberLevel eq 2 }">
										<button type="button" class="btn btn-secondary mlv2">수강하기</button>
									</c:when>
									<c:otherwise>
										<button type="button" id="payBtn" class="btn btn-lg clsfrm-btn" >수강하기</button>
									</c:otherwise>
								</c:choose>
							</div>
							<c:if test="${not empty sessionScope.m && ccls.memberNickname != sessionScope.m.memberNickname}">
							<div class="d-grid gap-2 mt-2">
							<!-- 
								<a href="/dmView.do?classNo=${ccls.classNo }" class="btn btn-primary btn-lg" >문의하기</a>
							 -->
							 	<c:choose>
							 		<c:when test="${sessionScope.m.memberLevel eq 2 }">
										<button type="button" class="btn btn-lg ajaxList clsfrm-btn">문의 확인</button>				 		
							 		</c:when>
								<c:when test="${sessionScope.m.memberNickname ne ccls.memberNickname && not empty sessionScope.m }">
									<a class="btn btn-lg doDm clsfrm-btn" >문의 하기</a>
									<button type="button" class="btn btn-lg ajaxList clsfrm-btn">문의 확인</button>
								</c:when>
							 	</c:choose>
							</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
    			<div class="modal-content">
      				<div class="modal-header">
        				<h5 class="modal-title" id="exampleModalLabel">클래스 장소</h5>
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      				</div>
      				<div class="modal-body" style="display:flex;justify-content: center;">
      					<div id="map" style="width:450px;height:450px;"></div>
      				</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      				</div>
    			</div>
  			</div>
		</div>
	</div>
	
	<!-- 문의 목록 시작 부분 -->
	<div class="dmList posRight">
	    <header class="screen-header">
      		<h1 class="screen-header_title">채팅</h1>
      		<div class="screen-header_icons">
        		<span><i class="fas fa-search fa-2x"></i></span>
        		<span><i class="far fa-comment-dots fa-2x"></i></span>
        		<span><i class="fas fa-music fa-2x"></i></span>
        		<span class="screen-header_setting">
            		<i class="fas fa-cog fa-2x"></i>
            		<p class="screen-header_dot"></p>
        		</span>
      		</div>
    </header>
	<!-- 불러올 부분 -->
	<main class="main-screen__list scrollBar"></main>
    <script src="https://kit.fontawesome.com/6478f529f2.js" crossorigin="anonymous"></script>
	</div>
	<!-- 문의 목록 끝남 -->
	
	<!-- 문의 답변 시작 -->
	<div class="dmView posRight">
		<div id="chat-screen" class="a-test">
			<div class="alt-header-ajax">
		      	<div class="alt-header__column">
		        	<a class="link" href="#">
		          		<i class="fas fa-chevron-left fa-1x toList"></i>
		        	</a>
		      	</div>
		      	<div class="alt-header__column">
		        <h1 class="alt-header__title"></h1>
		      	</div>
		      	<div class="alt-header__column">
		        	<a class="link" href="#">
		        		<i class="fas fa-search fa-1x"></i>
		        	</a>
		        	<a class="link" href="#">
		        		<i class="fas fa-circle dot-hide" style="color:tomato;"></i>
		        	</a>
		      	</div>
	    	</div>
	    	<div class="main-screen scrollBar">
				<div class="main-chat">
			<!-- 여기에 메세지 내용 시작 -->
			<!-- 여기에 메세지 내용 끝 -->
				</div>


	    	</div>
	    	<div class="reply">
      			<div class="reply__column"><i class="far fa-plus-square"></i></div>
      			<div class="reply__column">
        			<input type="text" placeholder="메세지를 입력해주세요" class="dmContent" maxlength="299">
        			<button type="button" id="message__send">
          			<i class="fas fa-paper-plane"></i>
        			</button>
      			</div>
    		</div>
		</div>
	</div>
	<!-- 문의 답변 끝 -->
	<script>
	
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>