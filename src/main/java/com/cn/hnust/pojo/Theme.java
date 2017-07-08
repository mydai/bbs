package com.cn.hnust.pojo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

public class Theme implements Serializable{
	private Integer tid;

	private String tname;

	private Date createtime;

	public Integer getTid() {
		return tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname == null ? null : tname.trim();
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	
}