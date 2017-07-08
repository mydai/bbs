package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.CommentsMapper;
import com.cn.hnust.pojo.Comments;
import com.cn.hnust.pojo.CommentsCondition;
import com.cn.hnust.pojo.Details;
import com.cn.hnust.pojo.Theme;
import com.cn.hnust.service.ICommentsService;

@Service("commentsService")
public class CommentsServiceImpl implements ICommentsService {

	@Resource
	private CommentsMapper commentsMapper;
	
	@Override
	public List<Comments> selectCommentsList(Details details) {
		return commentsMapper.selectCommentsList(details);
	}

	@Override
	public int insertComments(Comments comments) {
		comments.setCid(0);
		commentsMapper.insertComments(comments);
		return comments.getCid();
	}

	@Override
	public List<Comments> selectCommentsByCondition(Map<String, Object> map) {
		return commentsMapper.selectCommentsByCondition(map);
	}

	@Override
	public int getTotal(CommentsCondition commentsCondition) {
		return commentsMapper.getTotal(commentsCondition);
	}

	@Override
	public int insertCommentsByProperty(Comments comments) {
		return commentsMapper.insertCommentsByProperty(comments);
	}

	@Override
	public int deleteComments(Comments comments) {
		return commentsMapper.deleteComments(comments);
	}

	@Override
	public int updateComments(Comments comments) {
		return commentsMapper.updateComments(comments);
	}

}
