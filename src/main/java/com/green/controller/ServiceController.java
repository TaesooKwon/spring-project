package com.green.controller;


import com.green.service.MemberService;
import com.green.vo.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member/*")
@Log4j
public class ServiceController {
    @Setter(onMethod_=@Autowired)
    MemberService service;

    @GetMapping("/register")
    public void register() {
        System.out.println("1) 컨트롤러 등록 get ");
        //return "/board/register";
    }
    @PostMapping("/register")
    public void postRegister(MemberVO vo, RedirectAttributes rttr) {
        System.out.println("1) 컨트롤러 등록 post " +vo);
        service.insert(vo);

    }
}

