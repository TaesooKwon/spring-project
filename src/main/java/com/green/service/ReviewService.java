package com.green.service;

import com.green.vo.MemberVO;
import com.green.vo.ReviewVO;

import java.util.List;

public interface ReviewService {
    public List<ReviewVO> getList();
    public void insert(ReviewVO vo); //데이터 추가
    public ReviewVO read(int id);
    public void update(ReviewVO vo);
    public void delete(int id);
}
