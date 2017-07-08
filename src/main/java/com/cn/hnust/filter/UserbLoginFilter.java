package com.cn.hnust.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cn.hnust.pojo.Userb;
import com.cn.hnust.util.FinalConstant;

public class UserbLoginFilter implements Filter{

	    public void destroy() {
	        // TODO Auto-generated method stub
	    }

		@Override
		public void doFilter(ServletRequest request, ServletResponse response,
				FilterChain chain) throws IOException, ServletException {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse res = (HttpServletResponse) response;
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			HttpSession session = req.getSession();
			Userb userb = (Userb)session.getAttribute(FinalConstant.CURR_USER);
			System.out.println("userblogin检测");
			if (userb == null) {
				res.getWriter()
						.print("<script>alert('请登录!');location.href='user/user_login'</script>");
				return;
			}
			chain.doFilter(request, response);

		}
	    
	    public void init(FilterConfig arg0) throws ServletException {
	        // TODO Auto-generated method stub
	    }
}
