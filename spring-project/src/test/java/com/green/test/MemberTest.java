package com.green.test;

import com.green.mapper.CategoryMapper;
import com.green.mapper.MemberMapper;
import com.green.vo.CategoryVO;
import com.green.vo.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.lang.reflect.Member;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:web/WEB-INF/spring/root-context.xml")
@Log4j


public class MemberTest {
    @Setter(onMethod_=@Autowired)
    private MemberMapper mapper;


    /* 로그인 쿼리 mapper 메서드 테스트 */
    @Test
    public void memberLogin() throws Exception{

        MemberVO member = new MemberVO();    // MemberVO 변수 선언 및 초기화

        /* 올바른 아이디 비번 입력경우 */
        member.setMember_id("test");
        member.setMember_password("test");

        /* 올바른 않은 아이디 비번 입력경우 */
        //member.setMemberId("test1123");
        //member.setMemberPw("test1321321");

        mapper.memberLogin(member);
        System.out.println("결과 값 : " + mapper.memberLogin(member));

    }
    //@Test
    public void memberIdChk() throws Exception{
        String id = "2222";	// 존재하는 아이디
        String id2 = "test123";	// 존재하지 않는 아이디
        log.info(mapper.idCheck(id));
        log.info(mapper.idCheck(id2));
        mapper.idCheck(id);
        mapper.idCheck(id2);

    }

    //@Test
    public void inserttest(){
       mapper.getList().forEach(i->log.info(i));
    }

    //@Test
    public void addtest(){
        MemberVO vo = new MemberVO();
        vo.setId(1);
        vo.setMember_id("test");
        vo.setMember_password("test");
        vo.setMember_name("test");
        vo.setMember_address("test");
        vo.setMember_phonenumber("test");
        vo.setMember_gender("test");
        mapper.insert(vo);

    }

}
