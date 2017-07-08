package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.AdminMapper;
import com.cn.hnust.pojo.Admin;
import com.cn.hnust.pojo.AdminCondition;
import com.cn.hnust.service.IAdminService;

@Service("adminService")
public class AdminServiceImpl implements IAdminService {

	@Resource
	private AdminMapper adminMapper;

	@Override
	public Admin selectAdmin(Admin admin) {
		return adminMapper.selectAdmin(admin);
	}

	@Override
	public Admin selectAdminByProperty(Admin admin) {
		return adminMapper.selectAdminByProperty(admin);
	}

	@Override
	public int updateAdminByProperty(Admin admin) {
		return adminMapper.updateAdminByProperty(admin);
	}

	@Override
	public List<Admin> selectAdminByCondition(Map<String, Object> map) {
		return adminMapper.selectAdminByCondition(map);
	}

	@Override
	public int getTotal(AdminCondition adminCondition) {
		return adminMapper.getTotal(adminCondition);
	}

	@Override
	public int insertAdmin(Admin admin) {
		return adminMapper.insertAdmin(admin);
	}

	@Override
	public int deleteAdmin(Admin admin) {
		return adminMapper.deleteAdmin(admin);
	}

	@Override
	public List<Integer> selectAllCount() {
		return adminMapper.selectAllCount();
	}
	
}
