package com.cn.hnust.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class AdminCondition {
    private String name;
    
    private String email;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date regStart ;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date regEnd ;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getRegStart() {
		return regStart;
	}

	public void setRegStart(Date regStart) {
		this.regStart = regStart;
	}

	public Date getRegEnd() {
		return regEnd;
	}

	public void setRegEnd(Date regEnd) {
		this.regEnd = regEnd;
	}
    
}
