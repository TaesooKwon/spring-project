package com.green.controller;
import java.util.List;
import java.util.Locale;

import com.green.mapper.MemberMapper;
import com.green.vo.MemberVO;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
    @Setter(onMethod_=@Autowired)
    private MemberMapper mapper;

    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        logger.info("Welcome home! The client locale is {}.", locale);

        List<MemberVO> getlist = mapper.getList();
        model.addAttribute("time",getlist);

        return "index";
    }

}