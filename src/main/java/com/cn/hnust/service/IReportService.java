package com.cn.hnust.service;

import java.util.List;
import java.util.Map;
import com.cn.hnust.pojo.Report;
import com.cn.hnust.pojo.ReportCondition;
import com.cn.hnust.pojo.Userb;

public interface IReportService {
	/**
	 * 插入一条举报信息
	 * @param pid
	 * @return
	 */
	public abstract int insertReport(Report report);
	
	/**
	 * 根据不同条件查询投诉同时分页
	 * @param map
	 * @return
	 */
	public abstract List<Report> selectReportByCondition(Map<String, Object> map);
	
	/**
     * 获取投诉总记录数
     * @param map
     * @return获取的total数
     */
    public abstract int getTotal(ReportCondition reportCondition);
    
    /**
     * 后台删除投诉记录
     * @param report
     * @return
     */
    public abstract int deleteReport(Report report);
}
