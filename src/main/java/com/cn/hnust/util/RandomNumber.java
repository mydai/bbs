package com.cn.hnust.util;

public class RandomNumber {
	/**
	 * 获取随机6位验证码
	 * @return
	 */
	public static String getRandomNumber(){
		StringBuffer sb = new StringBuffer();
		for(int i =0;i<6;i++){
			int round = (int)(Math.random()*9);
			sb.append(round);
		}
		return sb.toString();
	}
}
