package com.green.service;


import com.green.mapper.CategoryMapper;
import com.green.vo.CategoryVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service @Log4j public class CategoryServiceImpl implements CategoryService {

    @Setter(onMethod_ = @Autowired) private CategoryMapper mapper;

    @Override public List < CategoryVO > getList() {
        log.info("서비스에서 category getList---------------------------------");
        return mapper.getList();
    }

    @Override public void insert(CategoryVO vo) {
        log.info("서비스에서 category insert----------------------------------");
        mapper.insert(vo);
    }

    @Override public CategoryVO read(int id) {
        log.info("서비스에서 category read------------------");
        return mapper.read(id);
    }

    @Override public void update(CategoryVO vo) {
        log.info("서비스에서 category update------------------");
        mapper.update(vo);
    }

    @Override public void delete(int id) {
        log.info("서비스에서 category delete------------------");
        mapper.delete(id);
    }
}