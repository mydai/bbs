package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.FriendMapper;
import com.cn.hnust.pojo.Friend;
import com.cn.hnust.pojo.Postings;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.service.IFriendService;

@Service("friendService")
public class FriendServiceImpl implements IFriendService {

	@Resource
	private FriendMapper friendMapper;
	
	@Override
	public int insertFriend(Friend friend) {
		return friendMapper.insertFriend(friend);
	}

	@Override
	public int selectFriend(Friend friend) {
		return friendMapper.selectFriend(friend);
	}

	@Override
	public List<Friend> selectFriendList(Friend friend) {
		return friendMapper.selectFriendList(friend);
	}

	@Override
	public int deleteFriend(Friend friend) {
		return friendMapper.deleteFriend(friend);
	}

	@Override
	public int updateFriend(Friend friend) {
		return friendMapper.updateFriend(friend);
	}

	@Override
	public List<Postings> selectFriendTrendsList(Friend friend) {
		return friendMapper.selectFriendTrendsList(friend);
	}

}
