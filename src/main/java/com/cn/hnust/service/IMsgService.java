package com.cn.hnust.service;

import java.util.List;
import java.util.Map;

import com.cn.hnust.pojo.Msg;
import com.cn.hnust.pojo.MsgCondition;
import com.cn.hnust.pojo.Phone;
import com.cn.hnust.pojo.Report;
import com.cn.hnust.pojo.ReportCondition;
import com.cn.hnust.pojo.Userb;

public interface IMsgService {
	/**
	 * 通过传入当前用户信息，得到该用户的所有未读短信息集合
	 * 
	 * @param userb
	 * @return List<Msg>
	 */
	public abstract List<Msg> selectMsgList(Userb userb);
	
	/**
	 * 用户发送私信
	 * @param msg
	 * @return
	 */
	public abstract int insertMsg(Msg msg);
	
	/**
	 * 获取当前用户的未查看私信个数
	 * @param userb
	 * @return
	 */
	public abstract int selectMsgCount(Userb userb);
	
	/**
	 * 更新消息表中的status，
	 * 可将申请好友类型2更改为同意1，或拒绝0
	 * @return
	 */
	public abstract int updateMsgStatus(Msg msg);
	
	/**
	 * 更新消息表里的mark字段，0为未读，1为已读
	 * @param msg
	 * @return
	 */
	public abstract int updateMsgMark(Msg msg);
	
	/**
	 * 根据不同条件查询短信息同时分页
	 * @param map
	 * @return
	 */
	public abstract List<Msg> selectMsgByCondition(Map<String, Object> map);
	
	/**
     * 获取短信息总记录数
     * @param map
     * @return获取的total数
     */
    public abstract int getTotal(MsgCondition msgCondition);
	
    /**
     * 后台删除短信息
     * @param report
     * @return
     */
    public abstract int deleteMsg(Msg msg);
    
    /**
     * 微信小程序获取电话列表
     * @param phone
     * @return
     */
    public abstract List<Phone> selectPhoneList(String pname);
}
