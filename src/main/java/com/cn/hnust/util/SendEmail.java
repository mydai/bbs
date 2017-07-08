package com.cn.hnust.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import com.cn.hnust.pojo.MailSend;
import com.cn.hnust.pojo.Userb;

public class SendEmail {

	public static String sendValidateCode(String email)
			throws MessagingException, IOException {
		String number = RandomNumber.getRandomNumber();
		Map<String, String> map = new HashMap<String, String>();
		// 邮箱账号密码
		MailSend mail = new MailSend("476373207@qq.com", "ursphmexidsbbjhj");
		map.put("mail.smtp.host", "smtp.qq.com");

		// 暂时未成功，需要调试
		/*
		 * SendMail mail = new SendMail("14789****@sina.cn","***miya");
		 * map.put("mail.smtp.host", "smtp.sina.com");
		 */
		map.put("mail.smtp.auth", "true");
		map.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		map.put("mail.smtp.port", "465");
		map.put("mail.smtp.socketFactory.port", "465");
		mail.setPros(map);
		mail.initMessage();
		/*
		 * 添加收件人有三种方法： 1,单人添加(单人发送)调用setRecipient(str);发送String类型
		 * 2,多人添加(群发)调用setRecipients(list);发送list集合类型
		 * 3,多人添加(群发)调用setRecipients(sb);发送StringBuffer类型
		 */
		List<String> list = new ArrayList<String>();
		// list.add("****@qq.com");
		// list.add("***92@sina.cn");
		list.add(email);
		mail.setRecipients(list);
		/*
		 * String defaultStr =
		 * "283942930@qq.com,429353942@qq.com,2355663819@qq.com,381766286@qq.com;
		 * StringBuffer sb = new StringBuffer(); sb.append(defaultStr);
		 * sb.append(",316121113@qq.com"); mail.setRecipients(sb);
		 */
		mail.setSubject("修改密码");
		// mail.setText("谢谢合作");
		mail.setDate(new Date());
		mail.setFrom("呆呆娱乐");
		// mail.setMultipart("D:你你你.txt");
		mail.setContent("验证码为： " + RandomNumber.getRandomNumber()
				+ " ,请在5分钟内填写,无需回复", "text/html; charset=UTF-8");
		/*
		 * List<String> fileList = new ArrayList<String>();
		 * fileList.add("D:1.jpg"); fileList.add("D:activation.zip");
		 * fileList.add("D:dstz.sql"); fileList.add("D:软件配置要求.doc");
		 * mail.setMultiparts(fileList);
		 */
		System.out.println(mail.sendMessage());
		return number;
	}

	public static void sendActivationLink(String email, String mod)
			throws MessagingException, IOException {

		Map<String, String> map = new HashMap<String, String>();
		// 邮箱账号密码
		MailSend mail = new MailSend("476373207@qq.com", "ursphmexidsbbjhj");
		map.put("mail.smtp.host", "smtp.qq.com");
		map.put("mail.smtp.auth", "true");
		map.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		map.put("mail.smtp.port", "465");
		map.put("mail.smtp.socketFactory.port", "465");
		mail.setPros(map);
		mail.initMessage();
		List<String> list = new ArrayList<String>();
		list.add(email);
		mail.setRecipients(list);
		mail.setSubject("呆呆短信息论坛注册邮箱激活链接");
		mail.setDate(new Date());
		mail.setFrom("呆呆娱乐");
		mail.setContent(
				"论坛邮箱激活 <br><br>"
						+ "您收到这封邮件，是由于在呆呆短信息论坛注册时使用了这个邮箱地址。如果您并没有访问过呆呆短信息论坛，或没有进行上述操作，请忽 略这封邮件。您不需要退订或进行其他进一步的操作。<br><br>"
						+ "----------------------------------------------------------------------<br><br>"
						+ "点击下列链接激活您的账号邮箱来完成注册<br><br>"
						+ mod
						+"<br><br>(如果上面不是链接形式或者QQ邮箱不允许打开，请将该地址手工粘贴到浏览器地址栏再访问)"
						+ "<br>----------------------------------------------------------------------<br><br>"
						+ "此致<br>" + "呆呆娱乐", "text/html; charset=UTF-8");
		System.out.println(mail.sendMessage());
	}

}