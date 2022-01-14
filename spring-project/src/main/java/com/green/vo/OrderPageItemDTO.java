package com.green.vo;

import lombok.*;

import java.util.List;
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class OrderPageItemDTO {

    /* 뷰로부터 전달받을 값 */
    private int id;

    private int productCount;

    /* DB로부터 꺼내올 값 */
    private String product_name;

    private int product_price;

    private double product_discount;

    /* 만들어 낼 값 */
    private int salePrice;

    private int totalPrice;

    private int point;

    private int totalPoint;

    /* 상품 이미지 */
    private List<AttachImageVO> imageList;


    // salePrice, totalPrice, point, totalPoint의 경우 DB에서 꺼내올 수 있는 데이터가 아니라 bookPrice, bookCount, bookDiscount 값들을 통해서 만들어 낼 수 있는 변수들이기 때문에 이 변수들의 값을 세팅할 수 있는 메서드를 만들어줍니다.
    public void initSaleTotal() {
        this.salePrice = (int) (this.product_price * (1-this.product_discount));
        this.totalPrice = this.salePrice*this.productCount;
        this.point = (int)(Math.floor(this.salePrice*0.05));
        this.totalPoint =this.point * this.productCount;

    }

    public List<AttachImageVO> getImageList() {
        return imageList;
    }

    public void setImageList(List<AttachImageVO> imageList) {
        this.imageList = imageList;
    }


}