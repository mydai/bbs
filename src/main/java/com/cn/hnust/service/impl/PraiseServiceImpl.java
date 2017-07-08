package com.cn.hnust.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.PraiseMapper;
import com.cn.hnust.pojo.Praise;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IPraiseService;

@Service
public class PraiseServiceImpl implements IPraiseService {


	@Resource
	private PraiseMapper praiseMapper;
	
	@Override
	public int clickPraise(Praise praise) {
		praiseMapper.clickPraise(praise);
		return praise.getStatus();
	}

	@Override
	public List<Praise> selectPraiseList(Userb userb) {
		return praiseMapper.selectPraiseList(userb);
	}

	@Override
	public int updatePraiseMark(Praise praise) {
		return praiseMapper.updatePraiseMark(praise);
	}
    
	
}
