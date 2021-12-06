package com.green.service;

import com.green.mapper.ProductMapper;
import com.green.vo.ProductVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
public class ProductServiceImpl implements ProductService {

    @Setter(onMethod_ = @Autowired)
    private ProductMapper mapper;

    @Override
    public List < ProductVO > getList() {
        log.info("서비스에서 product getList---------------------------------");
        return mapper.getList();
    }

    @Override
    public void insert(ProductVO vo) {
        log.info("서비스에서 product insert----------------------------------");
        mapper.insert(vo);
    }

    @Override
    public ProductVO read(int id) {
        log.info("서비스에서 product read------------------");
        return mapper.read(id);
    }

    @Override
    public void update(ProductVO vo) {
        log.info("서비스에서 product update------------------");
        mapper.update(vo);
    }

    @Override
    public void delete(int id) {
        log.info("서비스에서 product delete------------------");
        mapper.delete(id);
    }
}