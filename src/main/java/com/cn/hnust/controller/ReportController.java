package com.cn.hnust.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cn.hnust.aop.SystemControllerLog;
import com.cn.hnust.pojo.Report;
import com.cn.hnust.pojo.ReportCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.pojo.UserbCondition;
import com.cn.hnust.service.IReportService;
import com.cn.hnust.util.FinalConstant;
import com.cn.hnust.util.PageBean;

@Controller
@RequestMapping("/report")
public class ReportController {
	@Resource
	private IReportService reportService;
	
	/**
	 * 用户投诉 帖子，回答，评论内容
	 * @param report
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_sendReport")
	@ResponseBody
	@SystemControllerLog(description = "用户投诉")
	public Map<String, Object> user_sendReport(Report report,HttpSession session ) throws Exception {
		String tips = "请稍后重试";
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
		if(userb!=null){
			report.setBid(userb.getBid());
			if(report!=null){
				int flag=reportService.insertReport(report);
				if(flag>0){
					tips="举报成功，我们将会尽快处理";
				}else{
					tips="请稍后再试";
				}
			}
		}else{
			tips="请先登录";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台管理获取投诉信息,
	 * 还可以根据不同条件来查询相对应的投诉信息
	 * 分页
	 * @param name
	 * @return
	 */
	@RequestMapping("/admin_selectReportList")
	@ResponseBody
	public Map<String, Object> admin_selectReportList(String page,String rows,ReportCondition reportCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("reportCondition", reportCondition);
		List<Report> reportList = this.reportService.selectReportByCondition(map);
		int total = this.reportService.getTotal(reportCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(reportList!=null){
			modelMap.put("rows",reportList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台管理删除投诉信息
	 * @param report
	 * @param rids
	 * @return
	 */
	@RequestMapping(value="/admin_deleteReport",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理删除投诉信息")
	public Map<String,Object> admin_deleteReport(Report report,String rids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] ridStr = rids.split(",");
        for (String rid : ridStr) {
        	report.setRid(Integer.parseInt(rid));
            count = this.reportService.deleteReport(report);
            if(count<=0){
            	tips="删除失败";
            	break;
            }else{
            	tips="删除成功";
            }
        }
		modelMap.put("tips", tips);
		return modelMap;
	}
}
