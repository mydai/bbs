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
import com.cn.hnust.pojo.Details;
import com.cn.hnust.pojo.DetailsCondition;
import com.cn.hnust.pojo.Postings;
import com.cn.hnust.pojo.Theme;
import com.cn.hnust.pojo.ThemeCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IDetailsService;
import com.cn.hnust.service.impl.DetailsServiceImpl;
import com.cn.hnust.util.FinalConstant;
import com.cn.hnust.util.PageBean;

@Controller
@RequestMapping("/details")
public class DetailsController {
   
	@Resource
	private IDetailsService detailsService;
	
	/**
	 * 插入回答details
	 * @param details
	 * @param postings
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_insertDetails")
	@ResponseBody
	@SystemControllerLog(description = "用户回答帖子")
	public Map<String, Object> user_insertDetails(Details details,Postings postings, HttpSession session) throws Exception{
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
        Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
        if(userb!=null){
        	if(details!=null){
        		if(!("".equals(details.getDcontent()))&&details.getDcontent().length()!=0){
        			details.setUserb(userb);
        			details.setPostings(postings);
        			details = detailsService.insertDetails(details);
        			if(details.getDid()>0){
        				modelMap.put("details", details);
        				tips="回答成功";
        			}else{
        				tips="回答失败，请稍后重试";
        			}
        		}
        	}else{
        		tips="页面出错，请稍后重试";
        	}
        }else{
        	tips="请先登录";
        }
		
		modelMap.put("tips", tips);
		return modelMap;
	};
	
	/**
	 * 后台管理获取回答列表信息,
	 * 还可以根据不同条件来查询相对应的回答信息
	 * 分页
	 * @param page
	 * @param rows
	 * @param detailsCondition
	 * @return
	 */
	@RequestMapping("/admin_selectDetailsList")
	@ResponseBody
	public Map<String, Object> admin_selectDetailsList(String page,String rows,DetailsCondition detailsCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("detailsCondition", detailsCondition);
		List<Details> detailsList = this.detailsService.selectDetailsByCondition(map);
		int total = this.detailsService.getTotal(detailsCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(detailsList!=null){
			modelMap.put("rows",detailsList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台添加新回答
	 * @param details
	 * @return
	 */
	@RequestMapping(value="/admin_insertDetails",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理添加新回答")
	public Map<String, Object> admin_insertDetails(Details details) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
			int count=this.detailsService.insertDetailsByProperty(details);
			if(count>0){
				tips="成功";
			}else{
				tips="失败";
			}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台更新回答
     * @param details
     * @return
     */
	@RequestMapping(value="/admin_updateDetails",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理更新回答")
	public Map<String, Object> admin_updateDetails(Details details){
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = this.detailsService.updateDetails(details);
		if(count>0){
			tips="成功";
		}else{
			tips="失败";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台管理删除回答
     * @param details tids
     * @return
     */
	@RequestMapping(value="/admin_deleteDetails",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理删除回答")
	public Map<String,Object> admin_deleteDetails(Details details,String dids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] didStr = dids.split(",");
        for (String did : didStr) {
        	details.setDid(Integer.parseInt(did));
            count = this.detailsService.deleteDetails(details);
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
