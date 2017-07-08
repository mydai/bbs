package com.cn.hnust.pojo;

import java.io.Serializable;

public class Phone implements Serializable{

	private Integer pid ;
	
	private String pname;
	
	private String pnumber;

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPnumber() {
		return pnumber;
	}

	public void setPnumber(String pnumber) {
		this.pnumber = pnumber;
	}
	
	
}
