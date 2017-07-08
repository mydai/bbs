package com.cn.hnust.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

public class Praise implements Serializable{
    private Integer sid;

    private Date pushtime;

    private Userb userb;
    
    private Postings postings;
    
    private Details details;
    
    private Comments comments;
    
    private List<Friend> friend = new ArrayList<Friend>(0);
    
//    private Integer bid;
//
//    private Integer pid=0;
//    
//    private Integer did=0;
//    
//    private Integer cid=0;

    private Integer status=-1;
    
    private Integer mark;

	public Integer getSid() {
		return sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public Date getPushtime() {
        return pushtime;
    }

    public void setPushtime(Date pushtime) {
        this.pushtime = pushtime;
    }

	public Userb getUserb() {
		return userb;
	}

	public void setUserb(Userb userb) {
		this.userb = userb;
	}

	public Postings getPostings() {
		return postings;
	}

	public void setPostings(Postings postings) {
		this.postings = postings;
	}

	public Details getDetails() {
		return details;
	}

	public void setDetails(Details details) {
		this.details = details;
	}

	public Comments getComments() {
		return comments;
	}

	public void setComments(Comments comments) {
		this.comments = comments;
	}

	public List<Friend> getFriend() {
		return friend;
	}

	public void setFriend(List<Friend> friend) {
		this.friend = friend;
	}

	public Integer getStatus() {
        return status;
    }

	public void setStatus(Integer status) {
        this.status = status;
    }

	public Integer getMark() {
		return mark;
	}

	public void setMark(Integer mark) {
		this.mark = mark;
	}
	
//    public Integer getBid() {
//		return bid;
//	}
//
//	public void setBid(Integer bid) {
//		this.bid = bid;
//	}
//
//	public Integer getPid() {
//		return pid;
//	}
//
//	public void setPid(Integer pid) {
//		this.pid = pid;
//	}
//
//	public Integer getDid() {
//		return did;
//	}
//
//	public void setDid(Integer did) {
//		this.did = did;
//	}
//
//	public Integer getCid() {
//		return cid;
//	}
//
//	public void setCid(Integer cid) {
//		this.cid = cid;
//	}

    
}