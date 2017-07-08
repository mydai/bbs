package com.cn.hnust.service;

import java.util.List;
import java.util.Map;

import com.cn.hnust.pojo.Log;
import com.cn.hnust.pojo.LogCondition;

public interface ILogService {

	/**
	 * 插入日志信息
	 * @param log
	 * @return
	 */
    public abstract int insertLog(Log log);
    
	/**
	 * 根据不同条件查询日志信息同时分页
	 * @param map
	 * @return
	 */
	public abstract List<Log> selectLogByCondition(Map<String, Object> map);
	
	/**
     * 获取日志总记录数
     * @param map
     * @return获取的total数
     */
    public abstract int getTotal(LogCondition logCondition);
	
    /**
     * 后台删除日志记录
     * @param report
     * @return
     */
    public abstract int deleteLog(Log log);
}
