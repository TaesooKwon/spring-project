package com.green.vo;

import lombok.*;
import java.util.Date;
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {

    private int id;
    private String review_id;
    private String review_name;
    private String review_title;
    private String review_content;
    private Date review_date;
    private int review_starts;
    private int member_id;
    private int product_id;
}



