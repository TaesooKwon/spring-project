package com.green.test;


import lombok.extern.log4j.Log4j;
import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;

import static org.junit.Assert.fail;

@Log4j
public class JdbcTest {
    @Test
    public void testConnection() throws Exception{

        //드라이버로드(드라이버네임)
        Class.forName("com.mysql.cj.jdbc.Driver");

        log.info("------연결확인--------");

        String url = "jdbc:mysql://localhost:3306/testDb?serverTimezone=UTC";
        String username = "root";
        String password = "1234";

        Connection con = DriverManager.getConnection(url,username,password);

        log.info(con);
        con.close();

    }
}