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
import com.cn.hnust.pojo.Postings;
import com.cn.hnust.pojo.PostingsCondition;
import com.cn.hnust.pojo.Theme;
import com.cn.hnust.pojo.ThemeCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IPostingsService;
import com.cn.hnust.util.FinalConstant;
import com.cn.hnust.util.PageBean;

@Controller
@RequestMapping("/postings")
public class PostingsController {
	@Resource
	private IPostingsService postingsService;

	/**
	 * 进入一个帖子页面，获取关于帖子的所有内容
	 * @param pid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("user_selectPostings")
    @ResponseBody
	public Map<String, Object> user_selectPostings(int pid,HttpSession session)
			throws Exception {
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
		String tips="";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Postings postings= postingsService.selectPostingsById(pid);
		if(postings!=null){
			modelMap.put("postings", postings);
			tips="获取成功";
			if(userb!=null){
				modelMap.put("userb", userb);
			}
		}else{
			tips="该帖不存在";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 用户提出问题，跳转到提问页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_askQuestion")
	public String user_askQuestion() throws Exception {
		return "user_askQuestion";
	}
	
	/**
	 * 用户插入一个帖子
	 * @param postings
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("user_insertPostings")
	@ResponseBody
	@SystemControllerLog(description = "用户发表一个帖子")
	public Map<String, Object> user_insertPostings(Postings postings,HttpSession session)
			throws Exception {
		String tips="请稍后重试";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Userb userb=(Userb) session.getAttribute(FinalConstant.CURR_USER);
		if(userb!=null){
			postings.setUserb(userb);
			if(postings!=null){
				Postings posting = this.postingsService.selectPostingsByProperty(postings);
				if(posting==null){
				if(!("".equals(postings.getTitle()))&&(postings.getTitle()!=null)){
					if(!("".equals(postings.getPostings_theme()))&&(postings.getPostings_theme().size()!=0)){
						if(!("".equals(postings.getPcontent()))&&(postings.getPcontent().length()!=0)){
							int pid=postingsService.insertPostings(postings);
							if(pid>0){
								modelMap.put("pid", pid);
								tips="问题发布成功";
							}else{
								tips="问题发布失败，请稍后重试";
							}
						}else{
							tips="帖子内容不能为空";
						}
					}else{
						tips="至少要有一个主题";
					}
				}else{
					tips="帖子标题不能为空";
				}
			  }else{
				  tips="该帖子标题已存在";
			  }
			}
		}else{
			tips="请先登录";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 获取所有的帖子列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("user_selectPostingsList")
	@ResponseBody
	public Map<String, Object> user_selectPostingsList(HttpSession session)
			throws Exception {
		String tips="";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<Postings> postingsList=postingsService.selectPostingsList();
		
		if(postingsList!=null){
			modelMap.put("postingsList", postingsList);
			tips="获取成功";
			Userb userb=(Userb)session.getAttribute(FinalConstant.CURR_USER);
			if(userb!=null){
				modelMap.put("userb", userb);
			}
		}else{
			tips="页面出错";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 传入帖子的标题，进行模糊查询,获取titleList
	 * @param title
	 * @return
	 */
	@RequestMapping(value="/user_selectTitleList",method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> user_selectTitleList(String title){
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<Postings> list =null; 
		if(title!=null){
			if (!("".equals(title)) && !(title.length() == 0)) {
	           list=this.postingsService.selectTitleList(title);
			}
		}
		modelMap.put("tips", tips);
		modelMap.put("list", list);
		return modelMap;
	}
	
	/**
	 * 获取当前用户的所有帖子信息
	 * @param session
	 * @return
	 */
	@RequestMapping("user_selectUserbPostings")
	@ResponseBody             
	public Map<String,Object> user_selectUserbPostings(HttpSession session){
		String tips = "";
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<Postings> list =null;
		if(userb!=null){
			list = this.postingsService.selectPostings(userb);
		}else{
			tips="请先登录";
		}
		modelMap.put("tips", tips);
		modelMap.put("list", list);
		return modelMap;
	}
	
	/**
	 * 后台管理获取帖子列表信息,
	 * 还可以根据不同条件来查询相对应的帖子信息
	 * 分页
	 * @param page
	 * @param rows
	 * @param postingsCondition
	 * @return
	 */
	@RequestMapping("/admin_selectPostingsList")
	@ResponseBody
	public Map<String, Object> admin_selectPostingsList(String page,String rows,PostingsCondition postingsCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("postingsCondition", postingsCondition);
		List<Postings> postingsList = this.postingsService.selectPostingsByCondition(map);
		int total = this.postingsService.getTotal(postingsCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(postingsList!=null){
			modelMap.put("rows",postingsList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台添加新帖子
	 * @param postings
	 * @return
	 */
	@RequestMapping(value="/admin_insertPostings",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理添加新帖子")
	public Map<String, Object> admin_insertPostings(Postings postings) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
			int count=this.postingsService.insertPostingsByProperty(postings);
			if(count>0){
				tips="成功";
			}else{
				tips="失败";
			}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台更新帖子信息	
     * @param postings
     * @return
     */
	@RequestMapping(value="/admin_updatePostings",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理更新帖子信息")
	public Map<String, Object> admin_updatePostings(Postings postings){
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = this.postingsService.updatePostings(postings);
		if(count>0){
			tips="成功";
		}else{
			tips="失败";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**删除帖子
     * @param userb
     * @return
     */
	@RequestMapping(value="/admin_deletePostings",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理删除帖子")
	public Map<String,Object> admin_deletePostings(Postings postings,String pids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] pidStr = pids.split(",");
        for (String pid : pidStr) {
        	postings.setPid(Integer.parseInt(pid));
            count = this.postingsService.deletePostings(postings);
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
