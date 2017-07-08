package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.cn.hnust.dao.ReportMapper;
import com.cn.hnust.pojo.Report;
import com.cn.hnust.pojo.ReportCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IReportService;

@Service("reportService")
public class ReportServiceImpl implements IReportService {

	@Resource
	private ReportMapper reportMapper;
	
	@Override
	public int insertReport(Report report) {
		return reportMapper.insertReport(report);
	}

	@Override
	public List<Report> selectReportByCondition(Map<String, Object> map) {
		return reportMapper.selectReportByCondition(map);
	}

	@Override
	public int getTotal(ReportCondition reportCondition) {
		return reportMapper.getTotal(reportCondition);
	}

	@Override
	public int deleteReport(Report report) {
		return reportMapper.deleteReport(report);
	}

}
