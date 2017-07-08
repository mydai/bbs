package com.cn.hnust.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cn.hnust.aop.SystemControllerLog;
import com.cn.hnust.pojo.Log;
import com.cn.hnust.pojo.LogCondition;
import com.cn.hnust.pojo.Report;
import com.cn.hnust.pojo.ReportCondition;
import com.cn.hnust.service.ILogService;
import com.cn.hnust.util.PageBean;

@Controller
@RequestMapping("/log")
public class LogController {
	
	@Resource
	private ILogService logService;
	
	/**
	 * 跳转到admin_logManager页面
	 * @return
	 * @throws Exception
	 */
	public String admin_logManager() throws Exception {
		return "admin_logManager";
	}
	
	
    /**
     * 后台管理获取日志信息,
	 * 还可以根据不同条件来查询相对应的日志信息
	 * 分页
     * @param page
     * @param rows
     * @param logCondition
     * @return
     */
	@RequestMapping("/admin_selectLogList")
	@ResponseBody
	public Map<String, Object> admin_selectLogList(String page,String rows,LogCondition logCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("logCondition", logCondition);
		List<Log> logList = this.logService.selectLogByCondition(map);
		int total = this.logService.getTotal(logCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(logList!=null){
			modelMap.put("rows",logList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台删除日志记录信息
	 * @param log
	 * @param lids
	 * @return
	 */
	@RequestMapping(value="/admin_deleteLog",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理删除日志记录信息")
	public Map<String,Object> admin_deleteLog(Log log,String lids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] lidStr = lids.split(",");
        for (String lid : lidStr) {
        	log.setLid(Integer.parseInt(lid));
            count = this.logService.deleteLog(log);
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
