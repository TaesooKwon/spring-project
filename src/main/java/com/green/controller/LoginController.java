package com.green.controller;


import com.green.service.MemberService;
import com.green.vo.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login/*")
@Log4j
public class LoginController {
    @Setter(onMethod_ = @Autowired)
    MemberService service;

    @GetMapping("/login")
    public void getLogin() {

    }

    /* 로그인 */
    @PostMapping("/login")
    public String postLogin(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

        HttpSession session = request.getSession();
        MemberVO lvo = service.memberLogin(member);

        if (lvo == null) { // 일치하지 않는 아이디, 비밀번호 입력 경우

            int result = 0;
            rttr.addFlashAttribute("result", result);
            return "redirect:/login/login";

        }

        session.setAttribute("member", lvo); // 일치하는 아이디, 비밀번호 경우 (로그인 성공)

        return "redirect:/main/loginmain";
    }

    @GetMapping("/join")
    public void getJoin() {

    }

    @PostMapping("/join")
    public String postJoin(MemberVO vo) {
        service.insert(vo);
        return "redirect:login";
    }



    @RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
    @ResponseBody
    public String memberIdChkPOST(String member_id) throws Exception {
        int result = service.idCheck(member_id);

        if (result != 0) {

            return "fail"; // 중복 아이디가 존재

        } else {

            return "success"; // 중복 아이디 x

        }
    } // memberIdChkPOST() 종료


    @GetMapping("/findId")
    public void getFindid() {

    }

    @RequestMapping(value = "/findId", method = RequestMethod.POST)
    @ResponseBody
    public String postFindId(MemberVO vo) throws Exception {
        String result = service.findId(vo);

        if (result == null) {

            return "fail"; // 중복 아이디가 존재

        } else {

            return result; // 중복 아이디 x

        }
    } // memberIdChkPOST() 종료

    @GetMapping("/findPw")
    public void getFindPw() {

    }

    @RequestMapping(value = "/findPw", method = RequestMethod.POST)
    @ResponseBody
    public String postFindPw(MemberVO vo) throws Exception {
        String result = service.findPw(vo);

        if (result == null) {

            return "fail"; // 중복 아이디가 존재

        } else {

            return result; // 중복 아이디 x

        }
    } // memberIdChkPOST() 종료

}