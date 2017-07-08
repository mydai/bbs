package com.cn.hnust.pojo;

import java.io.Serializable;

public class Postings_Theme implements Serializable{
    private Integer ptid;

    private Integer pid;

    private Theme theme;

    
   
	public Integer getPtid() {
		return ptid;
	}

	public void setPtid(Integer ptid) {
		this.ptid = ptid;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Theme getTheme() {
		return theme;
	}

	public void setTheme(Theme theme) {
		this.theme = theme;
	}

    
}