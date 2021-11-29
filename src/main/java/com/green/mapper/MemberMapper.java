package com.green.mapper;


import com.green.vo.CategoryVO;
import com.green.vo.MemberVO;

import java.util.List;

public interface MemberMapper {

    public List<MemberVO> getList();
    public void insert(MemberVO vo); //데이터 추가
}


