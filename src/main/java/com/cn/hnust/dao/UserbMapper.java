package com.cn.hnust.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cn.hnust.pojo.Userb;
import com.cn.hnust.pojo.UserbCondition;

@Repository
public interface UserbMapper {

	/**
	 * 用户登录方法,传入用户对象，返回用户对象
	 * 
	 * @param userb
	 * @return Userb
	 */
	public abstract Userb selectUserb(Userb userb);

	/**
	 * 传入用户name，通过此属性查询用户信息
	 * 
	 * @param userb
	 * @return Userb
	 */
	public abstract Userb selectUserbByProperty(Userb userb);

	/**
	 * 传入用户id,修改用户密码
	 * 
	 * @param userb
	 * @return int
	 */
	public abstract int updateUserbByProperty(Userb userb);
	
	/**
	 * 传入用户信息，进行注册
	 * @param userb
	 * @return int
	 */
	public abstract int insertUserbByProperty(Userb userb);
	
	/**
	 * 传入用户信息，将用户的status由0更新为1，激活邮箱
	 * @param userb
	 * @return
	 */
	public abstract int updateStatusByProperty(Userb userb);
	
	/**
	 * 用户姓名ajax动态模糊查询，获取所有符合条件的name
	 * @param userb
	 * @return 返回name集合
	 */
	public abstract List<String> selectNameList(String name);
	
	/**
	 * 个人中心获取用户所有的信息的个数(帖子数，回答数，评论数，短信息数，获赞总数，投诉数)
	 * @param userb
	 * @return
	 */
	public abstract List<Integer> selectAllCount(Userb userb);
	
	/**
	 * 后台管理获取所有用户的列表
	 * @return
	 */
	public abstract List<Userb> selectUserbList();
	
	/**
	 * 后台管理删除用户
	 * @param userb
	 * @return
	 */
	public abstract int deleteUserb(Userb userb);
	
	/**
	 * 根据不同条件查询用户信息同时分页
	 * @param map
	 * @return
	 */
	public abstract List<Userb> selectUserbByCondition(Map<String, Object> map);
	
	/**
     * 获取用户总记录数
     * @param map
     * @return获取的total数
     */
    public abstract int getTotal(UserbCondition userbCondition);
	
}