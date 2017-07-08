package com.cn.hnust.service.impl;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.DetailsMapper;
import com.cn.hnust.pojo.Details;
import com.cn.hnust.pojo.DetailsCondition;
import com.cn.hnust.service.IDetailsService;

@Service("detailsService")
public class DetailsServiceImpl implements IDetailsService {

	@Resource
	private DetailsMapper detailsMapper;
	
	@Override
	public Details insertDetails(Details details) {
		details.setDid(0);
		details.setReplynum("0");
		details.setPraisenum("0");
		details.setReplytime(new Date(0));
		detailsMapper.insertDetails(details);
		return details;
	}

	@Override
	public List<Details> selectDetailsByCondition(Map<String, Object> map) {
		return detailsMapper.selectDetailsByCondition(map);
	}

	@Override
	public int getTotal(DetailsCondition detailsCondition) {
		return detailsMapper.getTotal(detailsCondition);
	}

	@Override
	public int insertDetailsByProperty(Details details) {
		return detailsMapper.insertDetailsByProperty(details);
	}

	@Override
	public int deleteDetails(Details details) {
		return detailsMapper.deleteDetails(details);
	}

	@Override
	public int updateDetails(Details details) {
		return detailsMapper.updateDetails(details);
	}

}
