package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.LogMapper;
import com.cn.hnust.pojo.Log;
import com.cn.hnust.pojo.LogCondition;
import com.cn.hnust.service.ILogService;

@Service("logService")
public class LogServiceImpl implements ILogService {

	@Resource
	private LogMapper logMapper;
	
	@Override
	public int insertLog(Log log) {
		return logMapper.insertLog(log);
	}

	@Override
	public List<Log> selectLogByCondition(Map<String, Object> map) {
		return logMapper.selectLogByCondition(map);
	}

	@Override
	public int getTotal(LogCondition logCondition) {
		return logMapper.getTotal(logCondition);
	}

	@Override
	public int deleteLog(Log log) {
		return logMapper.deleteLog(log);
	}
   
}
