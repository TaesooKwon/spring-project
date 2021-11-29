package com.green.mapper;


import com.green.vo.CategoryVO;

import java.util.List;

public interface CategoryMapper {

    public List<CategoryVO> getList();
    public void insert(CategoryVO category); //데이터 추가
}


