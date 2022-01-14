<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>상세 페이지</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous">
    </script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script>
    //리뷰 리스트
    function reviewList(){
        var id = ${detail.id};
        console.log(${detail.id})
        $.getJSON("/reviews/detail/reviewList"+"?id=" + id, function (data){
            var str ="";

            $(data).each(function (){
                console.log(data);

                var review_date = new Date(this.review_date)
                review_date = review_date.toLocaleTimeString("ko-US")
                str += "<li data-reivew_num='" + this.review_num + "'>"
                    +"<div class='userInfo'>"
                    +"<span class='review_replyer'>" + this.review_replyer + "</span>"
                    +"<span class = 'date'>" + review_date +"</span>"
                    +"</div>"
                    +"<div class = 'review_content'>"+this.review_content+"</div>"
                    +"<c:if test='${member != null}'>"
                    +"<div class = 'reviewFooter'>"
                    +"<button type='button' class='update' date-id='" + this.product_id +"'>수정하기</button>"
                    +"<button type='button' class='delete' date-id='" + this.product_id +"'>삭제하기</button>"
                    +"</div>"
                    +"</c:if>"
                    +"</li>";
            });
            console.log(str)
            $(".reviewList ol").html(str);
        })
    }
</script>
    <style>
        div.reviewModal { position:relative; z-index:1; display: none;}
        div.modalBackground { position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0, 0, 0, 0.8); z-index:-1; }
        div.modal { position:fixed; top:20%; left:calc(50% - 250px); width:500px; height:250px; padding:20px 10px; background:#fff; border:2px solid #666; }
        div.modal textarea { font-size:16px; font-family:'맑은 고딕', verdana; padding:10px; width:500px; height:200px; }
        div.modal button { font-size:20px; padding:5px 10px; margin:10px 0; background:#fff; border:1px solid #ccc; }
        div.modal button.cancel_btn { margin-left:20px; }
    </style>
</head>
<body>
    <header>
        <%@ include file="/resources/header/Spheader.jsp"%>
    </header>
    <section>
        <div class="line">
        </div>
        <div class="price">
            <div class="sale_price">가격 : <fmt:formatNumber value="${detail.product_price}" pattern="#,### 원" /></div>
        </div>
        <div class="line">
        </div>
        <div class="button">
            <div class="button_quantity">
                주문수량
                <input type="text" class="quantity_input" value="1">
                <span>
								<button class="plus_btn">+</button>
								<button class="minus_btn">-</button>
							</span>
            </div>
            <div class="button_set">
                <a class="btn_cart">장바구니 담기</a>
                <button class="btn_buy">바로구매</button>
            </div>
        </div>

        <div id="review">
            <c:if test="${member==null}">
                <p>로그인을 해주세요</p>
            </c:if>
            <c:if test="${member != null}">
                <div class="reviewForm">
                    <form role="form" method="post" autocomplete="off">
                        <input type="hidden" name="product_id" id="product_id" value="${detail.id}">

                        <div class="input">
                            <textarea name="reviewContent" id="reviewContent"></textarea>
                        </div>
                        <div class="input">
                            <button type="submit" id="review_btn">리뷰 작성하기</button>
                        </div>
                    </form>
                </div>
            </c:if>

            <div class="reviewList">
                <ol>

                </ol>
                <script>
                    reviewList();
                </script>
            </div>

            <div class="reviewModal">
                <div class="modal">
                    <div>
                        <textarea class="modal_review_content" name="modal_review_content"></textarea>
                    </div>
                    <div>
                        <button type="button" class="update_btn">수정</button>
                        <button type="button" class="cancel_btn">취소</button>
                    </div>
                </div>
                <div class="modalBackground"></div>
            </div>
            <script>
                $(document).on("click",".update",function () {
                    $(".reviewModal").attr("style", "display:block;");
                })
            </script>
        </div>

    </section>
    <footer>
        <%@ include file="/resources/footer/footer.jsp"%>
    </footer>
    <script>

            //update review
            $(document).on("click",".update",function (){

                $(".reviewModal").fadeIn(200);
                var reviewNum = $(this).attr("date-review_num");
                console.log("수정 클릭")
                var reviewContent = $(this).parent().parent().children(".review_content").text();
                $(".modal_review_content").val(reviewContent);
                $(".update_btn").attr("data-review_num",reviewNum);
            });

            $(document).on("click",".cancel_btn",function (){
              $(".reviewModal").fadeOut(200);
            })

            //delete review
            $(document).on("click",".delete",function (){
                var confirm = confirm("정말로 삭제하시겠습니까?")
                if(confirm){
                    var data = {product_id: $(this).attr("data-id")};
                    $.ajax({
                        url : "/reviews/detail/deleteReview",
                        type : "post",
                        data : data,
                        success : function (result){
                            if(result==0) {
                                alert("작성자 본인만 할 수 있습니다.")
                            }else{
                                reviewList();
                            }
                        },//success
                        error : function (){
                            alert("로그인 해주세요")
                        }
                    })//ajax
                }
            })
            $(".update_btn").click(function (){
                var updateConfirm = confirm("정말로 수정하시겠습니까?")
                if(updateConfirm){
                    var data ={
                        product_id :$(this).attr("data-review_num"),
                        review_content: $(".modal_review_content").val()
                    };
                    $.ajax({
                        url:"/reviews/detail/updateReview",
                        type : "post",
                        data : data,
                        success : function (result){
                            if(result==0) {
                                alert("작성자 본인만 할 수 있습니다.")
                            }else{
                                reviewList();
                                $(".reviewModal").fadeOut(200);
                            }
                        },
                        error : function (){
                            alert("로그인 해주세요")
                        }
                    })
                }
            })

            // insert review
            $(document).on("click","#review_btn",function (){
                <%--var form =${".reviewForm form[role='form']"};--%>
                var product_id = $("product_id").val();
                var review_content = $("#reviewContent").val();

                var data = {
                    product_id : product_id,
                    review_content : review_content
                };
                $.ajax({
                    url : "/reviews/detail/insertReview",
                    type: "post",
                    data : data,
                    success : function(){
                        reviewList();
                        $("#reviewContent").val("")
                    }
                });
            });

            //구매 수량
            let quantity = $(".quantity_input").val();
            $(".plus_btn").on("click", function(){
                $(".quantity_input").val(++quantity);
            });
            $(".minus_btn").on("click", function(){
                if(quantity > 1){
                    $(".quantity_input").val(--quantity);
                }
            });

            //결제
            $(document).ready(function(){



                var IMP = window.IMP;
                var code = "imp76854798"; //가맹점 식별코드

                IMP.init(code);

                $(".btn_buy").click(function(e){
                    //결제요청
                    IMP.request_pay({
                        //name과 amout만있어도 결제 진행가능
                        //pg : 'kakao', //pg사 선택 (kakao, kakaopay 둘다 가능)
                        pg : 'html5_inicis',
                        pay_method : 'card',
                        merchant_uid : 'merchant_' + new Date().getTime(),
                        name : '${detail.product_name}',
                        amount : '${detail.product_price}',
                        buyer_email : 'iamport@siot.do',
                        buyer_name : '구매자',
                        buyer_tel : '010-1234-5678',
                        buyer_addr : '서울특별시 강남구 삼성동',
                        buyer_postcode : '123-456',//필수항목
                        m_redirect_url : 'http://localhost:8001/detail/detail?id='+'${detail.product_id}'
                    }, function(rsp){
                        if(rsp.success){//결제 성공시
                            var msg = '결제가 완료되었습니다';
                            var result = {
                                "imp_uid" : rsp.imp_uid,
                                "merchant_uid" : rsp.merchant_uid,
                                "biz_email" : rsp.buyer_email,
                                "pay_date" : new Date().getTime(),
                                "amount" : rsp.amount,
                                "card_no" : rsp.card_no,
                                "refund" : 'payed'
                            }
                            console.log("결제성공 " + msg);
                            $.ajax({
                                url : '/samsam/insertPayCoupon.do',
                                type :'POST',
                                data : JSON.stringify(result,
                                    ['imp_uid', 'merchant_uid', 'biz_email',
                                        'pay_date', 'amount', 'card_no', 'refund']),
                                contentType:'application/json;charset=utf-8',
                                dataType: 'json', //서버에서 보내줄 데이터 타입
                                success: function(res){

                                    if(res == 1){
                                        console.log("추가성공");
                                        pay += 5;
                                        $('#pay_coupon').html(pay);
                                    }else{
                                        console.log("Insert Fail!!!");
                                    }
                                },
                                error:function(){
                                    console.log("Insert ajax 통신 실패!!!");
                                }
                            }) //ajax

                        }
                        else{//결제 실패시
                            var msg = '결제에 실패했습니다';
                            msg += '에러 : ' + rsp.error_msg
                        }
                        console.log(msg);
                    })//pay
                })
            })//check1 클릭 이벤트
    </script>
</body>


</html>

