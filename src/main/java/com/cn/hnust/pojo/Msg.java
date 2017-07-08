package com.cn.hnust.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

public class Msg implements Serializable{
    private Integer mid;

    private Userb userb;

    private String title;

    private String mcontent;

    private Integer status;

    private Integer sendto;

    private Date senddate;
    
    private Integer mark;
    
//    private Friend friend;
    
    private List<Friend> friend = new ArrayList<Friend>(0);

    public Integer getMid() {
		return mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	public Userb getUserb() {
		return userb;
	}

	public void setUserb(Userb userb) {
		this.userb = userb;
	}

	public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getMcontent() {
        return mcontent;
    }

    public void setMcontent(String mcontent) {
        this.mcontent = mcontent == null ? null : mcontent.trim();
    }

    public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getSendto() {
		return sendto;
	}

	public void setSendto(Integer sendto) {
		this.sendto = sendto;
	}

	public Date getSenddate() {
        return senddate;
    }

    public void setSenddate(Date senddate) {
        this.senddate = senddate;
    }

	public Integer getMark() {
		return mark;
	}

	public void setMark(Integer mark) {
		this.mark = mark;
	}

	public List<Friend> getFriend() {
		return friend;
	}

	public void setFriend(List<Friend> friend) {
		this.friend = friend;
	}

}