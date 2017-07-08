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
import com.cn.hnust.pojo.Msg;
import com.cn.hnust.pojo.MsgCondition;
import com.cn.hnust.pojo.Phone;
import com.cn.hnust.pojo.Postings;
import com.cn.hnust.pojo.Report;
import com.cn.hnust.pojo.ReportCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IMsgService;
import com.cn.hnust.util.FinalConstant;
import com.cn.hnust.util.PageBean;

@Controller
@RequestMapping("/msg")
public class MsgController {
	@Resource
	private IMsgService msgService;
    
	/**
	 * 打开消息窗口
	 * @return
	 */
	@RequestMapping("/user_showMessage")
	public String user_showMessage(){
		return "user_showMessage";
	}
	
	/**
	 * 跳转到用户个人中心的首页
	 * @return
	 */
	@RequestMapping("/user_index")
	public String user_index(){
		return "user_index";
	}
	
	/**
	 * 在index页面打开的消息显示页面
	 * 
	 * @param session
	 *            用于传入当前用户信息
	 * @param model
	 *            用户将消息列表传递到页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_showMessageList")
	@ResponseBody
	public Map<String, Object> user_showMessageList(HttpSession session)
			throws Exception {
		String tips="";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Userb userb = (Userb) session.getAttribute(FinalConstant.CURR_USER);
		if (userb != null) {
			List<Msg> messageList = msgService.selectMsgList(userb);
			modelMap.put("messageList", messageList);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 跳转到发送私信页面
	 * 
	 * @return
	 */
	@RequestMapping("/user_sendMessage")
	public String user_sendMessage() {
		return "user_sendMessage";
	}
	
    /**
     * 传入不同的status,
     * status=0为对方拒绝添加好友，
     * status=1为对方同意添加好友，
     *  status=2为好友申请，
     * 默认status=3为用户发送私信，
     * 在用户选择同意添加好友或者拒绝后，系统消息提示提出申请好友用户最后的结果
     * status=4为系统消息
     * 
     * @param session
     * @param msg
     * @return
     */
	@RequestMapping("/user_doSendMessage")
	@ResponseBody
	@SystemControllerLog(description = "用户发送短信息")
	public Map<String, Object> user_doSendMessage(HttpSession session, Msg msg) {
		String tips = "";
		int flag = 0;
		int state = msg.getStatus();
		Userb userb = (Userb) session.getAttribute(FinalConstant.CURR_USER);
		if (userb != null) {
		    if(state==2){
				msg.setUserb(userb);
				flag = msgService.insertMsg(msg);
				if (flag > 0) {
					tips = "好友申请发送成功";
				} else {
					tips = "发送失败";
				}
			}else if(state==3){
				if(!("".equals(msg.getMcontent())&&!(msg.getMcontent().length()==0))){
					msg.setUserb(userb);
					flag = msgService.insertMsg(msg);
					if (flag > 0) {
						tips = "发送成功";
					} else {
						tips = "发送失败，请稍后重试";
					}
				}else{
				    tips="內容不能为空";
			   }
			}else if(state==4){
				msg.setUserb(userb);
				flag = msgService.insertMsg(msg);
				if (flag > 0) {
					tips = "成功";
				} else {
					tips = "失败";
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
	 * 同意或拒绝对方的好友申请后，修改该好友申请信息的status，同意1，拒绝0
	 * @param msg
	 * @return
	 */
	@RequestMapping("/user_agreeOrNotAddFriend")
	@ResponseBody
	public Map<String, Object> user_agreeOrNotAddFriend(Msg msg) {
		String tips="";
		int flag=0;
		flag=msgService.updateMsgStatus(msg);
		if(flag>0){
		   tips="成功";
		}else{
		   tips="失败";	
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 获取当前用户未查看信息的个数
	 * @param session
	 * @return
	 */
	@RequestMapping("/user_getMsgCount")
	@ResponseBody
	public Map<String, Object> user_getMsgCount(HttpSession session) {
		int count=0;
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
		if(userb!=null){
			count=msgService.selectMsgCount(userb);
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("userb", userb);
		modelMap.put("count", count);
		return modelMap;
	}
	
	/**
	 * 前台用户将信息关闭即将信息标记为已读，看不到该信息
	 * @param msg
	 * @return
	 */
	@RequestMapping("/user_closeMsg")
	@ResponseBody
	public Map<String, Object> user_closeMsg(Msg msg) {
		String tips="";
		int flag=0;
		flag=msgService.updateMsgMark(msg);
		if(flag>0){
		   tips="成功";
		}else{
		   tips="失败";	
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台管理获取短信息,
	 * 还可以根据不同条件来查询相对应的短信息
	 * 分页
	 * @param name
	 * @return
	 */
	@RequestMapping("/admin_selectMsgtList")
	@ResponseBody
	public Map<String, Object> admin_selectMsgtList(String page,String rows,MsgCondition msgCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("msgCondition", msgCondition);
		List<Msg> msgList = this.msgService.selectMsgByCondition(map);
		int total = this.msgService.getTotal(msgCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(msgList!=null){
			modelMap.put("rows",msgList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台添加短信息
	 * @param userb
	 * @return
	 */
	@RequestMapping(value="/admin_insertMsg",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理添加新的短信息")
	public Map<String, Object> admin_insertMsg(Msg msg) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
			int count=this.msgService.insertMsg(msg);
			if(count>0){
				tips="成功";
			}else{
				tips="失败";
			}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台删除短信息	
     * @param msg
     * @param mids
     * @return
     */
	@RequestMapping(value="/admin_deleteMsg",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理删除短信息")
	public Map<String,Object> admin_deleteMsg(Msg msg,String mids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] midStr = mids.split(",");
        for (String mid : midStr) {
        	msg.setMid(Integer.parseInt(mid));
            count = this.msgService.deleteMsg(msg);
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
	
    /**
     * 获取对应的phone列表	
     * @param mids
     * @return
     */
	@RequestMapping(value="/wx_getPhoneList",method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> wx_getPhoneList(String pname){
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<Phone> phoneList = this.msgService.selectPhoneList(pname);
		Map<String, Object> modelMap1 = new HashMap<String, Object>();
//		modelMap1.put("", value)
		modelMap.put("phoneList", phoneList);
		return modelMap;
	}
}
