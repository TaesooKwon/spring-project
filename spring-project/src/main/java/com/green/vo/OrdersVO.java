package com.green.vo;

import lombok.*;

import java.util.Date;
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class OrdersVO {

    private int id;
    private String orders_name;
    private String orders_id;
    private String orders_address;
    private String orders_phonenumber;
    private String orders_payment;
    private Date orders_date;
    private int member_id;
    private int product;
}



