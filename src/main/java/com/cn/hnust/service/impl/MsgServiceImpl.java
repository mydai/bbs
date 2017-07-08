package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import sun.applet.resources.MsgAppletViewer;

import com.cn.hnust.dao.MsgMapper;
import com.cn.hnust.pojo.Msg;
import com.cn.hnust.pojo.MsgCondition;
import com.cn.hnust.pojo.Phone;
import com.cn.hnust.pojo.Report;
import com.cn.hnust.pojo.ReportCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IMsgService;

@Service("msgService")
public class MsgServiceImpl implements IMsgService {

	@Resource
	private MsgMapper msgMapper;

	@Override
	public List<Msg> selectMsgList(Userb userb) {
		return msgMapper.selectMsgList(userb);
	}

	@Override
	public int insertMsg(Msg msg) {
		return msgMapper.insertMsg(msg);
	}

	@Override
	public int selectMsgCount(Userb userb) {
		return msgMapper.selectMsgCount(userb);
	}

	@Override
	public int updateMsgStatus(Msg msg) {
		return msgMapper.updateMsgStatus(msg);
	}

	@Override
	public int updateMsgMark(Msg msg) {
		return msgMapper.updateMsgMark(msg);
	}

	@Override
	public List<Msg> selectMsgByCondition(Map<String, Object> map) {
		return msgMapper.selectMsgByCondition(map);
	}

	@Override
	public int getTotal(MsgCondition msgCondition) {
		return msgMapper.getTotal(msgCondition);
	}

	@Override
	public int deleteMsg(Msg msg) {
		return msgMapper.deleteMsg(msg);
	}

	@Override
	public List<Phone> selectPhoneList(String pname) {
		return msgMapper.selectPhoneList(pname);
	}

	
}
