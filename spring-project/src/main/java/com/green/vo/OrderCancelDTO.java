package com.green.vo;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class OrderCancelDTO {

    private String member_id;

    private String order_id;

    private String keyword;

    private int amount;

    private int pageNum;
}
