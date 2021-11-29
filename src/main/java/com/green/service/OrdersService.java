package com.green.service;

import com.green.vo.MemberVO;
import com.green.vo.OrdersVO;

import java.util.List;

public interface OrdersService {
    public List<OrdersVO> getList();
    public void insert(OrdersVO vo); //데이터 추가
    public OrdersVO read(int id);
    public void update(OrdersVO vo);
    public void delete(int id);
}
