package com.cn.hnust.pojo;

import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

public class Comments {
    private Integer cid ;

    private Date replytime;
    
    private String praisenum="0";

    private Userb userb;

    private Integer did;

    private String ccontent;
    
    private List<Praise> praise = new ArrayList<Praise>();

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public Date getReplytime() {
        return replytime;
    }

    public void setReplytime(Date replytime) {
        this.replytime = replytime;
    }

    public String getPraisenum() {
		return praisenum;
	}

	public void setPraisenum(String praisenum) {
		this.praisenum = praisenum;
	}

    public Userb getUserb() {
		return userb;
	}

	public void setUserb(Userb userb) {
		this.userb = userb;
	}

	public Integer getDid() {
		return did;
	}

	public void setDid(Integer did) {
		this.did = did;
	}

	public String getCcontent() {
		return ccontent;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

	public List<Praise> getPraise() {
		return praise;
	}

	public void setPraise(List<Praise> praise) {
		this.praise = praise;
	}
	

}