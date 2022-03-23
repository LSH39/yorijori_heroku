<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>


#line2 {
	background-color: gray;
	height: 1px;
	width: 800px;
}

/* 메인 콘텐츠 설정 */
.main-content{
    width: 875px;
}
.orD{
     width:800px;
    height:2000px;
   
        }

.or{
    width:800px;
    height:800px;
  
}
.pay{
    width:800px;
    height:300px;
    
}
.oin{
    width:800px;
    height:300px;
   
}
.ship{
     width:800px;
    height:300px;
 

}
.extra{
    width:800px;
    height:150px;
 
}
.no{
    width:800px;
    height:150px;   
}
.ppa{
    width:800px;
    height:300px; 
    
}
.orl{
    width:800px;
    height:800px; 
    
}
#sort{
    width:100px;
    height:100px;
}
.tb2-th{
 text-align:center;

 }
 
 .tb2-tr2,.tb-tr{
 background-color: #F7F7E5;

  }
 .tb-trs{
 display:none;
  background-color: #F7F7E5;
 }
  .tt{
  text-align:center;
  background-color: skyblue;


  }
  #re{
  text-align:center;
  }
  .tb2-td{
    text-align:center;
  }
  
/*성승민 css 추가*/
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

</style>
    <script>
        $(function(){
     
        $("#clicks").click(function(){
            var idx = $("#clicks").index(this);
                 var contents = $(".tb-trs");
          
                 if($('.tb-trs').eq(idx).is(":visible")){
                    contents.eq(idx).hide();
                   
                }else{
                    contents.eq(idx).show();
                }
        });
  
    });
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
            <h3 id="h_hotel">주문내역 상세보기</h3>
            <div id="line2"></div><br>
            <div class="orD">
                <div class="or">
               
                    <table border="1" class="orl">
                   
                        <tr >
                        <th class="tt" colspan="5">주문번호:${dd.orderNo}</th>
 
                    </tr>
                   <tr class="thh">
                        <td class="tb2-td">상품이미지</td>
                        <td class="tb2-td">밀키트이름</td>
                        <td class="tb2-td">밀키트가격</td>
                        <td class="tb2-td">주문수량</td>
                        <td class="tb2-td">주문상태</td>
                    </tr>
                    <c:forEach items="${list}" var="mo" varStatus="i">
                    <tr class="tb2-tr2">
                        <td class="tb2-td"><img src="resources/upload/product/${mo.filepath}" id="sort" ></td>
                        <td class="tb2-td">${mo.milkitName}</td>
                        <td class="tb2-td">${mo.milkitPrice}원</td>
                        <td class="tb2-td">${mo.orderOptionAmount}개</td>
                       <c:choose>
                       <c:when test="${mo.status ne '배송완료' && mo.reviewNo ne -1}">
                       	<td class="tb2-td">
	                    		${mo.status}                        		
                       	</td>
                       	</c:when>
                       	<c:when test="${mo.status eq '배송완료' && mo.reviewNo eq -1}">
    	                	<td class="tb2-td">
	                    		${mo.status}                        		
                     			<div style="position:relative;">
		                    		<a href="/milkitView.do?productNo=${mo.productNo }&recipeNo=${mo.recipeNo }" style="position:absolute;top:10px;right:6%;font-size: 13px;" class="btn clsfrm-btn">리뷰 작성</a>                    		
                       			</div>
	                    	</td>
                       	</c:when>
                      	<c:otherwise>
                       	<td class="tb2-td">
	                    	${mo.status}
                       	</td>
                       	</c:otherwise>
                       	</c:choose>
                    </tr>
                  	</c:forEach>
                    
                    
                    </table>
                </div>
                <div class="pay">
                    <table border="1" class="ppa">
                   
                        <tr>
                    <th class="tb2-th" colspan="2">결제정보 </th>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">상품금액</td>
                        <td class="tb2-td">${dd.orderPrice}원</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">배송비</td>
                        <td class="tb2-td">무료배송</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">할인금액</td>
                        <td class="tb2-td">-${dd.orderSale}원</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">결제금액</td>
                        <td class="tb2-td">${dd.orderPayment}원</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">결제번호</td>
                        <td class="tb2-td">${dd.impUid}</td>
                    </tr>
               
                    </table>
                </div>
                <div class="oin">
                    <table border="1" class="ppa">
                        <tr>
                        <th class="tb2-th" colspan="2">주문정보</th>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">주문번호</td>
                        <td class="tb2-td">${dd.orderNo}</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">주문자명</td>
                        <td class="tb2-td">${dd.orderName}</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">주문자이메일</td>
                        <td class="tb2-td">${dd.orderEmail}</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">주문자 연락처</td>
                        <td class="tb2-td">${dd.orderPhone}</td>
                    </tr>
                 
                   
                    </table>
                </div>
                <div class="ship">
                    <table border="1" class="ppa">
                        <tr>
                        <th class="tb2-th" colspan="2">배송정보</th>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">받는분</td>
                        <td class="tb2-td">${dd.orderName}</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">우편번호</td>
                        <td class="tb2-td">${dd.orderPostcode}</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">도로명주소</td>
                        <td class="tb2-td">${dd.orderAddrRoad}</td>
                    </tr>
                    <tr class="tb-tr">
                        <td class="tb2-td">상세주소</td>
                        <td class="tb2-td">${dd.orderAddrDetail}</td>
                    </tr>
                 
                   
                    </table>
                </div>
                <div class="extra">
                    <table border="1" class="no">
                        <tr>
                        <th class="tb2-th">요청사항<button id="clicks">↓</button></th>
                    </tr>
                       
                    <tr class="tb-trs">
                        <td class="tb2-td" id="re">${dd.orderRequest}</td>
                    </tr>
                    
                    </table>
                     
                </div>

            </div>
               
        </div>
        
        </div>
    
 <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>