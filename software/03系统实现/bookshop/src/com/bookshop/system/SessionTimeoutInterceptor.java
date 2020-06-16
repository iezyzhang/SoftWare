package com.bookshop.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.bookshop.common.ConstantCode;
import com.bookshop.model.product.CupProduct;

@Controller
public class SessionTimeoutInterceptor implements HandlerInterceptor {
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

	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {

	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		// 过滤不需要拦截的请求
		String url = request.getRequestURL().toString();

		String path = request.getServletPath();

		// 如果是后台的，则直接放通
		if (StringUtils.isEmpty(path) || path.startsWith("/backstage_")) {
			return true;
		}

		String username = request.getParameter("username");
		saveCup(request, username);

		if (StringUtils.isEmpty(url) || filterUrl(url)) {
			return true;
		}

		// 获取会话
		Object sessionKey = WebUtils.getSessionAttribute(request, username);

		if (null == sessionKey) {
			// 如果session不存在，则清理内存
			UserContext.remove(username);
			request.getRequestDispatcher("/toLogin").forward(request, response);
			return false;
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

	/**
	 * 
	 * @param username
	 */
	public void clearnCache(String url, String username) {
		if (url.endsWith("/login")) {
			return;
		}

		UserContext.remove(username);
	}

	/**
	 * 
	 * [简要描述]:判断是否创建了购物车，没有则创建
	 * 
	 * @param
	 * @return void
	 * @Exception
	 */
	public void saveCup(HttpServletRequest request, String username) {
		String sessionId = WebUtils.getSessionId(request);

		if (sessionId == null) {
			return;
		}

		Object cupObj = WebUtils.getSessionAttribute(request, sessionId);

		if (null == cupObj) {
			// 如果没有，需要生成购物车
			// 创建购物车,用sessionId作为购物车名字
			Map<String, Object> cup = new HashMap<String, Object>();
			List<CupProduct> productList = new ArrayList<CupProduct>();

			// 用户名
			cup.put(ConstantCode.SESSION_USERNAME, username);

			// 产品信息
			cup.put(ConstantCode.SESSION_PRODUCTLIST, productList);

			// 购物车数量
			cup.put(ConstantCode.SESSION_COUNT, String.valueOf(productList.size()));

			WebUtils.setSessionAttribute(request, sessionId, cup);
		}
	}
}
