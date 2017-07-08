package com.cn.hnust.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CommentsCondition {

	private Integer bid;
	
	private Integer did;
	
	private String ccontent;
	
	private Integer praiseStart;
	
	private Integer praiseEnd;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
    private Date replyStart ;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date replyEnd ;

	public Integer getBid() {
		return bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
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

	public Integer getPraiseStart() {
		return praiseStart;
	}

	public void setPraiseStart(Integer praiseStart) {
		this.praiseStart = praiseStart;
	}

	public Integer getPraiseEnd() {
		return praiseEnd;
	}

	public void setPraiseEnd(Integer praiseEnd) {
		this.praiseEnd = praiseEnd;
	}

	public Date getReplyStart() {
		return replyStart;
	}

	public void setReplyStart(Date replyStart) {
		this.replyStart = replyStart;
	}

	public Date getReplyEnd() {
		return replyEnd;
	}

	public void setReplyEnd(Date replyEnd) {
		this.replyEnd = replyEnd;
	}
    
}
