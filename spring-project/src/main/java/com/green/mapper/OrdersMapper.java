package com.green.mapper;

import com.green.vo.OrdersVO;

import java.util.List;

public interface OrdersMapper {
    public List<OrdersVO> getList();
    public void insert(OrdersVO vo);
    public OrdersVO read(int id);
    public void update(OrdersVO vo);
    public void delete(int id);
}
