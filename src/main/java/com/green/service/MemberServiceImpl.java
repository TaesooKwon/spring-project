package com.green.service;

import com.green.mapper.MemberMapper;
import com.green.vo.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
public class MemberServiceImpl implements MemberService{
    @Setter(onMethod_=@Autowired)
    private MemberMapper mapper;

    @Override
    public List<MemberVO> getList() {
        log.info("서비스에서 전체 데이터 가져오기---------------------------------");
        return mapper.getList();
    }

    @Override
    public void insert(MemberVO vo) {
        log.info("서비스에서 데이터 입력하기----------------------------------");
        mapper.insert(vo);
    }
}
