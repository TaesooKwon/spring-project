<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

  <meta charset="UTF-8">
  <title>Welcome BookMall</title>
  <link rel="stylesheet" href="/resources/css/order.css">
  <%@ include file="/resources/header/Spheader.jsp" %>
  <script
          src="https://code.jquery.com/jquery-3.4.1.js"
          integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
          crossorigin="anonymous"></script>
  <!-- 다음주소 -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>

<div class="wrapper">
  <div class="wrap">

    <div class="content_area">

      <div class="content_subject"><span>장바구니</span></div>

      <div class="content_main">
        <!-- 회원 정보 -->
        <div class="member_info_div">
          <table class="table_text_align_center memberInfo_table">
            <tbody>
            <tr>
              <th style="width: 25%;">주문자</th>
              <td style="width: *">${memberInfo.member_id} | ${memberInfo.member_email}</td>
            </tr>
            </tbody>
          </table>
        </div>

        <!-- 배송지 정보 -->
        <div class="addressInfo_div">
          <div class="addressInfo_button_div">
            <button class="address_btn address_btn_1" onclick="showAdress('1')" style="background-color: #3c3838;">상용자 정보 주소록</button>
            <button class="address_btn address_btn_2" onclick="showAdress('2')">직접 입력</button>
          </div>
          <div class="addressInfo_input_div_wrap">
            <div class="addressInfo_input_div addressInfo_input_div_1" style="display: block">
              <table>
                <colgroup>
                  <col width="25%">
                  <col width="*">
                </colgroup>
                <tbody>
                <tr>
                  <th>이름</th>
                  <td>
                    ${memberInfo.member_name}
                  </td>
                </tr>
                <tr>
                  <th>주소</th>
                  <td>
                    ${memberInfo.member_address}
                    <input class="selectAddress" value="T" type="hidden">
                    <input class="addressee_input" value="${memberInfo.member_name}" type="hidden">
                    <input class="address1_input" type="hidden" value="${memberInfo.member_address}">
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="addressInfo_input_div addressInfo_input_div_2">
              <table>
                <colgroup>
                  <col width="25%">
                  <col width="*">
                </colgroup>
                <tbody>
                <tr>
                  <th>이름</th>
                  <td>
                    <input class="addressee_input">
                  </td>
                </tr>
                <tr>
                  <th>주소</th>
                  <td>
                    <input class="selectAddress" value="F" type="hidden">
                    <input class="address1_input" readonly="readonly"> <a class="address_search_btn" onclick="execution_daum_address()">주소 찾기</a><br>
                    <input class="address2_input" readonly="readonly"><br>
                    <input class="address3_input" readonly="readonly">
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <!-- 상품 정보 -->
        <div class="orderGoods_div">
          <!-- 상품 종류 -->
          <div class="goods_kind_div">
            주문상품 <span class="goods_kind_div_kind"></span>종 <span class="goods_kind_div_count"></span>개
          </div>
          <!-- 상품 테이블 -->
          <table class="goods_subject_table">
            <colgroup>
              <col width="15%">
              <col width="45%">
              <col width="40%">
            </colgroup>
            <tbody>
            <tr>
              <th>이미지</th>
              <th>상품 정보</th>
              <th>판매가</th>
            </tr>
            </tbody>
          </table>
          <table class="goods_table">
            <colgroup>
              <col width="15%">
              <col width="45%">
              <col width="40%">
            </colgroup>
            <tbody>
            <c:forEach items="${orderList}" var="ol">
              <tr>
                <td>
                  <div class="image_wrap" data-bookid="${ol.imageList[0].id}" data-path="${ol.imageList[0].uploadPath}" data-uuid="${ol.imageList[0].uuid}" data-filename="${ol.imageList[0].fileName}">
                    <img>
                  </div>
                </td>
                <td>${ol.product_name}</td>
                <td class="goods_table_price_td">
                  <fmt:formatNumber value="${ol.salePrice}" pattern="#,### 원" /> | 수량 ${ol.productCount}개
                  <br><fmt:formatNumber value="${ol.totalPrice}" pattern="#,### 원" />
                  <br>[<fmt:formatNumber value="${ol.totalPoint}" pattern="#,### 원" />P]
                  <input type="hidden" class="individual_bookPrice_input" value="${ol.product_price}">
                  <input type="hidden" class="individual_salePrice_input" value="${ol.salePrice}">
                  <input type="hidden" class="individual_bookCount_input" value="${ol.productCount}">
                  <input type="hidden" class="individual_totalPrice_input" value="${ol.salePrice * ol.productCount}">
                  <input type="hidden" class="individual_point_input" value="${ol.point}">
                  <input type="hidden" class="individual_totalPoint_input" value="${ol.totalPoint}">
                  <input type="hidden" class="individual_bookId_input" value="${ol.id}">
                </td>
              </tr>
            </c:forEach>

            </tbody>
          </table>
        </div>

        <!-- 포인트 정보 -->
        <div class="point_div">
          <div class="point_div_subject">포인트 사용</div>
          <table class="point_table">
            <colgroup>
              <col width="25%">
              <col width="*">
            </colgroup>
            <tbody>
            <tr>
              <th>포인트 사용</th>
              <td>
                ${memberInfo.point} | <input class="order_point_input" value="0">원
                <a class="order_point_input_btn order_point_input_btn_N" data-state="N">모두사용</a>
                <a class="order_point_input_btn order_point_input_btn_Y" data-state="Y" style="display: none;">사용취소</a>

              </td>
            </tr>
            </tbody>
          </table>
        </div>
        <!-- 주문 종합 정보 -->
        <div class="total_info_div">
          <!-- 가격 종합 정보 -->
          <div class="total_info_price_div">
            <ul>
              <li>
                <span class="price_span_label">상품 금액</span>
                <span class="totalPrice_span">100000</span>원
              </li>
              <li>
                <span class="price_span_label">배송비</span>
                <span class="delivery_price_span">100000</span>원
              </li>
              <li>
                <span class="price_span_label">할인금액</span>
                <span class="usePoint_span">100000</span>원
              </li>
              <li class="price_total_li">
                <strong class="price_span_label total_price_label">최종 결제 금액</strong>
                <strong class="strong_red">
									<span class="total_price_red finalTotalPrice_span">
										1500000
									</span>원
                </strong>
              </li>
              <li class="point_li">
                <span class="price_span_label">적립예정 포인트</span>
                <span class="totalPoint_span">7960원</span>
              </li>
            </ul>
          </div>
          <!-- 버튼 영역 -->
          <div class="total_info_btn_div">
            <a class="order_btn">결제하기</a>
          </div>
        </div>

      </div>

      <!-- 주문 요청 form -->
      <form class="order_form" action="/order" method="post">
        <!-- 주문자 회원번호 -->
        <input name="member_id" value="${memberInfo.member_id}" type="hidden">
        <input name="address"  type="hidden">
        <!-- 주소록 & 받는이-->
        <input name="member_address" type="hidden">
        <!-- 사용 포인트 -->
        <input name="usePoint" type="hidden">
        <!-- 상품 정보 -->
      </form>
    </div>
  </div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->
<%@ include file="/resources/footer/footer.jsp"%>
<script>

  $(document).ready(function(){

    /* 주문 조합정보란 최신화 */
    setTotalInfo();

    /* 이미지 삽입 */
    $(".image_wrap").each(function(i, obj){

      const bobj = $(obj);

      if(bobj.data("bookid")){
        const uploadPath = bobj.data("path");
        const uuid = bobj.data("uuid");
        const fileName = bobj.data("filename");

        const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);

        $(this).find("img").attr('src', '/product/display?fileName=' + fileCallPath);
      } else {
        $(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
      }

    });


  });


  /* 주소입력란 버튼 동작(숨김, 등장) */
  function showAdress(className){
    /* 컨텐츠 동작 */
    /* 모두 숨기기 */
    $(".addressInfo_input_div").css('display', 'none');
    /* 컨텐츠 보이기 */
    $(".addressInfo_input_div_" + className).css('display', 'block');

    /* 버튼 색상 변경 */
    /* 모든 색상 동일 */
    $(".address_btn").css('backgroundColor', '#555');
    /* 지정 색상 변경 */
    $(".address_btn_"+className).css('backgroundColor', '#3c3838');
    /* selectAddress T/F */
    /* 모든 selectAddress F만들기 */
    $(".addressInfo_input_div").each(function(i, obj){
      $(obj).find(".selectAddress").val("F");
    });
    /* 선택한 selectAdress T만들기 */
    $(".addressInfo_input_div_" + className).find(".selectAddress").val("T");

  }

  /* 다음 주소 연동 */
  function execution_daum_address(){
    console.log("동작");
    new daum.Postcode({
      oncomplete: function(data) {
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.

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

        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
        if(data.userSelectedType === 'R'){
          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            addr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if(data.buildingName !== '' && data.apartment === 'Y'){
            addr += (addr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          if(addr !== ''){
            addr = ' (' + addr + ')';
          }
          // 추가해야할 코드
          // 주소변수 문자열과 참고항목 문자열 합치기
          addr += extraAddr;

        } else {
          addr += ' ';
        }

        // 제거해야할 코드
        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        $(".address1_input").val(data.zonecode+addr)
        $(".address2_input").val(addr);
        // 커서를 상세주소 필드로 이동한다.
        $(".address3_input").attr("readonly", false);
        $(".address3_input").focus();

      }
    }).open();

  }


  /* 포인트 입력 */
  //0 이상 & 최대 포인트 수 이하
  $(".order_point_input").on("propertychange change keyup paste input", function(){

    const maxPoint = parseInt('${memberInfo.point}');

    let inputValue = parseInt($(this).val());

    if(inputValue < 0){
      $(this).val(0);
    } else if(inputValue > maxPoint){
      $(this).val(maxPoint);
    }

    /* 주문 조합정보란 최신화 */
    setTotalInfo();

  });


  /* 포인트 모두사용 취소 버튼
   * Y: 모두사용 상태 / N : 모두 취소 상태
   */
  $(".order_point_input_btn").on("click", function(){

    const maxPoint = parseInt('${memberInfo.point}');

    let state = $(this).data("state");

    if(state == 'N'){
      console.log("n동작");
      /* 모두사용 */
      //값 변경
      $(".order_point_input").val(maxPoint);
      //글 변경
      $(".order_point_input_btn_Y").css("display", "inline-block");
      $(".order_point_input_btn_N").css("display", "none");
    } else if(state == 'Y'){
      console.log("y동작");
      /* 취소 */
      //값 변경
      $(".order_point_input").val(0);
      //글 변경
      $(".order_point_input_btn_Y").css("display", "none");
      $(".order_point_input_btn_N").css("display", "inline-block");
    }

    /* 주문 조합정보란 최신화 */
    setTotalInfo();

  });


  /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
  function setTotalInfo(){

    let totalPrice = 0;				// 총 가격
    let totalCount = 0;				// 총 갯수
    let totalKind = 0;				// 총 종류
    let totalPoint = 0;				// 총 마일리지
    let deliveryPrice = 0;			// 배송비
    let usePoint = 0;				// 사용 포인트(할인가격)
    let finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)

    $(".goods_table_price_td").each(function(index, element){
      // 총 가격
      totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
      // 총 갯수
      totalCount += parseInt($(element).find(".individual_bookCount_input").val());
      // 총 종류
      totalKind += 1;
      // 총 마일리지
      totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
    });

    /* 배송비 결정 */
    if(totalPrice >= 30000){
      deliveryPrice = 0;
    } else if(totalPrice == 0){
      deliveryPrice = 0;
    } else {
      deliveryPrice = 3000;
    }

    /* 사용 포인트 */
    usePoint = $(".order_point_input").val();

    finalTotalPrice = totalPrice - usePoint;

    /* 값 삽입 */
    // 총 가격
    $(".totalPrice_span").text(totalPrice.toLocaleString());
    // 총 갯수
    $(".goods_kind_div_count").text(totalCount);
    // 총 종류
    $(".goods_kind_div_kind").text(totalKind);
    // 총 마일리지
    $(".totalPoint_span").text(totalPoint.toLocaleString());
    // 배송비
    $(".delivery_price_span").text(deliveryPrice.toLocaleString());
    // 최종 가격(총 가격 + 배송비)
    finalTotalPrice = totalPrice + deliveryPrice;
    $(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
    // 할인가(사용 포인트)
    $(".usePoint_span").text(usePoint.toLocaleString());

    return finalTotalPrice
  }

  /* 주문 요청 */
  $(".order_btn").on("click", function(){

    payment();



  });


function payment(){
  var IMP = window.IMP; // 생략가능
  IMP.init('iamport');
// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
  IMP.request_pay({
    pg: 'inicis', // version 1.1.0부터 지원.
    /*
    'kakao':카카오페이,
    html5_inicis':이니시스(웹표준결제)
    'nice':나이스페이
    'jtnet':제이티넷
    'uplus':LG유플러스
    'danal':다날
    'payco':페이코
    'syrup':시럽페이
    'paypal':페이팔
    */
    pay_method: 'card',
    /*
    'samsung':삼성페이,
    'card':신용카드,
    'trans':실시간계좌이체,
    'vbank':가상계좌,
    'phone':휴대폰소액결제
    */
    merchant_uid: 'merchant_' + new Date().getTime(),
    /*
    merchant_uid에 경우
    https://docs.iamport.kr/implementation/payment
    위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
    참고하세요.
    나중에 포스팅 해볼게요.
    */
    name: '주문명:결제테스트',
//결제창에서 보여질 이름
    amount: setTotalInfo(),
//가격
    buyer_email: 'iamport@siot.do',
    buyer_name: '구매자이름',
    buyer_tel: '010-1234-5678',
    buyer_addr: '서울특별시 강남구 삼성동',
    buyer_postcode: '123-456',
    m_redirect_url: 'https://www.yourdomain.com/payments/complete'
    /*
    모바일 결제시,
    결제가 끝나고 랜딩되는 URL을 지정
    (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
    */
  }, function (rsp) {
    console.log(rsp);
    if (rsp.success) {
      var msg = '결제가 완료되었습니다.';
      msg += '고유ID : ' + rsp.imp_uid;
      msg += '상점 거래ID : ' + rsp.merchant_uid;
      msg += '결제 금액 : ' + rsp.paid_amount;
      msg += '카드 승인번호 : ' + rsp.apply_num;

      /* 주소 정보 & 받는이*/

      $(".addressInfo_input_div").each(function(i, obj){
        if($(obj).find(".selectAddress").val() === 'T'){
          let address = ''+$(obj).find(".addressee_input").val()
          $("input[name='address']").val(address);
          $("input[name='member_address']").val($(obj).find(".address1_input").val()+","+$(obj).find(".address3_input").val());
        }
      });

      /* 사용 포인트 */
      $("input[name='usePoint']").val($(".order_point_input").val());

      /* 상품정보 */
      let form_contents = '';
      $(".goods_table_price_td").each(function(index, element){
        let Product_Id = $(element).find(".individual_bookId_input").val();
        let Product_Id_input = "<input name='orders[" + index + "].Product_Id' type='hidden' value='" + Product_Id + "'>";
        form_contents += Product_Id_input;

        let Product_Count = parseInt($(element).find(".individual_bookCount_input").val());
        let Product_Count_input = "<input name='orders[" + index + "].Product_Count' type='hidden' value='" + Product_Count + "'>";
        form_contents += Product_Count_input;

        let totalPrice = parseInt($(element).find(".individual_totalPrice_input").val());
        let totalPrice_input = "<input name='orders[" + index + "].totalPrice' type='hidden' value='" + totalPrice + "'>";
        form_contents += totalPrice_input;

        let Product_Price = parseInt($(element).find(".individual_bookPrice_input").val());
        let Product_Price_input = "<input name='orders[" + index + "].Product_Price' type='hidden' value='" + Product_Price + "'>";
        form_contents += Product_Price_input;


      });


      $(".order_form").append(form_contents);


      /* 서버 전송 */
      $(".order_form").submit();

    } else {
      var msg = '결제에 실패하였습니다.';
      msg += '에러내용 : ' + rsp.error_msg;


    }
    alert(msg);
});
}
</script>

</body>
</html>