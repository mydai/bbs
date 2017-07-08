package com.cn.hnust.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

public class Details implements Serializable{
    private Integer did ;
    
	private String praisenum="0";

	private String replynum="0";

    private Date replytime;

    private Long floor;

    private String dcontent;
    
    private Userb userb;
    
    private Postings postings;
    
    private List<Comments> comments = new ArrayList<Comments>(0);
    
    private List<Praise> praise = new ArrayList<Praise>();
    
    /**
     * private Integer replydid;
     * 
     * private Details replyDetails;//该回复属于楼中楼里的，该字段记录所回复的当前楼的信息
     * 
     *  private List<Details> details = new ArrayList<Details>(0);//该字段记录所有对于该楼的回复
     */
    
    public Integer getDid() {
		return did;
	}

	public void setDid(Integer did) {
		this.did = did;
	}

	public String getPraisenum() {
		return praisenum;
	}

	public void setPraisenum(String praisenum) {
		this.praisenum = praisenum;
	}

	public String getReplynum() {
		return replynum;
	}

	public void setReplynum(String replynum) {
		this.replynum = replynum;
	}

	public Date getReplytime() {
        return replytime;
    }

    public void setReplytime(Date replytime) {
        this.replytime = replytime;
    }

    public Long getFloor() {
        return floor;
    }

    public void setFloor(Long floor) {
        this.floor = floor;
    }
    
	public String getDcontent() {
        return dcontent;
    }

    public void setDcontent(String dcontent) {
        this.dcontent = dcontent == null ? null : dcontent.trim();
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

	public List<Comments> getComments() {
		return comments;
	}

	public void setComments(List<Comments> comments) {
		this.comments = comments;
	}

	public List<Praise> getPraise() {
		return praise;
	}

	public void setPraise(List<Praise> praise) {
		this.praise = praise;
	}
	
	
}