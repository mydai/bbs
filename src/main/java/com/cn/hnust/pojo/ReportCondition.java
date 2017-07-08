package com.cn.hnust.pojo;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

public class ReportCondition {
    private String rcontent;
    
    private Integer bid;
    
    private Integer pid;
    
    private Integer did;
    
    private Integer cid;
    
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date reportStart ;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date reportEnd ;

	public String getRcontent() {
		return rcontent;
	}

	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	
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

	public Integer getDid() {
		return did;
	}

	public void setDid(Integer did) {
		this.did = did;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public Date getReportStart() {
		return reportStart;
	}

	public void setReportStart(Date reportStart) {
		this.reportStart = reportStart;
	}

	public Date getReportEnd() {
		return reportEnd;
	}

	public void setReportEnd(Date reportEnd) {
		this.reportEnd = reportEnd;
	}

}
