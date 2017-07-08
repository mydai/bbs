package com.cn.hnust.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cn.hnust.aop.SystemControllerLog;
import com.cn.hnust.pojo.Admin;
import com.cn.hnust.pojo.AdminCondition;
import com.cn.hnust.service.IAdminService;
import com.cn.hnust.util.FinalConstant;
import com.cn.hnust.util.PageBean;
import com.cn.hnust.util.RandomNumber;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Resource
	private IAdminService adminService;

	/**
	 * 跳转到后台管理的admin_center页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_center")
	public String admin_center(HttpSession session) throws Exception {
		Admin admin = (Admin)session.getAttribute(FinalConstant.CURR_ADMIN);
		if(admin==null){
			return "../../admin_login";
		}
		return "admin_center";
	}
	
	/**
	 * 跳转到admin_left页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_left")
	public String admin_left() throws Exception {
		return "admin_left";
	}
	
    /**
     * 跳转到admin_right页面	
     * @return
     * @throws Exception
     */
	@RequestMapping("/admin_right")
	public String admin_right() throws Exception {
		return "admin_right";
	}
	
	/**
	 * 跳转到admin_top页面
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_top")
	public String admin_top(HttpSession session) throws Exception {
		Admin admin = (Admin)session.getAttribute(FinalConstant.CURR_ADMIN);
		if(admin!=null){
			
		}
		return "admin_top";
	}
	
	/**
	 * 跳转到admin_userManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_userbManage")
	public String admin_userbManage() throws Exception {
		return "admin_userbManage";
	}
	
	/**
	 * 跳转到admin_reportManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_reportManage")
	public String admin_reportManage() throws Exception {
		return "admin_reportManage";
	}
	
	/**
	 * 跳转到admin_msgManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_msgManage")
	public String admin_msgManage() throws Exception {
		return "admin_msgManage";
	}
	
	/**
	 * 跳转到admin_postingsManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_postingsManage")
	public String admin_postingsManage() throws Exception {
		return "admin_postingsManage";
	}
	
	/**
	 * 跳转到admin_detailsManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_detailsManage")
	public String admin_detailsManage() throws Exception {
		return "admin_detailsManage";
	}
	
	/**
	 * 跳转到admin_commentsManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_commentsManage")
	public String admin_commentsManage() throws Exception {
		return "admin_commentsManage";
	}
	
	/**
	 * 跳转到admin_themeManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_themeManage")
	public String admin_themeManage() throws Exception {
		return "admin_themeManage";
	}
	
	/**
	 * 跳转到admin_adminManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_adminManage")
	public String admin_adminManage() throws Exception {
		return "admin_adminManage";
	}
	
	/**
	 * 跳转到admin_logManage页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_logManage")
	public String admin_logManage() throws Exception {
		return "admin_logManage";
	}
	
	/**
	 * 管理员后台登录
	 * 
	 * @param admin
	 * @param session
	 * @return
	 */
	@RequestMapping("/admin_login")
	@ResponseBody
	@SystemControllerLog(description = "管理员登录后台")
	public Map<String, Object> admin_login(Admin admin, HttpSession session)
			throws Exception {
		String tips = "请稍后重试";
		Admin curr_admin = null;
		if (admin != null) {
			if (!("".equals(admin.getName()))
					&& (admin.getName().length() != 0)) {
				if (!("".equals(admin.getPass()))
						&& (admin.getPass().length() != 0)) {
					curr_admin = adminService.selectAdmin(admin);
					if (curr_admin != null) {
						if ((session.getAttribute(FinalConstant.CURR_ADMIN) != null)
								&& (session
										.getAttribute(FinalConstant.CURR_ADMIN) != "")) {
							session.removeAttribute(FinalConstant.CURR_ADMIN);
						}
						session.setAttribute(FinalConstant.CURR_ADMIN,
								curr_admin);
						tips = "登录成功";
					}else{
					  tips="账号或密码错误";	
					}
				} else {
					tips = "密码不能为空";
				}
			} else {
				tips = "账号不能为空";
			}
		} else {
			tips = "页面出错，请稍后重试";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 跳转到找回密码页面
	 * 
	 * @return
	 */
	@RequestMapping("/admin_findPass")
	public String admin_findPass() throws Exception {
		return "admin_findPass";
	}

	/**
	 * 给管理员账号的邮箱发送验证码
	 * 
	 * @param admin
	 * @param response
	 * @return
	 */
	@RequestMapping("/admin_doFindPass")
	@ResponseBody
	public Map<String, Object> admin_doFindPass(Admin admin,
			HttpServletResponse response) throws Exception {
		String tips = "";
		String num = "";
		if ((admin.getName() != "") && (admin.getName().length() != 0)) {
			Admin admins = adminService.selectAdminByProperty(admin);
			if (admins != null) {
				if ((admins.getEmail() != null)
						|| (admins.getEmail().length() != 0)) {
					if (admins.getStatus() == 1) {
						try {
							// SendEmail.sendValidateCode(admins.getEmail());
							num = RandomNumber.getRandomNumber();
							System.out.println("验证码为：" + num);
							Cookie cookie1 = new Cookie("num", num);
							Cookie cookie2 = new Cookie("aid", ""
									+ admins.getAid());
							cookie1.setMaxAge(300);
							cookie2.setMaxAge(300);
							response.addCookie(cookie1);
							response.addCookie(cookie2);
							tips="发送成功，请注意接收邮件";
						} catch (Exception e) {
							tips = "邮件发送失败，请稍后重试";
							e.printStackTrace();
						}
					} else {
						tips = "该账号尚未激活邮箱";
					}
				} else {
					tips = "该账号尚未绑定邮箱";
				}
			} else {
				tips = "该账号不存在";
			}
		} else {
			tips = "账号不能为空";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 检查放入cookie中的validateCode与用户输入的验证码是否一致
	 * 
	 * @param num
	 * @param validateCode
	 * @return
	 */
	@RequestMapping("/updatePass")
	@ResponseBody
	public Map<String, Object> updatePass(
			@CookieValue(value = "num", required = false) String num,
			String validateCode) throws Exception {
		String tips = "请稍后重试";
		if (!("".equals(validateCode)) && (validateCode.length() != 0)) {
			if ((num != null) && (num.length() != 0)) {
				if (validateCode.equals(num)) {
					tips = "验证码正确";
				} else {
					tips = "验证码有误";
				}
			} else {
				tips = "验证码已失效";
			}
		} else {
			tips = "验证码不能为空";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 跳转到管理员密码修改界面
	 * 
	 * @return
	 */
	@RequestMapping("/admin_updatePass")
	public String admin_updatePass() throws Exception {
		return "admin_updatePass";
	}

	/**
	 * 根据的在cookie中的管理员id，修改管理员密码
	 * 
	 * @return
	 */
	@RequestMapping("/admin_doUpdatePass")
	@ResponseBody
	@SystemControllerLog(description = "后台中管理员修改个人密码")
	public Map<String, Object> admin_doUpdatePass(
			@CookieValue(value = "aid", required = false) String aid,
			String pass, String rePass) throws Exception {
		String tips = "请稍后重试";
		int id = Integer.parseInt(aid);
		if (id != 0) {
			if ((pass != null) && (rePass != null)) {
				if (pass.equals(rePass)) {
					Admin admins = new Admin();
					admins.setAid(id);
					admins.setPass(pass);
					int flag = adminService.updateAdminByProperty(admins);
					if (flag > 0) {
						tips = "密码修改成功";
					}
				} else {
					tips = "两次密码输入不一致";
				}
			} else {
				tips = "密码不可为空";
			}
		} else {
			tips = "页面失效，请稍后重试";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 管理员退出登录
	 * 
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin_logOff")
	public String admin_logOff(HttpSession session) throws Exception {
		if ((session.getAttribute(FinalConstant.CURR_ADMIN) != null)
				&& (session.getAttribute(FinalConstant.CURR_ADMIN) != "")) {
			session.removeAttribute(FinalConstant.CURR_ADMIN);
		}
		return "../../admin_login";
	}
	
	/**
	 * 后台管理获取管理员列表信息,
	 * 还可以根据不同条件来查询相对应的管理员信息
	 * 分页
	 * @param name
	 * @return
	 */
	@RequestMapping("/admin_selectAdminList")
	@ResponseBody
	public Map<String, Object> admin_selectUserbList(String page,String rows,AdminCondition adminCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("adminCondition", adminCondition);
		List<Admin> adminList = this.adminService.selectAdminByCondition(map);
		int total = this.adminService.getTotal(adminCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(adminList!=null){
			modelMap.put("rows",adminList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台添加新管理员
	 * @param userb
	 * @return
	 */
	@RequestMapping(value="/admin_insertAdmin",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理添加新管理员")
	public Map<String, Object> admin_insertAdmin(Admin admin) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Admin admins=this.adminService.selectAdminByProperty(admin);
		if(admins==null){
			int count=this.adminService.insertAdmin(admin);
			if(count>0){
				tips="成功";
			}else{
				tips="失败";
			}
		}else{
			tips="该账号名已存在";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台更新用户信息	
     * @param userb
     * @return
     */
	@RequestMapping(value="/admin_updateAdmin",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理更新用户信息")
	public Map<String, Object> admin_updateAdmin(Admin admin){
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = this.adminService.updateAdminByProperty(admin);
		if(count>0){
			tips="成功";
		}else{
			tips="失败";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台管理删除管理员	
     * @param userb
     * @return
     */
	@RequestMapping(value="/admin_deleteAdmin",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理删除管理员")
	public Map<String,Object> admin_deleteAdmin(Admin admin,String aids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] aidStr = aids.split(",");
        for (String aid : aidStr) {
        	admin.setAid(Integer.parseInt(aid));
            count = this.adminService.deleteAdmin(admin);
            if(count<=0){
            	tips="删除失败";
            	break;
            }else{
            	tips="删除成功";
            }
        }
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台管理获取各表统计记录数量
	 * @return
	 */
	@RequestMapping("/admin_selectAllCount")
	@ResponseBody
	public Map<String,Object> admin_selectAllCount(){
		String tips = "成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<Integer> count = this.adminService.selectAllCount();
		if(count!=null){
			modelMap.put("count", count);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
}
