package com.green.service;

import com.green.vo.CategoryVO;

import java.util.List;

public interface CategoryService {
    public List<CategoryVO> getList();
    public void insert(CategoryVO vo); //데이터 추가
    public CategoryVO read(int id);
    public void update(CategoryVO vo);
    public void delete(int id);
}
