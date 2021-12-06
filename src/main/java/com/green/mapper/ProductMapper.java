package com.green.mapper;

import com.green.vo.ProductVO;

import java.util.List;

public interface ProductMapper {
    public List<ProductVO> getList();
    public void insert(ProductVO vo);
    public ProductVO read(int id);
    public void update(ProductVO vo);
    public void delete(int id);
}
