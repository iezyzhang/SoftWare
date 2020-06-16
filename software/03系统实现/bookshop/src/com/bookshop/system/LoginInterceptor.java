package com.bookshop.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * @author hebin
 *
 */
@Controller
public class LoginInterceptor implements HandlerInterceptor {
	private static String[] exculdeArr;

	private String excludeUrl;

	public void setExcludeUrl(String excludeUrl) {
		this.excludeUrl = excludeUrl;

		if (StringUtils.isNotEmpty(excludeUrl)) {
			exculdeArr = this.excludeUrl.split(",");
		} else {
			exculdeArr = ArrayUtils.EMPTY_STRING_ARRAY;
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse reponse, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse response, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		// // TODO Auto-generated method stub
		System.out.println("登陆拦截器执行了");
		// 过滤不需要拦截的请求
		String url = request.getRequestURL().toString();

		String path = request.getServletPath();

		String adminNamer = request.getParameter("adminName");
		String adminNames = (String) request.getSession().getAttribute("adminName");

		// 放过空和不需要拦截的url
		if (StringUtils.isEmpty(path) || filterUrl(url)) {
			return true;
		}
		// 对登陆进行拦截
		if (url.contains("/backstage_login")) {
			System.out.println("拦截了/backstage_login");
			System.out.println("/backstage_login/adminnamer:" + adminNamer);
			System.out.println("/backstage_login/adminnames:" + adminNames);
			if (adminNames != null) {
				request.setAttribute("adminName", adminNames);
				request.getSession().setAttribute("adminName", adminNames);

			} else if (adminNamer != null) {
				request.setAttribute("adminName", adminNamer);
				request.getSession().setAttribute("adminName", adminNamer);

			} else {
				System.out.println("/backstage_login/跳转到后台主页");
				request.getRequestDispatcher("backstage_toLogin").forward(request, response);
				System.out.println("/backstage_login/");

			}
		}

		return true;
	}

	/**
	 * 是否在例外url，如果是，则不拦截
	 * 
	 * @param url
	 * @return
	 */
	public static boolean filterUrl(String url) {
		for (String s : exculdeArr) {
			if (url.endsWith(s.trim())) {
				return true;
			}
		}

		return false;
	}

}
