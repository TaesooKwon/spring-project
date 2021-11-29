package com.green.test;

import lombok.extern.log4j.Log4j;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:web/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests2 {

    @Autowired
    SqlSessionFactory sqlSessionFactory;

    @Test
    public void testConn2() throws Exception {
        SqlSession session = sqlSessionFactory.openSession();
        log.info(session);
        session.close();
    }
}