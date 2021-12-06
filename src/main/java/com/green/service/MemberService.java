package com.green.service;

import com.green.vo.MemberVO;

import java.util.List;

public interface MemberService {
    public List<MemberVO> getList();
    public void insert(MemberVO vo); //데이터 추가
    public MemberVO read(int id);
    public void update(MemberVO vo);
    public void delete(int id);
}
