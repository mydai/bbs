package com.cn.hnust.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cn.hnust.aop.SystemControllerLog;
import com.cn.hnust.pojo.Userb;
import com.cn.hnust.pojo.UserbCondition;
import com.cn.hnust.service.IUserbService;
import com.cn.hnust.util.Encrypt;
import com.cn.hnust.util.FinalConstant;
import com.cn.hnust.util.PageBean;
import com.cn.hnust.util.RandomNumber;
import com.cn.hnust.util.SendEmail;

@Controller
@RequestMapping("/user")
public class UserbController {
	@Resource
	private IUserbService userbService;

	/**
	 * 跳转到用户个人中心里的index页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_index")
	public String user_index() throws Exception {
		return "user_index";
	}

	/**
	 * 登录界面跳转到user_center页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_center")
	public String user_center(HttpSession session) throws Exception {
		Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
		if(userb==null){
			return "user_login";
		}
		return "user_center";
	}

	/**
	 * user_center页面中的顶部模块跳转到user_top
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_top")
	public String user_top() throws Exception {
		return "user_top";
	}

	/**
	 * user_center页面中的左边模块跳转到user_left
	 * 
	 * @return
	 */
	@RequestMapping("/user_left")
	public String user_left() throws Exception {
		return "user_left";
	}

	/**
	 * user_center页面中的顶部模块跳转到user_right
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_right")
	public String user_right() throws Exception {
		return "user_right";
	}

	/**
	 * 跳转到用户信息页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_details")
	public String user_details() throws Exception {
		return "user_details";
	}

	/**
	 * 跳转到用户登录界面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_login")
	public String user_login() throws Exception {
		return "user_login";
	}

	/**
	 * 用户登录
	 * 
	 * @param userb
	 *            用于登录的用户账号密码
	 * @param yzm
	 *            登录验证码
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/doLogin")
	@ResponseBody
	@SystemControllerLog(description = "用户登录前台")
	public Map<String, Object> doLogin(Userb userb, String yzm,
			HttpSession session, Model model) throws Exception {
		String tips = "登陆成功";
		if ((userb.getName() != "") && (userb.getName().length() != 0)) {
			if ((userb.getPass() != "") && (userb.getPass().length() != 0)) {
				String rand = (String) session.getAttribute("rand");
				if (yzm.equals(rand)) {
					Userb user = this.userbService.selectUserb(userb);
					if (user != null) {
						if ((session.getAttribute(FinalConstant.CURR_USER) != null)
								&& (session
										.getAttribute(FinalConstant.CURR_USER) != "")) {
							session.removeAttribute(FinalConstant.CURR_USER);
						}
						session.setAttribute(FinalConstant.CURR_USER, user);
						model.addAttribute("user", user);
					} else {
						tips = "账号或密码错误";
					}
				} else {
					tips = "验证码错误";
				}
			} else {
				tips = "密码不可为空";
			}
		} else {
			tips = "账号不可为空";
		}

		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 获取验证码图片
	 * 
	 * @param userb
	 * @param request
	 * @return image.jsp
	 * @throws Exception
	 */
	@RequestMapping("/showYzm")
	public String showYzm(Userb userb, HttpServletRequest request)
			throws Exception {
		request.getSession();
		return "image";
	}

	/**
	 * 跳转到找回密码页面
	 * 
	 * @return findPass.jsp
	 * @throws Exception
	 */
	@RequestMapping("/findPass")
	public String findPass() throws Exception {
		return "user_findPass";
	}

	/**
	 * 发送带有验证码的邮件给当前用户
	 * 
	 * @param userb
	 * @param response
	 * @return map
	 * @throws Exception
	 *             邮件发送可能发生的错误
	 */
	@RequestMapping("/doFindPass")
	@ResponseBody
	@SystemControllerLog(description = "发送邮件给用户")
	public Map<String, Object> doFindPass(Userb userb,
			HttpServletResponse response) throws Exception {
		String tips = "邮件发送成功，请注意查收";
		String number = "";
		if ((userb.getName() != "") && (userb.getName().length() != 0)) {
			Userb user = userbService.selectUserbByProperty(userb);
			if (user != null) {
				if ((user.getEmail() != null)
						|| (user.getEmail().length() != 0)) {
					if (user.getStatus() == 1) {
						try {
							SendEmail.sendValidateCode(user.getEmail());
							number = RandomNumber.getRandomNumber();
							System.out.println("验证码为：" + number);
							Cookie cookie1 = new Cookie("number", number);
							Cookie cookie2 = new Cookie("bid", ""
									+ user.getBid());
							cookie1.setMaxAge(300);
							cookie2.setMaxAge(300);
							response.addCookie(cookie1);
							response.addCookie(cookie2);
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
	 * @param number
	 * @param validateCode
	 * @return map
	 * @throws Exception
	 */
	@RequestMapping("/updatePass")
	@ResponseBody
	public Map<String, Object> updatePass(
			@CookieValue(value = "number", required = false) String number,
			String validateCode) throws Exception {
		String tips = "请稍后重试";
		if ((validateCode != null) && (validateCode.length() != 0)) {
			if ((number != null) && (number.length() != 0)) {
				if (validateCode.equals(number)) {
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
	 * 跳转到修改密码页面
	 * 
	 * @return updatePass.jsp
	 * @throws Exception
	 */
	@RequestMapping("/user_updatePass")
	public String updatePass() throws Exception {
		return "user_updatePass";
	}

	/**
	 * 根据的用户id，修改该用户的密码
	 * 
	 * @param bid
	 *            cookie中的用户id
	 * @param pass
	 *            需要修改的用户密码
	 * @param rePass
	 * @return map
	 * @throws Exception
	 */
	@RequestMapping("/doUpdatePass")
	@ResponseBody
	@SystemControllerLog(description = "用户修改个人密码")
	public Map<String, Object> doUpdatePass(
			@CookieValue(value = "bid", required = false) String bid,
			String pass, String rePass) throws Exception {
		String tips = "请稍后重试";
		int id = Integer.parseInt(bid);
		if (id != 0) {
			if ((pass != null) && (rePass != null)) {
				if (pass.equals(rePass)) {
					Userb userb = new Userb();
					userb.setBid(id);
					userb.setPass(pass);
					int flag = userbService.updateUserbByProperty(userb);
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
			tips = "页面失效，请重新";
		}

		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 跳转到user_updateOldPass页面，通过旧密码修改用户当前密码
	 * 
	 * @return
	 */
	@RequestMapping("/user_updateOldPass")
	public String user_updateOldPass() {
		return "user_updateOldPass";
	}

	/**
	 * 用户在个人中心通过旧密码修改新密码
	 * 
	 * @param oldPass
	 * @param pass
	 * @param rePass
	 * @param session
	 * @return
	 */
	@RequestMapping("/user_doUpdateOldPass")
	@ResponseBody
	public Map<String, Object> user_doUpdateOldPass(String oldPass,
			String pass, String rePass, HttpSession session) {
		String tips = "";
		Userb userb = (Userb) session.getAttribute(FinalConstant.CURR_USER);
		if (!"".equals(oldPass)) {
			if (!"".equals(pass)) {
				if (!"".equals(rePass)) {
					if (userb.getPass().equals(oldPass)) {
						if (pass.equals(rePass)) {
							Userb user = new Userb();
							user.setBid(userb.getBid());
							user.setPass(pass);
							int flag = userbService.updateUserbByProperty(user);
							if (flag > 0) {
								tips = "密码修改成功";
							} else {
								tips = "密码修改失败，请稍后重试";
							}
						} else {
							tips = "两次输入密码不一致";
						}
					} else {
						tips = "原密码错误";
					}
				} else {
					tips = "确认新密码不能为空";
				}
			} else {
				tips = "新密码不能为空";
			}
		} else {
			tips = "原密码不能为空";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 在用户个人中心里， 跳转到发送验证码邮件页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_sendValidate")
	public String user_sendValidate() throws Exception {
		return "user_sendValidate";
	}

	/**
	 * 在用户中心里的通过发送的邮件验证码修改密码
	 * 
	 * @param session
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_doSendValidate")
	@ResponseBody
	public Map<String, Object> user_doSendValidate(HttpSession session,
			HttpServletResponse response) throws Exception {
		String tips = "";
		String number = "";
		Userb userb = (Userb) session.getAttribute("curr_user");
		if (userb.getStatus() == 1) {
			try {
				SendEmail.sendValidateCode(userb.getEmail());
				number = RandomNumber.getRandomNumber();
				System.out.println("验证码为：" + number);
				Cookie cookie1 = new Cookie("number", number);
				Cookie cookie2 = new Cookie("bid", "" + userb.getBid());
				cookie1.setMaxAge(300);
				cookie2.setMaxAge(300);
				response.addCookie(cookie1);
				response.addCookie(cookie2);
			} catch (Exception e) {
				tips = "邮件发送失败，请稍后重试";
				e.printStackTrace();
			}
		} else {
			tips = "您的邮箱尚未激活，请激活后重试";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 跳转到用户注册页面
	 * 
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/register")
	public String register() throws Exception {
		return "user_register";
	}

	/**
	 * 用户注册
	 * 
	 * @param userb
	 *            包含用户信息
	 * @param rePass
	 * @param yzm
	 *            验证码
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/doRegister")
	@ResponseBody
	@SystemControllerLog(description = "新用户注册")
	public Map<String, Object> doRegister(Userb userb, String rePass,
			String yzm, HttpSession session) throws Exception {
		String tips = "";
		String encryption = "";
		String mod = "";
		Userb user1 = null;
		user1 = this.userbService.selectUserbByProperty(userb);
		if(user1==null){
			if (userb.getName() != null) {
				if (userb.getPass() != null) {
					if (rePass != null) {
						if (userb.getEmail() != null) {
							if (userb.getPhone() != null) {
								if (yzm != null) {
									if (userb.getPass().equals(rePass)) {
										String rand = (String) session
												.getAttribute("rand");
										if (yzm.equals(rand)) {
											userb.setValidatecode(RandomNumber
													.getRandomNumber());
											int flag = this.userbService
													.insertUserbByProperty(userb);
											if (flag > 0) {
												Userb user = this.userbService.selectUserb(userb);
												if ((session.getAttribute(FinalConstant.CURR_USER) != null)
												  && (session.getAttribute(FinalConstant.CURR_USER) != "")) {
												  session.removeAttribute(FinalConstant.CURR_USER);
												}
												session.setAttribute(FinalConstant.CURR_USER, user);
												tips = "注册成功";
												encryption = userb.getName()
														.replace(" ", "")
														+ "&"
														+ userb.getPass().replace(
																" ", "")
														+ "&"
														+ userb.getEmail().replace(
																" ", "")
														+ "&"
														+ userb.getValidatecode()
																.replace(" ", "");
												byte[] inputData = encryption
														.getBytes();

												mod = "http://www.daidai2016.com.cn/ssm/user/doActivateMail?mod="
														+ Encrypt
																.encryptBASE64(inputData);
												SendEmail.sendActivationLink(
														userb.getEmail(), mod);
											} else {
												tips = "注册失败，请稍后重试";
											}

										} else {
											tips = "验证码错误";
										}
									} else {
										tips = "两次密码输入不一致";
									}
								} else {
									tips = "验证码不能为空";
								}
							} else {
								tips = "手机号不能为空";
							}
						} else {
							tips = "邮箱不能为空";
						}
					} else {
						tips = "确认密码不能为空";
					}
				} else {
					tips = "密码不能为空";
				}
			} else {
				tips = "用户名不可为空";
			}
		}else{
			tips="该用户名已被注册！";
		}

		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 向用户邮箱发送邮箱激活链接
	 * @param mod
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping("/sendActivateMail")
    @ResponseBody
    public Map<String, Object> sendActivateMail(HttpSession session,Model model) throws Exception {
    	String tips = "";
		String encryption = "";
		String mod = "";
        Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
        if((userb.getEmail()==null)||(userb.getEmail().trim()=="")){
        	tips="您的邮箱为空，不能进行激活";
        }else{
			userb.setValidatecode(RandomNumber
					.getRandomNumber());
			this.userbService.updateUserbByProperty(userb);
        	encryption = userb.getName()
    				.replace(" ", "")
    				+ "&"
    				+ userb.getPass().replace(
    						" ", "")
    				+ "&"
    				+ userb.getEmail().replace(
    						" ", "")
    				+ "&"
    				+ userb.getValidatecode()
    						.replace(" ", "");
    		byte[] inputData = encryption
    				.getBytes();

    		mod = "http://localhost/bbs/user/doActivateMail?mod="
    				+ Encrypt
    						.encryptBASE64(inputData);
    		SendEmail.sendActivationLink(
    				userb.getEmail(), mod);
    		tips="已向您的邮箱发送邮件，请注意查收";
        }
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
    }
    
	/**
	 * 用户在邮箱中点击邮箱激活链接跳转到此
	 * @param mod
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/doActivateMail")
	public String doActivateMail(String mod, Model model) throws Exception {
		byte[] b = Encrypt.decryptBASE64(mod);
		String str = new String(b);
		String[] ss = str.split("&");
		String tips = "";
		Userb userb = new Userb(ss[0], ss[1], ss[2], ss[3]);
		int flag = this.userbService.updateStatusByProperty(userb);
		if (flag > 0) {
			tips = ss[2] + "邮箱激活成功";

		} else {
			tips = "邮箱激活失败，请稍后重试";
		}
		model.addAttribute("tips", tips);
		return "tips";
	}

	@RequestMapping("/tips")
	public String tips() throws Exception {
		return "tips";
	}
	
	/**
	 * 跳转到修改用户信息页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_updateDetails")
	public String user_updateDetails() throws Exception {
		return "user_updateDetails";
	}

	/**
	 * 修改用戶個人信息
	 * 
	 * @param userb
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_doUpdateDetails")
	@ResponseBody
	@SystemControllerLog(description = "用户修改个人信息")
	public Map<String, Object> user_updateDetails(Userb userb,
			HttpSession session) throws Exception {
		String tips = "";
		Userb user = (Userb) session.getAttribute(FinalConstant.CURR_USER);
		if ((userb.getEmail().length() != 0) || user.getEmail() != null) {
			if (userb.getEmail().equals(user.getEmail())) {
				userb.setEmail(null);
			}
			if (userb.getPhone().equals(user.getPhone())) {
				userb.setPhone(null);
			}
			if (userb.getIntro().equals(user.getIntro())) {
				userb.setIntro(null);
			}
			if ((userb.getEmail() != null) || (userb.getPhone() != null)
					|| (userb.getIntro() != null)) {
				userb.setBid(user.getBid());
				int flag = this.userbService.updateUserbByProperty(userb);
				if (flag > 0) {
					if (userb.getEmail() != null) {
						user.setEmail(userb.getEmail());
					}
					if (userb.getPhone() != null) {
						user.setPhone(userb.getPhone());
					}
					if (userb.getIntro() != null) {
						user.setIntro(userb.getIntro());
					}
					if ((session.getAttribute(FinalConstant.CURR_USER) != null)
							&& (session.getAttribute(FinalConstant.CURR_USER) != "")) {
						session.removeAttribute(FinalConstant.CURR_USER);
					}
					session.setAttribute(FinalConstant.CURR_USER, user);
					tips = "修改成功";
				} else {
					tips = "修改失败，请稍后再试";
				}
			} else {
				tips = "无需修改";
			}
		} else {
			tips = "邮箱为空，您将无法接收信息和修改密码";
		}
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("tips", tips);
		return modelMap;
	}

	/**
	 * 修改用户头像
	 * 
	 * @param upload
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user_updateImg", method = RequestMethod.POST)
	public String user_updateImg(@RequestParam("upload") MultipartFile upload,
			HttpSession session) throws Exception {
		if (!upload.isEmpty()) {
			try {
				// getRealPath() 取得 WEB-INF 所在文件夹路径
				// 如果参数是 "/temp", 当 temp 存在时返回 temp 的本地路径, 不存在时返回 null/temp
				// (无效路径)
				Userb userb = (Userb) session
						.getAttribute(FinalConstant.CURR_USER);
				String path = session.getServletContext().getRealPath(
						"/resources/upload")
						+ File.separator + upload.getOriginalFilename();
				int flag = FileCopyUtils.copy(upload.getInputStream(),
						new FileOutputStream(path));
				int num = 0;
				if (flag > 0) {
					String img = "resources/upload" + File.separator
							+ upload.getOriginalFilename();
					Userb user = new Userb();
					user.setBid(userb.getBid());
					user.setImg(img);
					num = this.userbService.updateUserbByProperty(user);
					if (num > 0) {
						System.out.println("头像保存成功");
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {

		}
		return "user_updateDetails";
	}

	/**
	 * 用戶注销功能
	 * 
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_logOff")
	public String user_logOff(HttpSession session) throws Exception {
		if ((session.getAttribute(FinalConstant.CURR_USER) != null)
				&& (session.getAttribute(FinalConstant.CURR_USER) != "")) {
			session.removeAttribute(FinalConstant.CURR_USER);
		}
		return "user_login";
	}

	/**
	 * 检查用户是否存在
	 * 
	 * @param name
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user_checkUserbIsExist")
	@ResponseBody
	public Map<String, Object> user_checkUserbIsExist(String name)
			throws Exception {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if (!("".equals(name)) && !(name.length() == 0)) {
			Userb userb = new Userb();
			userb.setName(name);
			userb = this.userbService.selectUserbByProperty(userb);
			if (userb != null) {
				tips = "用户存在";
				modelMap.put("id", userb.getBid());
			} else {
				tips = "该用戶不存在";
			}
		} else {
			tips = "用戶名不能为空";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
    
	/**
	 * 动态模糊查询name集合
	 * @param name
	 * @return
	 */
	@RequestMapping("/user_selectNameList")
	@ResponseBody
	public Map<String, Object> user_selectNameList(String name) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<String> list =null; 
		if(name!=null){
			if (!("".equals(name)) && !(name.length() == 0)) {
		           list=this.userbService.selectNameList(name);
			}
		}
		modelMap.put("tips", tips);
		modelMap.put("list", list);
		return modelMap;
	}
   
	/**
	 * 获取当前用户的所有的数据的个数统计
	 * @param session
	 * @return
	 */
	@RequestMapping("/user_selectAllCount")
	@ResponseBody
	public Map<String, Object> user_selectAllCount(HttpSession session) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Userb userb = (Userb) session.getAttribute(FinalConstant.CURR_USER);
		if(userb!=null){
          List<Integer> count = this.userbService.selectAllCount(userb);
          modelMap.put("count", count);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台管理获取用户列表信息,
	 * 还可以根据不同条件来查询相对应的用户信息
	 * 分页
	 * @param name
	 * @return
	 */
	@RequestMapping("/admin_selectUserbList")
	@ResponseBody
	public Map<String, Object> admin_selectUserbList(String page,String rows,UserbCondition userbCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("userbCondition", userbCondition);
		List<Userb> userbList = this.userbService.selectUserbByCondition(map);
		int total = this.userbService.getTotal(userbCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(userbList!=null){
			modelMap.put("rows",userbList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台添加新用户
	 * @param userb
	 * @return
	 */
	@RequestMapping(value="/admin_addUserb",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理新增新用户")
	public Map<String, Object> admin_addUserb(Userb userb) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Userb user=this.userbService.selectUserbByProperty(userb);
		if(user==null){
			int count=this.userbService.insertUserbByProperty(userb);
			if(count>0){
				tips="成功";
			}else{
				tips="失败";
			}
		}else{
			tips="该用户名已存在";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台更新用户信息	
     * @param userb
     * @return
     */
	@RequestMapping(value="/admin_updateUserb",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理更新用户信息")
	public Map<String, Object> admin_updateUserb(Userb userb){
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = this.userbService.updateUserbByProperty(userb);
		if(count>0){
			tips="成功";
		}else{
			tips="失败";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台管理删除用户	
     * @param userb
     * @return
     */
	@RequestMapping(value="/admin_deleteUserb",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理刪除用戶")
	public Map<String,Object> admin_deleteUserb(Userb userb,String bids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] bidStr = bids.split(",");
        for (String bid : bidStr) {
        	userb.setBid(Integer.parseInt(bid));
            count = this.userbService.deleteUserb(userb);
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
	
//	/**
//	 * 根据不同的条件来查询对应的用户信息
//	 * @param userbCondition
//	 * @return
//	 */
//	@RequestMapping(value="/admin_searchUserb",method = RequestMethod.GET)
//	@ResponseBody
//	public Map<String,Object> admin_searchUserb(UserbCondition userbCondition){
//		String tips = "";
//		Map<String, Object> modelMap = new HashMap<String, Object>();
//		List<Userb> userbList = this.userbService.selectUserbByCondition(userbCondition);
//		if(userbList!=null){
//			modelMap.put("rows",userbList);
//			modelMap.put("total", 20);
//		}
//		modelMap.put("tips", tips);
//		return modelMap;
//	}
	
}
