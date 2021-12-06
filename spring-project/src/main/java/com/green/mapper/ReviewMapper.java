package com.green.mapper;

import com.green.vo.ReviewVO;

import java.util.List;

public interface ReviewMapper {
    public List<ReviewVO> getList();
    public void insert(ReviewVO vo);
    public ReviewVO read(int id);
    public void update(ReviewVO vo);
    public void delete(int id);
}
