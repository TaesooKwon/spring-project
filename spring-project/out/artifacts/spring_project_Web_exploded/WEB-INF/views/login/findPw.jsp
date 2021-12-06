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
  <link href="/resources/login/findPw.css" rel="stylesheet" />
  <title>비밀번호 찾기 페이지 입니다.</title>
  <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
</head>

<body>
  <div class="v1_1583">
    <span class="v1_1597">비밀번호 찾기</span>
    <input class="v1_1599" name="member_name" placeholder="성명"></input>
    <input class="v1_1600" name="member_id" placeholder="아이디"></input>
    <input class="v1_1601" name="member_phonenumber" placeholder="전화번호"></input>
    <span class="res-success"></span>
    <span class="res-fail"></span>
    <span class="myButton">비밀번호 찾기</span>
    <a href="login" class="myButton1">로그인하러 가기</a>

  </div>
  <%@ include file="/resources/footer/footer.jsp"%>
  <script>
    $('.myButton').on("click", function () {
      // console.log("keyup 테스트");
      var member_name = $('.v1_1599').val(); // .id_input에 입력되는 값
      var member_id = $('.v1_1600').val()
      var member_phonenumber = $('.v1_1601').val()
      var data = {
        member_name: member_name,
        member_id: member_id,
        member_phonenumber: member_phonenumber
      } // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

      $.ajax({
        type: "post",
        url: "/login/findPw",
        data: data,
        success: function (result) {
          console.log("성공 여부" + result);
          if (result != 'fail') {
            $('.res-success').css({
              "color": "green",
              "position": "relative",
              "top": "515px",
              "font-size": "30px",
              "left": "43%"
            }).text("조회된 비밀번호 :" + result);
            $('.res-fail').css("display", "none");
          } else {
            $('.res-fail').css({
              "color": "black",
              "position": "relative",
              "top": "515px",
              "font-size": "30px",
              "left": "38%"
            }).text("입력하신 정보로 조회된 비밀번호가 없습니다.");
            $('.res-success').css("display", "none");
          }

        } // success 종료

      }); // ajax 종료
    });
  </script>
</body>

</html>