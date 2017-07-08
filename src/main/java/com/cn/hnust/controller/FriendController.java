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
import com.cn.hnust.pojo.Friend;
import com.cn.hnust.pojo.Postings;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IFriendService;
import com.cn.hnust.util.FinalConstant;

@Controller
@RequestMapping("/friend")
public class FriendController {

	@Resource
	private IFriendService friendService;

	/**
	 * 跳转到好友管理界面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_friendManage")
	public String user_friendManage() throws Exception {
		return "user_friendManage";
	}

	/**
	 * 添加好友
	 * @param friend
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_insertFriend")
	@ResponseBody
	@SystemControllerLog(description = "用户添加新好友")
	public Map<String, Object> user_insertFriend(Friend friend,
			HttpSession session) throws Exception {
		String tips = "";
		int flag1=0;
		Userb userb = (Userb) session.getAttribute(FinalConstant.CURR_USER);
		if(userb!=null){
		  if(userb.getBid()!=friend.getUserf().getBid()){
//			  friend.setBid(userb.getBid());
			  friend.setUserb(userb);
				int count=this.friendService.selectFriend(friend);
				if(count<=0){
					flag1 = this.friendService.insertFriend(friend);
					if (flag1 > 0) {
						int fbid = friend.getUserf().getBid();
						Userb userf = new Userb();
						userf.setBid(fbid);
						friend.setUserb(userf);
						friend.setUserf(userb);
						int flag2 = this.friendService.insertFriend(friend);
						if(flag2>0){
							tips = "添加成功"; 
						}else{
							tips = "添加失败，请稍后重试";
						}
//						friend.setBid(fbid);
//						friend.setFriendid(userb.getBid());
//						int flag2 = this.friendService.insertFriend(friend);
//						if(flag2>0){
//							tips = "添加成功"; 
//						}else{
//							tips = "添加失败，请稍后重试";
//						}
					} else {
						tips = "添加失败，请稍后重试";
					}
				}else{
					tips="该用户已经是你的好友";
				}  
		  }else{
			  tips="我就问你加自己为好友好玩么？有意思么？";
		  }	
		}else{
			tips="请先登录";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 添加好友之前的检查操作
	 * 1：要添加的还有是否是自己
	 * 2：是否已经添加了该好友
	 * @param friend
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_selectFriend")
	@ResponseBody
	public Map<String, Object> user_selectFriend(Friend friend,
			HttpSession session) throws Exception {
		String tips="";
		Userb userb =(Userb)session.getAttribute(FinalConstant.CURR_USER);
		if(userb.getBid()!=friend.getUserf().getBid()){
		   friend.setUserb(userb);
           int count = this.friendService.selectFriend(friend);
           if(count<=0){
        	   tips="可以添加";
           }else{
        	   tips="对方已经是你的好友了";
           }
		}else{
			tips="请不要加自己为好友";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 获取好友列表
	 * @param session
	 * @return
	 */
	@RequestMapping("/user_selectFriendList")
	@ResponseBody
	public Map<String,Object> user_selectFriendList(HttpSession session,Friend friend){
		String tips="";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
//		StringBuffer nameList = new StringBuffer();
		if(userb!=null){
			friend.setUserb(userb);
			List<Friend> friendList = this.friendService.selectFriendList(friend);
			if(friendList!=null){
				modelMap.put("friendList", friendList);
				tips="获取成功";
//				for(int i=0;i<friendList.size();i++){
//				   if(i==0){
//					   nameList.append("[{\'name\':\'"+friendList.get(i).getUserf().getName()+"\'}");
//				   }else{
//					   nameList.append(",{\'name\':\'"+friendList.get(i).getUserf().getName()+"\'}");
//				   }
//				}
//				nameList.append("[]");
//				System.out.println(nameList.toString());
//				modelMap.put("nameList", nameList);
			}
		}else{
			tips="请先登录";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 删除用户双方的好友关系
	 * @param session
	 * @param friend
	 * @return
	 */
	@RequestMapping("/user_deleteFriend")
	@ResponseBody
	public Map<String,Object> user_deleteFriend(HttpSession session,Friend friend){
		String tips="";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
		if(userb!=null){
			friend.setUserb(userb);
			int flag = this.friendService.deleteFriend(friend);
			if(flag>0){
			  	tips="删除成功";
			}else{
				tips="删除失败，请稍后重试";
			}
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 更新当前用户的好友的备注信息
	 * @param friend
	 * @return
	 */
	@RequestMapping("/user_updateFriend")
	@ResponseBody
	public Map<String,Object> user_updateFriend(Friend friend){
		String tips="";
		int flag=this.friendService.updateFriend(friend);
		if(flag>0){
			tips="修改成功";
		}else{
			tips="修改失败，请稍后重试";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 查询当前用户的所有好友的动态
     * @param session
     * @return
     */
	@RequestMapping("/user_selectFriendTrendsList")
	@ResponseBody
	public Map<String,Object> user_selectFriendTrendsList(HttpSession session,Friend friend){
		String tips="";
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(userb!=null){
			friend.setUserb(userb);
			List<Postings> list=this.friendService.selectFriendTrendsList(friend);
	        modelMap.put("list", list);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
}
