package com.cn.hnust.pojo;

import java.io.Serializable;

public class Friend implements Serializable{
    private Integer fid;

//	private Integer bid;
//    
//    private Integer friendid;
    
    private Userb userb;
    
    private Userb userf;
    
    private String remark;

	public Friend() {
		super();
	}

	public Integer getFid() {
		return fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public Userb getUserf() {
		return userf;
	}

	public void setUserf(Userb userf) {
		this.userf = userf;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Userb getUserb() {
		return userb;
	}

	public void setUserb(Userb userb) {
		this.userb = userb;
	}

 
}