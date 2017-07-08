package com.cn.hnust.pojo;

import java.io.Serializable;
import java.sql.Date;

public class Log implements Serializable{
    private Integer lid;
    
    private Admin admin;
    
    private Userb userb;
	
    private Date createdate;

    private String operation="";

    private String requestip="";

    private String content="";
    
    public Integer getLid() {
		return lid;
	}

	public void setLid(Integer lid) {
		this.lid = lid;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public Userb getUserb() {
		return userb;
	}

	public void setUserb(Userb userb) {
		this.userb = userb;
	}

	public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation == null ? null : operation.trim();
    }

    public String getRequestip() {
        return requestip;
    }

    public void setRequestip(String requestip) {
        this.requestip = requestip == null ? null : requestip.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}