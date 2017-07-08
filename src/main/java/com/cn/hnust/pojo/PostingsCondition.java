package com.cn.hnust.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PostingsCondition {

	private Integer bid;
	
	private String title;
	
	private String pcontent;
	
	private Integer praisenum;
	
	private Integer replynum;
	
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date publishStart ;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date publishEnd ;

	public Integer getBid() {
		return bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPcontent() {
		return pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public Integer getPraisenum() {
		return praisenum;
	}

	public void setPraisenum(Integer praisenum) {
		this.praisenum = praisenum;
	}

	public Integer getReplynum() {
		return replynum;
	}

	public void setReplynum(Integer replynum) {
		this.replynum = replynum;
	}

	public Date getPublishStart() {
		return publishStart;
	}

	public void setPublishStart(Date publishStart) {
		this.publishStart = publishStart;
	}

	public Date getPublishEnd() {
		return publishEnd;
	}

	public void setPublishEnd(Date publishEnd) {
		this.publishEnd = publishEnd;
	}

}
