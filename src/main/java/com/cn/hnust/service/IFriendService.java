package com.cn.hnust.service;

import java.util.List;
import java.util.Map;

import com.cn.hnust.pojo.Friend;
import com.cn.hnust.pojo.Postings;
import com.cn.hnust.pojo.Userb;

public interface IFriendService {

	  /**
	   * 添加好友
	   * @param userb
	   * @return
	   */
	  public abstract int insertFriend(Friend friend);
	  
	  /**
	   * 检查用户的好友是否存在
	   * @param friend
	   * @return
	   */
	  public abstract int selectFriend(Friend friend);
	  
	  /**
	   * 获取当前登录用户的所有好友列表
	   * @param friend
	   * @return
	   */
	  public abstract List<Friend> selectFriendList(Friend friend);
	  
	  /**
 	   * 根据当前登录用户id和该用户好友Id来删除两者好友关系
	   * @param friend
	   * @return
	   */
	  public abstract int deleteFriend(Friend friend);
	  
	  /**
	   * 更新好友表的好友信息，此处主要为修改好友备注
	   * @param friend
	   * @return
	   */
	  public abstract int updateFriend(Friend friend);
	  
	  /**
	   * 获取当前用户所有好友的全部动态
	   * @param userb
	   * @return
	   */
	  public abstract List<Postings> selectFriendTrendsList(Friend friend);
}
