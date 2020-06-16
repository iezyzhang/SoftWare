package com.bookshop.common;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

public abstract class CommonService {
	public static void setUserSession(HttpServletRequest request, ModelAndView model, String username) {
		// 判断前台是否已登陆
		Object sessionKey = WebUtils.getSessionAttribute(request, username);

		if (null != sessionKey) {

			model.addObject("username", username);

		}

	}

	public static void setAdminSession(HttpServletRequest request, ModelAndView model, String username) {
		// 判断前台是否已登陆
		Object sessionKey = WebUtils.getSessionAttribute(request, username);

		if (null != sessionKey) {

			model.addObject("adminName", username);
		}

	}

	/**
	 * 
	 * [简要描述]:删除文件
	 * 
	 * @param
	 * @return void
	 * @Exception
	 */
	public static void deleteFile(String path, String fileName) {
		StringBuffer sb = new StringBuffer(path);
		sb.append("/");
		sb.append(fileName);
		String filePath = sb.toString();
		File deleteFile = new File(filePath);
		FileUtils.deleteQuietly(deleteFile);
	}
}
