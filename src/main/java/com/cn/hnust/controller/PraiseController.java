package com.cn.hnust.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cn.hnust.aop.SystemControllerLog;
import com.cn.hnust.pojo.Praise;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IPraiseService;
import com.cn.hnust.util.FinalConstant;

@Controller
@RequestMapping("/praise")
public class PraiseController {

	@Resource
	private IPraiseService praiseService;
	
	/**
	 * 点赞功能
	 * @param praise
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("user_clickPraise")
	@ResponseBody
	public Map<String, Object> user_clickPraise(Praise praise,HttpSession session) throws Exception{
		String tips="";
		Userb userb = (Userb) session.getAttribute(FinalConstant.CURR_USER);
		if(userb!=null){
			if(praise!=null){
			  if((praise.getPostings()!=null)||(praise.getDetails()!=null)||(praise.getComments()!=null)){
					praise.setUserb(userb);
//					if((praise.getPid()!=0)||(praise.getDid()!=0)||(praise.getCid()!=0)){
//						praise.setBid(userb.getBid());
					int status= praiseService.clickPraise(praise);
					if(status==0){
						tips="撤赞成功";
					}else if(status==1){
						tips="点赞成功";
					}else{
						tips="请稍后重试";
					}
				}else{
					tips="页面出错，请稍后重试";
				}
			}else{
				tips="页面出错，请稍后重试";
			}
		}else{
			tips="请先登录";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 获取用户被赞的信息
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_showPraiseList")
	@ResponseBody
	public Map<String, Object> user_showPraiseList(HttpSession session)
			throws Exception {
		String tips="";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Userb userb = (Userb) session.getAttribute(FinalConstant.CURR_USER);
		if (userb != null) {
			List<Praise> praiseList = this.praiseService.selectPraiseList(userb);
			if(praiseList!=null){
				modelMap.put("praiseList", praiseList);
				modelMap.put("userb", userb);
			}else{
				tips="没人赞你";
			}
		}
		
		modelMap.put("tips", tips);
		return modelMap;
	}	
	
	/**
	 * 前台用户将点赞信息关闭即将点赞信息标记为已读，看不到该信息
	 * @param praise
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping("/user_closePraise")
	@ResponseBody
	public Map<String, Object> user_closePraise(Praise praise)
			throws Exception {
		String tips="";
		int flag=0;
		flag=this.praiseService.updatePraiseMark(praise);
		if(flag>0){
		   tips="成功";
		}else{
		   tips="失败";	
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}	
}
