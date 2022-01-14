package com.green.service;

import com.green.vo.EventVo;

import java.util.List;

public interface EventService {
    public int eventListCount();
    public List<EventVo> eventList(EventVo event);
    public EventVo eventOne(String event_id);
    public int eventInsert(EventVo event);
    public int eventUpdate(EventVo event);
    public int eventDelete(String event_id);
}