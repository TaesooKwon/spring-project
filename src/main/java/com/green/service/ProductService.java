package com.green.service;

import com.green.vo.MemberVO;
import com.green.vo.ProductVO;

import java.util.List;

public interface ProductService {
    public List<ProductVO> getList();
    public void insert(ProductVO vo); //데이터 추가
    public ProductVO read(int id);
    public void update(ProductVO vo);
    public void delete(int id);
}
