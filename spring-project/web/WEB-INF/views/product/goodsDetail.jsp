<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NEOTREE</title>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/resources/css/goodsDetail.css">
    <link
            rel="stylesheet"
            href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
            integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc"
            crossorigin="anonymous"
    />

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
<%@ include file="/resources/header/Spheader.jsp"%>
<div class="wrapper">
    <div class="image_wrap" data-id="${goodsInfo.imageList[0].id}" data-path="${goodsInfo.imageList[0].uploadPath}" data-uuid="${goodsInfo.imageList[0].uuid}" data-filename="${goodsInfo.imageList[0].fileName}">
        <img>
    </div>
    <div class="product-Wrap">
        <div class="product-title">${goodsInfo.product_name}</div>
        <div class="sale_price"><fmt:formatNumber value="${goodsInfo.product_price}" pattern="#,### 원" /></div>
        <div class="deliveryAndPoint"><i class="fas fa-archive"></i>  현재 주문 시 마일리지 5%적립중!</div>
        <div class="price-info">
            <div class="button_quantity">
                주문수량
                <span class="numberButton">
                <button class="minus_btn">-</button>
                <input type="text" class="quantity_input" value="1">
								<button class="plus_btn">+</button>
                </span>
            </div>

            <div class="discount-price">판매가 :  <span class="discount_price_number"><fmt:formatNumber value="${goodsInfo.product_price - (goodsInfo.product_price*goodsInfo.product_discount)}" pattern="#,### 원" /></span>
                <span class="discount_price_number_2"> [<fmt:formatNumber value="${goodsInfo.product_discount*100}" pattern="###" />%
                <fmt:formatNumber value="${goodsInfo.product_price*goodsInfo.product_discount}" pattern="#,### 원" /> 할인]</span>
            </div>
        </div>
        <div class="button_set">
            <a class="btn_cart">장바구니 담기</a>
            <a class="btn_buy">바로구매</a>
        </div>
    </div>
    <div class="product_detail">DETAILS</div>
    <div class="detail_down">
        <div class="book_intro">
            ${goodsInfo.product_intro}
        </div>
    </div>

    <div class="review_line">REVIEWS</div>

        <div class="review">
            <c:if test="${signedUser==null}">
                <p>로그인을 해주세요</p>
            </c:if>
            <c:if test="${signedUser != null}">
                <div class="reviewForm">
                    <span class="review_text">상품평을 남겨주세요</span><br>
                    <form role="form" method="post" autocomplete="off">
                        <input type="hidden" name="product_id" id="product_id" value="${goodsInfo.id}">
                        <input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}">
                        <input type="hidden" name="amount" id="amount" value="${cri.amount}">
                        <input type="hidden" name="keyword" id="keyword" value="${cri.keyword}">
                        <input type="hidden" name="type" id="type" value="${cri.type}">
                        <div class="input">
                            <textarea name="reviewContent" id="reviewContent"></textarea>
                        </div>
                        <div class="input">
                            <button type="button" id="review_btn">리뷰 작성하기</button>
                        </div>
                    </form>
                </div>
            </c:if>
        </div>

        <%--        <textarea class="review_content"></textarea>--%>
        <%--        <a class="review_register">등록</a>--%>
    <div class="review_reply">

        <div class="reviewList">
            <ol>

            </ol>

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
        <div class="review-paging"></div>
    </div>
    <%--    <div class="review">--%>
    <%--        <c:if test="${signedUser==null}">--%>
    <%--            <p>로그인을 해주세요</p>--%>
    <%--        </c:if>--%>
    <%--        <c:if test="${signedUser != null}">--%>
    <%--            <div class="reviewForm">--%>
    <%--                <form role="form" method="post" autocomplete="off">--%>
    <%--                    <input type="hidden" name="product_id" id="product_id" value="${goodsInfo.id}">--%>
    <%--                    <input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}">--%>
    <%--                    <input type="hidden" name="amount" id="amount" value="${cri.amount}">--%>
    <%--                    <input type="hidden" name="keyword" id="keyword" value="${cri.keyword}">--%>
    <%--                    <input type="hidden" name="type" id="type" value="${cri.type}">--%>
    <%--                    <div class="input">--%>
    <%--                        <textarea name="reviewContent" id="reviewContent"></textarea>--%>
    <%--                    </div>--%>
    <%--                    <div class="input">--%>
    <%--                        <button type="button" id="review_btn">리뷰 작성하기</button>--%>
    <%--                    </div>--%>
    <%--                </form>--%>
    <%--            </div>--%>
    <%--        </c:if>--%>

    <%--        <div class="reviewList">--%>
    <%--            <ol>--%>

    <%--            </ol>--%>

    <%--        </div>--%>

    <%--        <div class="reviewModal">--%>
    <%--            <div class="modal">--%>
    <%--                <div>--%>
    <%--                    <textarea class="modal_review_content" name="modal_review_content"></textarea>--%>
    <%--                </div>--%>
    <%--                <div>--%>
    <%--                    <button type="button" class="update_btn">수정</button>--%>
    <%--                    <button type="button" class="cancel_btn">취소</button>--%>
    <%--                </div>--%>
    <%--            </div>--%>
    <%--            <div class="modalBackground"></div>--%>
    <%--        </div>--%>
    <%--        <div class="review-paging"></div>--%>
    <%--    </div>--%>
</div>
</div>
<script type="text/javascript" src="/resources/js/review.js"></script>
<!-- 주문 form -->
<form action="/order/${member.member_id}" method="get" class="order_form">
    <input type="hidden" name="orders[0].id" value="${goodsInfo.id}">
    <input type="hidden" name="orders[0].Product_Count" value="">
</form>
</div>
</div><!-- class="wrapper" -->
<%@ include file="/resources/footer/footer.jsp"%>
<script>
    $(document).ready(function(){

        var product_id = "<c:out value='${goodsInfo.id}'/>"
        console.log(product_id)
        showList(1)
        function showList(page){
            reviewService.getListPaging({product_id: product_id ,page: page || 1},
                (reviewCnt,list)=>{
                    console.log("리뷰 갯수 " + reviewCnt)
                    console.log("리뷰 : " + list)
                    console.log("page 9: " + page)
                    if(page==-1){
                        pageNum=Math.ceil(reviewCnt/5.0)
                        console.log("pageNum : " +  pageNum)
                        showList(pageNum);
                        return;
                    }
                    var str =''
                    if(list==null || list.length==0){
                        $(".reviewList ol").html('');
                        return
                    }
                    for(var i =0, len = list.length || 0; i<len; i++){
                        console.log(list[i].review_num)
                        str += "<li data-review_num='" + list[i].review_num + "'>"
                            +"<div class='userInfo'>"
                            +"<span class='review_replyer'>" + list[i].member_id + "</span>"
                            // +"<span class = 'date'>" + list[i].review_date +"</span>"
                            +"</div>"
                            +"<div class = 'review_content'>"+list[i].review_content+"</div>"
                            +"<c:if test='${signedUser != null}'>"
                            +"<div class = 'reviewFooter'>"
                            +"<button type='button' class='updateBtn' id='updateBtn' data-review_num='" + list[i].review_num +"'>수정하기</button>"
                            +"<button type='button' class='deleteBtn' id='deleteBtn' data-review_num='" + list[i].review_num +"'>삭제하기</button>"
                            +"</div>"
                            +"</c:if>"
                            +"</li>";
                    }//for
                    $(".reviewList ol").html(str);
                    console.log(str);
                    showReviewPage(reviewCnt);
                });
        };
        var pageNum = 1;
        var reviewPaging =$(".review-paging")
        function showReviewPage(reviewCnt){//페이지 계산함수 정의
            console.log(reviewCnt + "showReviewPage!!!!!!!!!!!!!!!!!!!!")
            var endNum = Math.ceil(pageNum/5.0) * 5;
            var startNum = endNum -4;
            var prev = startNum != 1;
            var next = false;
            console.log("endNum = " + endNum)
            console.log("startNum = " + startNum)
            console.log("prev = " + prev)
            console.log("next = " + next)


            if(endNum *5>= reviewCnt){
                endNum = Math.ceil(reviewCnt/5.0);
            }
            console.log("endNum2 = " + endNum)
            if(endNum*5<reviewCnt) {
                next =true;
            }
            console.log("next = " + next)
            var str = "<ul class='pagination pull-right'>";
            if(prev){
                str+= "<li class='page-item'><a class='page-link' href='" +
                    (startNum-1) +"'>이전 페이지</a></li>";
            }
            for (var i = startNum; i <= endNum; i++) {
                var active = pageNum == i ? "active" : "";
                str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
            }
            if(next){
                str+= "<li class='page-item'><a class='page-link' href='" +
                    (endNum+1) +"'>다음 페이지</a></li>";
            }
            str+= "</ul></div>";
            console.log(str);
            reviewPaging.html(str);

        }

        //review update
        $(document).on("click",".updateBtn",function (){
            $(".reviewModal").attr("style", "display:block;");
            $(".reviewModal").fadeIn(200);
            var reviewNum = $(this).attr("data-review_num");
            console.log("수정 클릭")
            console.log(reviewNum)
            var reviewContent = $(this).parent().parent().children(".review_content").text();
            console.log(reviewContent)
            $(".modal_review_content").val(reviewContent);
            $(".update_btn").attr("data-review_num",reviewNum);
        })
        $(".cancel_btn").on("click",function (){
            $(".reviewModal").fadeOut(200);
        })


        $(".update_btn").on("click",function (){
            var updateConfirm = confirm("정말로 수정하시겠습니까?")
            if(updateConfirm){
                console.log($(this).attr("data-review_num"));
                var data ={
                    review_num :$(this).attr("data-review_num"),
                    review_content: $(".modal_review_content").val()
                };
                console.log(data)
                $.ajax({
                    url:"/reviews/detail/updateReview",
                    type : "post",
                    data : data,
                    success :  (result)=>{
                        console.log("update result ===================== "+result)
                        if(result==0) {
                            alert("작성자 본인만 할 수 있습니다.")
                        }else{
                            showList(1);
                            $(".reviewModal").fadeOut(200);
                        }
                    },
                    error : function (){
                        alert("로그인 해주세요")
                    }
                })
            }
        })



        $(".review-paging").on("click", "li a", function (e){
            e.preventDefault();
            console.log("click review-paging")
            var targetPageNum = $(this).attr("href");
            console.log("targetPageNum : " + targetPageNum)
            pageNum = targetPageNum;
            showList(pageNum);
        });




        //review delete
        $(document).on("click",".deleteBtn",function (){
            var deleteConfirm = confirm("정말로 삭제하시겠습니까?")
            if(deleteConfirm){
                var data = {review_num: $(this).attr("data-review_num")};
                $.ajax({
                    url : "/reviews/detail/deleteReview",
                    type : "post",
                    data : data,
                    success : function (result){
                        console.log(result)
                        if(result==0) {
                            alert("작성자 본인만 할 수 있습니다.")
                        }else{
                            showList(1)
                        }
                    },//success
                    error : function (){
                        alert("로그인 해주세요")
                    }
                })//ajax
            }
        })


        //review insert
        $("#review_btn").on("click",function (){

            var product_id = $("#product_id").val();
            var review_content = $("#reviewContent").val();
            console.log(review_content)
            console.log(product_id)
            var data = {
                product_id : product_id,
                review_content : review_content
            };
            $.ajax({
                url : "/reviews/detail/insertReview",
                type: "post",
                data : data,
                success : function(){
                    showList(1);
                    $("#reviewContent").val("")
                }
            });
        })



        /* 이미지 삽입 */
        const bobj = $(".image_wrap");

        if(bobj.data("id")){
            const uploadPath = bobj.data("path");
            const uuid = bobj.data("uuid");
            const fileName = bobj.data("filename");

            const fileCallPath = encodeURIComponent(uploadPath + "/" + uuid + "_" + fileName);

            bobj.find("img").attr('src', '/product/display?fileName=' + fileCallPath);
        } else {
            bobj.find("img").attr('src', '/resources/img/goodsNoImage.png');
        }

        /* 포인트 삽입 */
        let salePrice = "${goodsInfo.product_price - (goodsInfo.product_price*goodsInfo.product_discount)}"
        let point = salePrice*0.05;
        point = Math.floor(point);
        $(".point_span").text(point);


        //리뷰 리스트


    });	//$(document).ready(function(){


    // 수량 버튼 조작
    let quantity = $(".quantity_input").val();
    $(".plus_btn").on("click", function(){
        $(".quantity_input").val(++quantity);
    });
    $(".minus_btn").on("click", function(){
        if(quantity > 1){
            $(".quantity_input").val(--quantity);
        }
    });

    // 서버로 전송할 데이터
    const form = {
        memberId : '${member.member_id}',
        productId : '${goodsInfo.id}',
        productCount : ''
    }
    // 장바구니 추가 버튼
    $(".btn_cart").on("click", function(e){
        form.productCount = $(".quantity_input").val();
        $.ajax({
            url: '/cart/add',
            type: 'POST',
            data: form,
            success: function(result){
                cartAlert(result);
            },
            error : function(request,status,error){
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        })
    });

    function cartAlert(result){
        if(result == '0'){
            alert("장바구니에 추가를 하지 못하였습니다.");
        } else if(result == '1'){
            alert("장바구니에 추가되었습니다.");
        } else if(result == '2'){
            alert("장바구니에 이미 추가되어져 있습니다.");
        } else if(result == '5'){
            alert("로그인이 필요합니다.");
        }
    }
    /* 바로구매 버튼 */
    $(".btn_buy").on("click", function(){
        let Product_Count = $(".quantity_input").val();
        $(".order_form").find("input[name='orders[0].product_Count']").val(Product_Count);
        $(".order_form").submit();
    });
</script>
</body>
</html>