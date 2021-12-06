package com.green.service;

import com.green.mapper.ReviewMapper;
import com.green.vo.ReviewVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
public class ReviewServiceImpl implements ReviewService {

    @Setter(onMethod_ = @Autowired)
    private ReviewMapper mapper;

    @Override
    public List < ReviewVO > getList() {
        log.info("서비스에서 review getList---------------------------------");
        return mapper.getList();
    }

    @Override
    public void insert(ReviewVO vo) {
        log.info("서비스에서 review insert----------------------------------");
        mapper.insert(vo);
    }

    @Override
    public ReviewVO read(int id) {
        log.info("서비스에서 review read------------------");
        return mapper.read(id);
    }

    @Override
    public void update(ReviewVO vo) {
        log.info("서비스에서 review update------------------");
        mapper.update(vo);
    }

    @Override
    public void delete(int id) {
        log.info("서비스에서 review delete------------------");
        mapper.delete(id);
    }
}