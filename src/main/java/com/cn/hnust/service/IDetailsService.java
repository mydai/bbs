package com.cn.hnust.service;

import java.util.List;
import java.util.Map;

import com.cn.hnust.pojo.Details;
import com.cn.hnust.pojo.DetailsCondition;

public interface IDetailsService {

	/**
	 * 插入一个回答
	 * @param details
	 * @return
	 */
	public abstract Details insertDetails(Details details);
	
	/**
	 * 根据不同条件查询回答信息同时分页
	 * @param map
	 * @return
	 */
	public abstract List<Details> selectDetailsByCondition(Map<String, Object> map);
	
	/**
     * 获取回答总记录数
     * @param map
     * @return获取的total数
     */
    public abstract int getTotal(DetailsCondition detailsCondition);
    
    /**
     * 后台管理添加新回答
     * @param details
     * @return
     */
    public abstract int insertDetailsByProperty(Details details);
    
    /**
     * 后台管理删除回答
     * @param details
     * @return
     */
    public abstract int deleteDetails(Details details);
    
    /**
     * 后台管理更新回答信息
     * @param theme
     * @return
     */
    public abstract int updateDetails(Details details);
}
