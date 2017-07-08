package com.cn.hnust.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

public class Postings implements Serializable{
	private Integer pid ;

	private String title;

	private String praisenum="0";

	private String replynum="0";

	private Date publishtime;

	private Date lasttime;

	private String pcontent;

	private Userb userb;

	private List<Details> details = new ArrayList<Details>(0);

	private List<Postings_Theme> postings_theme = new ArrayList<Postings_Theme>(
			0);
	private List<Praise> praise = new ArrayList<Praise>();

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = (title == null ? null : title.trim());
	}

	public String getPraisenum() {
		return praisenum;
	}

	public void setPraisenum(String praisenum) {
		this.praisenum = praisenum == null ? null : praisenum.trim();
	}

	public String getReplynum() {
		return replynum;
	}

	public void setReplynum(String replynum) {
		this.replynum = replynum == null ? null : replynum.trim();
	}

	public Date getPublishtime() {
		return publishtime;
	}

	public void setPublishtime(Date publishtime) {
		this.publishtime = publishtime;
	}

	public Date getLasttime() {
		return lasttime;
	}

	public void setLasttime(Date lasttime) {
		this.lasttime = lasttime;
	}

	public Userb getUserb() {
		return userb;
	}

	public void setUserb(Userb userb) {
		this.userb = userb;
	}

	public String getPcontent() {
		return pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent == null ? null : pcontent.trim();
	}

	public List<Details> getDetails() {
		return details;
	}

	public void setDetails(List<Details> details) {
		this.details = details;
	}

	public List<Postings_Theme> getPostings_theme() {
		return postings_theme;
	}

	public void setPostings_theme(List<Postings_Theme> postings_theme) {
		this.postings_theme = postings_theme;
	}

	public List<Praise> getPraise() {
		return praise;
	}

	public void setPraise(List<Praise> praise) {
		this.praise = praise;
	}
	
	
}