package com.green.service;

import com.green.mapper.OrdersMapper;
import com.green.vo.OrdersVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
public class OrdersServiceImpl implements OrdersService {

    @Setter(onMethod_ = @Autowired)
    private OrdersMapper mapper;

    @Override
    public List < OrdersVO > getList() {
        log.info("서비스에서 orders getList---------------------------------");
        return mapper.getList();
    }

    @Override
    public void insert(OrdersVO vo) {
        log.info("서비스에서 orders insert----------------------------------");
        mapper.insert(vo);
    }

    @Override
    public OrdersVO read(int id) {
        log.info("서비스에서 orders read------------------");
        return mapper.read(id);
    }

    @Override
    public void update(OrdersVO vo) {
        log.info("서비스에서 orders update------------------");
        mapper.update(vo);
    }

    @Override
    public void delete(int id) {
        log.info("서비스에서 orders delete------------------");
        mapper.delete(id);
    }
}