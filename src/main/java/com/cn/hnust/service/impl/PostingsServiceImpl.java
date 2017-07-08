package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.PostingsMapper;
import com.cn.hnust.pojo.Postings;
import com.cn.hnust.pojo.PostingsCondition;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IPostingsService;

@Service("postingsService")
public class PostingsServiceImpl implements IPostingsService {
    
	@Resource
	private PostingsMapper postingsMapper;

	@Override
	public Postings selectPostingsById(int pid) {
		return postingsMapper.selectPostingsById(pid);
	}
	
	@Override
	public Postings selectPostingsByProperty(Postings postings) {
		return postingsMapper.selectPostingsByProperty(postings);
	}

	@Override
	public int insertPostings(Postings postings) {
		 postings.setPid(0);
		 postingsMapper.insertPostings(postings);
		 return postings.getPid();
	}

	@Override
	public List<Postings> selectPostingsList() {
		return postingsMapper.selectPostingsList();
	}
	
	@Override
	public List<Postings> selectTitleList(String title) {
		return postingsMapper.selectTitleList(title);
	}

	@Override
	public List<Postings> selectPostings(Userb userb) {
		return postingsMapper.selectPostings(userb);
	}
	
	@Override
	public List<Postings> selectPostingsByCondition(Map<String, Object> map) {
		return postingsMapper.selectPostingsByCondition(map);
	}

	@Override
	public int getTotal(PostingsCondition postingsCondition) {
		return postingsMapper.getTotal(postingsCondition);
	}

	@Override
	public int insertPostingsByProperty(Postings postings) {
		return postingsMapper.insertPostingsByProperty(postings);
	}

	@Override
	public int deletePostings(Postings postings) {
		return postingsMapper.deletePostings(postings);
	}

	@Override
	public int updatePostings(Postings postings) {
		return postingsMapper.updatePostings(postings);
	}


}
