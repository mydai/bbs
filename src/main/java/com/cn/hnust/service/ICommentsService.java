package com.cn.hnust.service;

import java.util.List;
import java.util.Map;

import com.cn.hnust.pojo.CommentsCondition;
import com.cn.hnust.pojo.Details;
import com.cn.hnust.pojo.Comments;
import com.cn.hnust.pojo.Theme;

public interface ICommentsService {
    
	  /**
	   * 获取对于不同楼层的回复列表
	   * @return
	   */
	  public abstract List<Comments> selectCommentsList(Details details);
	  
	  /**
	   * 插入评论
	   * @return
	   */
	  public abstract int insertComments(Comments comments);
	  
	  /**
	   * 根据不同条件查询评论信息同时分页
	   * @param map
	   * @return
	   */
	  public abstract List<Comments> selectCommentsByCondition(Map<String, Object> map);
	
	  /**
       * 获取评论总记录数
       * @param map
       * @return获取的total数
       */
      public abstract int getTotal(CommentsCondition commentsCondition);
    
      /**
       * 后台评论添加新主题
       * @param comments
       * @return
       */
      public abstract int insertCommentsByProperty(Comments comments);
    
      /**
       * 后台管理删除评论
       * @param comments
       * @return
       */
      public abstract int deleteComments(Comments comments);
    
      /**
       * 后台管理更新评论信息
       * @param comments
       * @return
       */
      public abstract int updateComments(Comments comments);
	  
}
