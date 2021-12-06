<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <%@ include file="/resources/header/Spheader.jsp" %>
  <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet" />
  <link href="/resources/login/join.css" rel="stylesheet" />
  <title>회원가입 페이지 입니다.</title>
  <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
</head>

<body>
  <form action="/login/join" method="POST" role="form">
    <div class="v1_1583">
      <span class="v1_1597">회원가입</span>
      <input class="v1_1598" name="member_name" placeholder="성명"></input>
      <input class="v1_1599" name="member_id" placeholder="아이디"></input>
      <span class="id_input_re_1">사용 가능한 아이디입니다.</span>
      <span class="id_input_re_2">아이디가 이미 존재합니다.</span>
      <input class="v1_1600" name="member_phonenumber" placeholder="전화번호"></input>
      <input type="password" class="v1_1601" name="member_password" placeholder="비밀번호"></input>
      <input type="password" class="v1_1601-1" placeholder="비밀번호 확인"></input>
      <span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
      <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
      <input class="v1_1602" name="member_address" readonly="readonly" placeholder="우편번호"></input>
      <input class="v1_1603" name="member_address" readonly="readonly" placeholder="주소"></input>
      <input class="v1_1604" name="member_address" placeholder="상세주소"></input>
      <div class="myButton1" onclick="execution_daum_address()">우편번호 찾기</div>
      <button type="submit" class="myButton">회원가입</button>
    </div>
  </form>
  <%@ include file="/resources/footer/footer.jsp"%>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    $('.v1_1599').on("propertychange change keyup paste input", function () {
      // console.log("keyup 테스트");
      var member_id = $('.v1_1599').val(); // .id_input에 입력되는 값
      var data = {
        member_id: member_id
      } // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

      $.ajax({
        type: "post",
        url: "/login/memberIdChk",
        data: data,
        success: function (result) {
          // console.log("성공 여부" + result);
          if (result != 'fail') {
            $('.id_input_re_1').css("display", "inline-block");
            $('.id_input_re_2').css("display", "none");
          } else {
            $('.id_input_re_2').css("display", "inline-block");
            $('.id_input_re_1').css("display", "none");
          }

        } // success 종료

      }); // ajax 종료
    });

    /* 비밀번호 확인 일치 유효성 검사 */

    $('.v1_1601-1').on("propertychange change keyup paste input", function () {
      var pw = $('.v1_1601').val();
      var pwck = $('.v1_1601-1').val();

      if (pw == pwck) {
        $('.pwck_input_re_1').css('display', 'block');
        $('.pwck_input_re_2').css('display', 'none');
        pwckcorCheck = true;
      } else {
        $('.pwck_input_re_1').css('display', 'none');
        $('.pwck_input_re_2').css('display', 'block');
        pwckcorCheck = false;
      }

    });
    /* 다음 주소 연동 */
    function execution_daum_address() {

      new daum.Postcode({
        oncomplete: function (data) {
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
          if (data.userSelectedType === 'R') {
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
              extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== '' && data.apartment === 'Y') {
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraAddr !== '') {
              extraAddr = ' (' + extraAddr + ')';
            }
            // 주소변수 문자열과 참고항목 문자열 합치기
            addr += extraAddr;

          } else {
            addr += ' ';
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          $(".v1_1602").val(data.zonecode);
          //$("[name=memberAddr1]").val(data.zonecode);    // 대체가능
          $(".v1_1603 ").val(addr);
          //$("[name=memberAddr2]").val(addr);            // 대체가능
          // 커서를 상세주소 필드로 이동한다.
          $(".v1_1604").attr("readonly", false);
          $(".v1_1604").focus();

        }
      }).open();
    }
  </script>
</body>

</html>