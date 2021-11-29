package com.green.test;

import com.green.mapper.CategoryMapper;
import com.green.vo.CategoryVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:web/WEB-INF/spring/root-context.xml")
@Log4j


public class CategoryTest {
    @Setter(onMethod_=@Autowired)
    private CategoryMapper mapper;
    @Test
    public void inserttest(){
        CategoryVO vo = new CategoryVO();
        vo.setId(1);
        vo.setCategory_name("test");
        vo.setProduct_id(1);
        log.info(mapper);
    }

}
