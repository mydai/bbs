package com.cn.hnust.pojo;

import java.sql.Date;

public class Report {
    private Integer rid;

    private String rcontent;
    
    private Date reporttime;

    private Integer pid;

    private Integer bid;
    
    private Integer did;
    
    private Integer cid;


	public Integer getRid() {
		return rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	public String getRcontent() {
        return rcontent;
    }

    public void setRcontent(String rcontent) {
        this.rcontent = rcontent == null ? null : rcontent.trim();
    }

	public Date getReporttime() {
		return reporttime;
	}

	public void setReporttime(Date reporttime) {
		this.reporttime = reporttime;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

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

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}
    
    
}