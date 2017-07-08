package com.cn.hnust.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class LogCondition {

	private Integer aid ;
	
	private Integer bid ;
	
	private String content;
	
	private String operation;
	
	private String requestip;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
    private Date logStart ;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date logEnd ;

	public Integer getAid() {
		return aid;
	}

	public void setAid(Integer aid) {
		this.aid = aid;
	}

	public Integer getBid() {
		return bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public String getRequestip() {
		return requestip;
	}

	public void setRequestip(String requestip) {
		this.requestip = requestip;
	}

	public Date getLogStart() {
		return logStart;
	}

	public void setLogStart(Date logStart) {
		this.logStart = logStart;
	}

	public Date getLogEnd() {
		return logEnd;
	}

	public void setLogEnd(Date logEnd) {
		this.logEnd = logEnd;
	}
    
}