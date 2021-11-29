package com.green.vo;

import lombok.*;

import java.util.Date;
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

    private int id;
    private String member_id;
    private String member_password;
    private String member_name;
    private String member_address;
    private String member_phonenumber;
    private String member_gender;
    private String member_role;
    private Date member_date;
}






