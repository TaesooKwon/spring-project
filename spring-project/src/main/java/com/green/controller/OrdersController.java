package com.green.controller;


import com.green.service.MemberService;
import com.green.service.OrdersService;
import com.green.vo.MemberVO;
import com.green.vo.OrderDTO;
import com.green.vo.OrderPageDTO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Log4j
public class OrdersController {

    @Setter(onMethod_=@Autowired)
    private OrdersService ordersService;

    @Setter(onMethod_=@Autowired)
    private MemberService memberService;

    @GetMapping("/order/{member_id}")
    public String orderPageGET(@PathVariable("member_id") String member_id, OrderPageDTO opd, Model model) {

        System.out.println("memberId : " + member_id);
        System.out.println("orders : " + opd.getOrders());

        model.addAttribute("orderList", ordersService.getGoodsInfo(opd.getOrders()));
        log.info(ordersService.getGoodsInfo(opd.getOrders()));
        model.addAttribute("memberInfo", memberService.getMemberInfo(member_id));
        log.info(memberService.getMemberInfo(member_id));
        return "/order/order";

    }

    @PostMapping("/order")
    public String orderPagePost(OrderDTO od, HttpServletRequest request) {

        System.out.println(od);

        ordersService.order(od);

        return "redirect:/main/main";
    }

}

