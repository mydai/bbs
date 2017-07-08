package com.cn.hnust.pojo;

import java.io.Serializable;
import java.sql.Date;

public class Userb implements Serializable {

	private Integer bid;

	private String name;

	private String pass;

	private String email ;

	private String img ;

	private String phone;

	private String intro;

	private String validatecode;

	private Integer status;

	private Date registertime;

	private Date lasttime;

	private int tid;

	private int hid;

	public Userb() {
	}

	public Userb(String name, String pass, String email, String validatecode) {
		super();
		this.name = name;
		this.pass = pass;
		this.email = email;
		this.validatecode = validatecode;
	}

	public Integer getBid() {
		return bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass == null ? null : pass.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
		this.email = email == null ? null : email.trim();
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
//		this.img = img;
		this.img = img == null ? null : img.trim();
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone == null ? null : phone.trim();
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getValidatecode() {
		return validatecode;
	}

	public void setValidatecode(String validatecode) {
		this.validatecode = validatecode == null ? null : validatecode.trim();
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getRegistertime() {
		return registertime;
	}

	public void setRegistertime(Date registertime) {
		this.registertime = registertime;
	}

	public Date getLasttime() {
		return lasttime;
	}

	public void setLasttime(Date lasttime) {
		this.lasttime = lasttime;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public int getHid() {
		return hid;
	}

	public void setHid(int hid) {
		this.hid = hid;
	}

}