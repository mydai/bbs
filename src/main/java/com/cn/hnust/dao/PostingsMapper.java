package com.cn.hnust.dao;

import java.util.List;
import java.util.Map;

import com.cn.hnust.pojo.Postings;
import com.cn.hnust.pojo.PostingsCondition;
import com.cn.hnust.pojo.Report;
import com.cn.hnust.pojo.ReportCondition;
import com.cn.hnust.pojo.Theme;
import com.cn.hnust.pojo.ThemeCondition;
import com.cn.hnust.pojo.Userb;

public interface PostingsMapper {
	
	/**
	 * 通过帖子pid获取该帖子所有信息
	 * @param pid
	 * @return
	 */
	public abstract Postings selectPostingsById(int pid);

	/**
	 * 传入帖子部分属性，查询相关帖子信息，此处主要是在插入帖子之前查询是否重复，
	 * @param postings
	 * @return
	 */
    public abstract Postings selectPostingsByProperty(Postings postings);
	
	/**
	 * 插入一条帖子
	 * @param postings
	 * @return
	 */
	public abstract int insertPostings(Postings postings);
	
	/**
	 * 获取所有的帖子的列表list
	 * @return
	 */
	public abstract List<Postings> selectPostingsList();
	
	/**
	 * 获取当前用户所有的帖子信息
	 * @param userb
	 * @return
	 */
    public abstract List<Postings> selectPostings(Userb userb);
	
	/**
	 * 根据不同条件查询帖子同时分页
	 * @param map
	 * @return
	 */
	public abstract List<Postings> selectPostingsByCondition(Map<String, Object> map);
	
	/**
     * 获取帖子总记录数
     * @param map
     * @return获取的total数
     */
    public abstract int getTotal(PostingsCondition postingsCondition);
    
    /**
     * 后台管理添加新帖子
     * @param postings
     * @return
     */
    public abstract int insertPostingsByProperty(Postings postings);
    
    /**
     * 后台管理删除帖子
     * @param postings
     * @return
     */
    public abstract int deletePostings(Postings postings);
    
    /**
     * 后台管理更新帖子信息
     * @param postings
     * @return
     */
    public abstract int updatePostings(Postings postings);
    
    /**
     * 传入帖子的标题名，模糊查询出相关的帖子标题
     * @param title
     * @return
     */
    public abstract List<Postings> selectTitleList(String title);
    
    
    
    
    
    
    
    
	
    int deleteByPrimaryKey(Long pid);

    int insert(Postings record);

    int insertSelective(Postings record);

    Postings selectByPrimaryKey(Long pid);

    int updateByPrimaryKeySelective(Postings record);

    int updateByPrimaryKeyWithBLOBs(Postings record);

    int updateByPrimaryKey(Postings record);
}