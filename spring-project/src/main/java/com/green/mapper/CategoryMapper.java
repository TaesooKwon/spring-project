package com.green.mapper;


import com.green.vo.CategoryVO;

import java.util.List;

public interface CategoryMapper {

    public List<CategoryVO> getList();
    public void insert(CategoryVO vo);
    public CategoryVO read(int id);
    public void update(CategoryVO vo);
    public void delete(int id);
}


