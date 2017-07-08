package com.cn.hnust.service;

import java.util.List;
import java.util.Map;

import com.cn.hnust.pojo.Admin;
import com.cn.hnust.pojo.AdminCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.pojo.UserbCondition;

public interface IAdminService {

	/**
	 * 管理员登录
	 * @param admin
	 * @return
	 */
	public abstract Admin selectAdmin(Admin admin);
    
	/**
	 * 通过管理员的一些信息来获取管理员全部信息
	 * @param admin
	 * @return
	 */
	public abstract Admin selectAdminByProperty(Admin admin);
	
	/**
	 * 修改管理员信息
	 * @param admin
	 * @return
	 */
	public abstract int updateAdminByProperty(Admin admin);
	
	/**
	 * 根据不同条件查询管理员信息同时分页
	 * @param map
	 * @return
	 */
	public abstract List<Admin> selectAdminByCondition(Map<String, Object> map);
	
	/**
     * 获取管理员总记录数
     * @param map
     * @return获取的total数
     */
    public abstract int getTotal(AdminCondition adminCondition);
    
    /**
     * 后台管理添加新管理员
     * @param admin
     * @return
     */
    public abstract int insertAdmin(Admin admin);
    
    /**
     * 后台管理删除管理员
     * @param admin
     * @return
     */
    public abstract int deleteAdmin(Admin admin);
    
    /**
     * 后台管理获取全部统计记录数，用户人数,帖子数,回答数,评论数,短信息数,获赞数
     * @return
     */
    public abstract List<Integer> selectAllCount();
}
