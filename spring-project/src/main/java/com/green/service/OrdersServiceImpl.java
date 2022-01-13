package com.green.service;

import com.green.mapper.AttachMapper;
import com.green.mapper.MemberMapper;
import com.green.mapper.OrdersMapper;
import com.green.mapper.ProductMapper;
import com.green.vo.*;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Log4j
public class OrdersServiceImpl implements OrdersService{

    @Setter(onMethod_= @Autowired)
    private OrdersMapper orderMapper;

    @Setter(onMethod_= @Autowired)
    private AttachMapper attachMapper;

    @Setter(onMethod_= @Autowired)
    private MemberMapper memberMapper;

    //@Setter(onMethod_= @Autowired)
    //private CartMapper cartMapper;

    @Setter(onMethod_= @Autowired)
    private ProductMapper productMapper;

    @Override
    public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders) {

        List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();

        for(OrderPageItemDTO ord : orders) {

            OrderPageItemDTO goodsInfo = orderMapper.getGoodsInfo(ord.getId());

            goodsInfo.setProductCount(ord.getProductCount());

            goodsInfo.initSaleTotal();

            List<AttachImageVO> imageList = attachMapper.getAttachList(goodsInfo.getId());

            goodsInfo.setImageList(imageList);

            result.add(goodsInfo);
        }

        return result;

    }

    @Override
    @Transactional
    public void order(OrderDTO ord) {

        /* 사용할 데이터가져오기 */
        /* 회원 정보 */
        MemberVO member = memberMapper.getMemberInfo(ord.getMember_id());
        /* 주문 정보 */
        List<OrderItemDTO> ords = new ArrayList<>();
        for(OrderItemDTO oit : ord.getOrders()) {
            OrderItemDTO orderItem = orderMapper.getOrderInfo(oit.getProduct_Id());
            // 수량 셋팅
            orderItem.setProduct_Count(oit.getProduct_Count());
            // 기본정보 셋팅
            orderItem.initSaleTotal();
            //List객체 추가
            ords.add(orderItem);
        }
        /* OrderDTO 셋팅 */
        ord.setOrders(ords);
        ord.getOrderPriceInfo();

        /*DB 주문,주문상품(,배송정보) 넣기*/

        /* orderId만들기 및 OrderDTO객체 orderId에 저장 */
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddmm");
        String orderId = member.getMember_id() + format.format(date);
        ord.setOrderId(orderId);

        /* db넣기 */
        orderMapper.enrollOrder(ord);      //vam_order 등록
        for(OrderItemDTO oit : ord.getOrders()) {      //vam_orderItem 등록
            oit.setOrderId(orderId);
            orderMapper.enrollOrderItem(oit);
        }

        /* 비용 포인트 변동 적용 */

        /* 비용 차감 & 변동 돈(돈) Member객체 적용 */
        int calMoney = member.getMoney();
        calMoney -= ord.getOrderFinalSalePrice();
        member.setMoney(calMoney);

        /* 포인트 차감, 포인트 증가 & 변동 포인트(point) Member객체 적용 */
        int calPoint = member.getPoint();
        calPoint = calPoint - ord.getUsePoint() + ord.getOrderSavePoint();   // 기존 포인트 - 사용 포인트 + 획득 포인트
        member.setPoint(calPoint);

        /* 변동 돈, 포인트 DB 적용 */
        orderMapper.deductMoney(member);

        /* 재고 변동 적용 */
        for(OrderItemDTO oit : ord.getOrders()) {
            /* 변동 재고 값 구하기 */
            ProductVO product = productMapper.getGoodsInfo(oit.getProduct_Id());
            product.setProduct_stock(product.getProduct_stock() - oit.getProduct_Count());
            /* 변동 값 DB 적용 */
            orderMapper.deductStock(product);
        }

        /* 장바구니 제거
        for(OrderItemDTO oit : ord.getOrders()) {
            CartDTO dto = new CartDTO();
            dto.setMember_id(ord.getMemberId());
            dto.setProduct_Id(oit.getBookId());

            cartMapper.deleteOrderCart(dto);
        }*/


    }
}