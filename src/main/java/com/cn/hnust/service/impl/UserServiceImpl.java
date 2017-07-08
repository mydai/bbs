package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.UserbMapper;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.pojo.UserbCondition;
import com.cn.hnust.service.IUserbService;

@Service("userService")
public class UserServiceImpl implements IUserbService {

	@Resource
	private UserbMapper userbMapper;

	@Override
	public Userb selectUserb(Userb userb) {
		return userbMapper.selectUserb(userb);
	}

	@Override
	public Userb selectUserbByProperty(Userb userb) {
		return userbMapper.selectUserbByProperty(userb);
	}

	@Override
	public int updateUserbByProperty(Userb userb) {
		return userbMapper.updateUserbByProperty(userb);
	}

	@Override
	public int insertUserbByProperty(Userb userb) {
		return userbMapper.insertUserbByProperty(userb);
	}

	@Override
	public int updateStatusByProperty(Userb userb) {
		return userbMapper.updateStatusByProperty(userb);
	}

	@Override
	public List<String> selectNameList(String name) {
		return userbMapper.selectNameList(name);
	}

	@Override
	public List<Userb> selectUserbList() {
		return userbMapper.selectUserbList();
	}

	@Override
	public List<Integer> selectAllCount(Userb userb) {
		return userbMapper.selectAllCount(userb);
	}
	
	public int deleteUserb(Userb userb) {
		return userbMapper.deleteUserb(userb);
	}
	
	@Override
	public List<Userb> selectUserbByCondition(Map<String, Object> map) {
		return userbMapper.selectUserbByCondition(map);
	}
	
	@Override
	public int getTotal(UserbCondition userbCondition) {
		return userbMapper.getTotal(userbCondition);
	}



	
	
}
