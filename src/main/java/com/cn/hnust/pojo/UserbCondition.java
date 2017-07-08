package com.cn.hnust.pojo;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.format.annotation.DateTimeFormat;

public class UserbCondition {
	
    private String name;
   
    private String email;
   
    private String phone;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date regStart ;
   
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date regEnd ;

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name.replace(" ", "");
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email.replace(" ", "");
	}

	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone.replace(" ", "");
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
