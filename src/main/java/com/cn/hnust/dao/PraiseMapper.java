package com.cn.hnust.dao;

import java.util.List;

import com.cn.hnust.pojo.Praise;
import com.cn.hnust.pojo.Userb;

public interface PraiseMapper {
	
	/**
	 * 帖子，回答，评论的点赞和撤赞功能
	 * @param praise
	 * @return
	 */
	public abstract int clickPraise(Praise praise);
	
	/**
	 * 获取用户被赞的信息
	 * @param userb
	 * @return
	 */
    public abstract List<Praise> selectPraiseList(Userb userb);
    
    /**
     * 更新消息表里的mark字段，0为未读，1为已读
     * @param praise
     * @return
     */
    public abstract int updatePraiseMark(Praise praise);
}