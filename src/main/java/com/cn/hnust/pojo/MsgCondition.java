package com.cn.hnust.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MsgCondition {

	private Integer bid;
	
	private String mcontent;
	
	private Integer sendto;
	
	private Integer status;
	
	private Integer mark;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
    private Date msgStart ;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date msgEnd ;

	public Integer getBid() {
		return bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}

	public Integer getSendto() {
		return sendto;
	}

	public void setSendto(Integer sendto) {
		this.sendto = sendto;
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

	public String getMcontent() {
		return mcontent;
	}

	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}


	public Date getMsgStart() {
		return msgStart;
	}

	public void setMsgStart(Date msgStart) {
		this.msgStart = msgStart;
	}

	public Date getMsgEnd() {
		return msgEnd;
	}

	public void setMsgEnd(Date msgEnd) {
		this.msgEnd = msgEnd;
	}
    
}
