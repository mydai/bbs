package com.cn.hnust.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ThemeCondition {
    private String tname;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createStart ;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createEnd ;

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public Date getCreateStart() {
		return createStart;
	}

	public void setCreateStart(Date createStart) {
		this.createStart = createStart;
	}

	public Date getCreateEnd() {
		return createEnd;
	}

	public void setCreateEnd(Date createEnd) {
		this.createEnd = createEnd;
	}
    
}
