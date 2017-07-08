package com.cn.hnust.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cn.hnust.aop.SystemControllerLog;
import com.cn.hnust.pojo.CommentsCondition;
import com.cn.hnust.pojo.Details;
import com.cn.hnust.pojo.Comments;
import com.cn.hnust.pojo.Theme;
import com.cn.hnust.pojo.ThemeCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.ICommentsService;
import com.cn.hnust.util.FinalConstant;
import com.cn.hnust.util.PageBean;

@Controller
@RequestMapping("/comments")
public class CommentsController {
	@Resource
	private ICommentsService commentsService;

	/**
	 * 从details跳转到user_showComents页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_showComments")
	public String user_showComments(int did, Model model) throws Exception {
		model.addAttribute("ddid", did);
		return "user_showComments";
	}

	/**
	 * 获取对应details的回复列表
	 * 
	 * @param details
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_selectCommentsList")
	@ResponseBody
	public Map<String, Object> user_selectCommentsList(Details details)
			throws Exception {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if ((details != null) && (details.getDid() != 0)) {
			List<Comments> commentsList = commentsService.selectCommentsList(details);
			if (commentsList != null) {
				modelMap.put("commentsList", commentsList);
				tips = "获取成功";
			} else {
				tips = "暂无回复";
			}
		} else {
			tips = "页面出错，请稍后重试";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 用户评论回答
	 * @param comments
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_insertComments")
	@ResponseBody
	@SystemControllerLog(description = "用户添加评论信息")
	public Map<String, Object> user_insertComments(Comments comments,HttpSession session) throws Exception{
		String tips = "";
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
		if(userb!=null){
			if(comments!=null){
				if((!"".equals(comments.getCcontent()))&&(comments.getCcontent().length()!=0)){
					comments.setUserb(userb);
					int cid = commentsService.insertComments(comments);
                    if(cid>0){
                    	tips="评论成功";
                    }else{
                    	tips="评论失败，请稍后重试";
                    }				
				}else{
					tips="评论不能为空";
				}
			}else{
				tips="页面出错";
			}
		}else{
			tips="请先登录";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台管理获取评论列表信息,
	 * 还可以根据不同条件来查询相对应的评论信息
	 * 分页
	 * @param page
	 * @param rows
	 * @param commentsCondition
	 * @return
	 */
	@RequestMapping("/admin_selectCommentsList")
	@ResponseBody
	public Map<String, Object> admin_selectCommentsList(String page,String rows,CommentsCondition commentsCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("commentsCondition", commentsCondition);
		List<Comments> commentsList = this.commentsService.selectCommentsByCondition(map);
		int total = this.commentsService.getTotal(commentsCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(commentsList!=null){
			modelMap.put("rows",commentsList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台添加新评论
	 * @param comments
	 * @return
	 */
	@RequestMapping(value="/admin_insertComments",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理添加新评论")
	public Map<String, Object> admin_insertComments(Comments comments) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
			int count=this.commentsService.insertCommentsByProperty(comments);
			if(count>0){
				tips="成功";
			}else{
				tips="失败";
			}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台更新评论信息	
     * @param comments
     * @return
     */
	@RequestMapping(value="/admin_updateComments",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理更新信息")
	public Map<String, Object> admin_updateComments(Comments comments){
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = this.commentsService.updateComments(comments);
		if(count>0){
			tips="成功";
		}else{
			tips="失败";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台管理删除评论
     * @param userb
     * @return
     */
	@RequestMapping(value="/admin_deleteComments",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理删除评论")
	public Map<String,Object> admin_deleteComments(Comments comments,String cids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] cidStr = cids.split(",");
        for (String cid : cidStr) {
        	comments.setCid(Integer.parseInt(cid));
            count = this.commentsService.deleteComments(comments);
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
