<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/membership/membershipFrm.css">
<script type="text/javascript"	src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="main">
        <h1>구독권 결제</h1>
        <div class="frm">
		
        <input type="hidden" id="memberEmail" value="${sessionScope.m.memberEmail }">
            <form action="/membershipFrm.do" method="post" id="order">
            <input type="hidden" name="membershipLevel" value="${membershipLevel }">
            <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }">
            <input type="hidden" name="membershipDate" value="${membershipDate }"> 
            <input type="hidden" name="membershipPrice" value="${membershipPrice }">
             <input type="hidden" name="impNo" >
                <div class="membershipFrm">
                <label for="memberName">받으시는분</label>
            <input type="text" name="memberName" id="memberName" >
                </div>
                <div class="membershipFrm">
                    <label for="addr">주소</label>
                    <div class="post">
                    <input type="text" id="sample6_postcode"  name="postcode" placeholder="우편번호" readonly>
                    <input type="button" id="postBtn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"> <br>
                    <input type="text"  id="sample6_address" name="addressRoad" placeholder="주소" readonly>
                    <input type="text" id="sample6_detailAddress" name="addressDetail" placeholder="상세주소">
                </div>
                    </div>
                <div class="membershipFrm">
                    <label for="memberPhone">연락처</label>
                <input type="text" name="memberPhone" id="memberPhone" placeholder="010-0000-0000" >
                    </div>
                    <div class="terms">
                    <p id="check"><input type="checkbox" id="agreeCheck"> <span id="checkText">필수 개인정보 제공 동의 <img src="/resources/img/membership/down.png"></span></p>
                        <textarea readonly style="display: none;" id="termsText">
 YORIJORI에서 제공하는 상품 및 서비스를 구매하고자 할 경우, YORIJORI은 거래 당사자간 원활한 의사소통 및 배송, 상담 등 거래이행을 위하여 필요한 최소한의 개인정보를 아래와 같이 제공하고 있습니다.

1. 개인정보를 제공받는 자 : 상품 및 서비스 판매자
2. 제공하는 개인정보 항목 : 이름, 닉네임, (휴대)전화번호, 상품 구매정보, 결제수단, 상품 수령인 정보(배송상품:수령인명, 주소, (휴대)전화번호)
3. 개인정보를 제공받는 자의 이용목적 : 판매자와 구매자의 원활한 거래 진행, 본인의사의 확인, 고객상담 및 불만처리/부정이용 방지 등의 고객관리, 물품배송, 새로운 상품/서비스 정보와 고지사항의 안내, 상품/서비스 구매에 따른 혜택 제공
4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 개인정보 이용목적 달성 시까지 보존합니다. 단, 관계 법령의 규정에 의하여 일정 기간 보존이 필요한 경우에는 해당 기간만큼 보관 후 삭제합니다.
위 개인정보 제공 동의를 거부할 권리가 있으나, 거부 시 YORIJORI을 이용한 상품 구매가 불가능합니다. 그 밖의 내용은 YORIJORI의 자체 이용약관 및 개인정보처리방침에 따릅니다.</textarea>
                    </div>
               <div id="btn"><input type="button" id="submitBtn" value="결제하기"></div>
	</form>
        </div>
    </div>
    <script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
        $("#checkText").click(function(){
            $("#termsText").slideToggle("fast");
        });
        
        $("#submitBtn").click(function() {
            if($("input[name='postcode']").val() == "" || $("input[name='addressRoad']").val() =="" ||$("input[name='addressDetail']").val() =="" || $("#memberName").val()== "" || $("#memberPhone").val()==""){
                alert("빈칸없이 작성해주세요");
            }
            else if(!($("#agreeCheck").is(":checked"))){
                alert("약관에 동의해주세요");
            }else{
            	var d = new Date();
            	var date = d.getFullYear()+""+(d.getMonth()+1)+""+d.getDate()+""+d.getHours()+""+d.getMinutes()+""+d.getSeconds();
            	var memberEmail = $("#memberEmail").val();
            	var name = $("#memberName").val();
            	var phone = $("#memberPhone").val();
            	var impUid = memberEmail+"_"+date;
            	$("[name='impNo']").val(impUid)
            	IMP.init("imp82081944"); //결제api 가맹점 식별코드
    			IMP.request_pay({
    				merchant_uid : impUid, //거래아이디
    				name : "${membershipLevel} 결제", //결제 이름 설정
    				amount :"${membershipPrice}", //결제 금액
    				buyer_email : memberEmail, //구매자 이메일
    				buyer_name: name, //구매자 이름
    				buyer_phone: phone, //구매자 번호
    			},function(rsp) {
    				if(rsp.success){
    					$("#order").submit();
    				}else{
    					alert("결제실패");
    				}
    			});
            }	
		});
    </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>