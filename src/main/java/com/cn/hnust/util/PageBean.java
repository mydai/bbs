package com.cn.hnust.util;

public class PageBean {
	 private int page; // 第几页
	 private int pageSize; // 每页记录数
	 private int start;  // 起始页
	 
	 public PageBean(int page, int pageSize) {
        super();
        this.page = page;
        this.pageSize = pageSize;
     }
	    
	 
	 public int getPage() {
		return page;
	 }
	 
	 public void setPage(int page) {
		this.page = page;
	 }
	 
	 public int getPageSize() {
		return pageSize;
	 }
	 public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	 }
	 
	 public int getStart() {
		return start;
	 }
	 
	 public void setStart(int start) {
		this.start = start;
	 }
}
