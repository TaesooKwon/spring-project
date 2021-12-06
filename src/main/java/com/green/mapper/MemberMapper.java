package com.green.mapper;


import com.green.vo.MemberVO;

import java.util.List;

public interface MemberMapper {

    public List<MemberVO> getList();
    public void insert(MemberVO vo);
    public MemberVO read(int id);
    public void update(MemberVO vo);
    public void delete(int id);
}


