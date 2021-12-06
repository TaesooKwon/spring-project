package com.green.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main/*")
@Log4j
public class MainController {

    @GetMapping("/loginmain")
    public void register() {
        System.out.println("1) 컨트롤러 등록 get ");
    }
}
