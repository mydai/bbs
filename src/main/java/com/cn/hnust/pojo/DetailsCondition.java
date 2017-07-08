package com.cn.hnust.pojo;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

public class DetailsCondition {

	private Integer bid;
	
	private Integer pid;
	
	private String dcontent;
	
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

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getDcontent() {
		return dcontent;
	}

	public void setDcontent(String dcontent) {
		this.dcontent = dcontent;
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
