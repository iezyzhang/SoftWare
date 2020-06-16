package com.bookshop.system;

import java.util.HashMap;
import java.util.Map;

/**
 * 用户上下文
 * 
 */
public abstract class UserContext {

	private static final Map<String, Map<String, Object>> LOGIN_USER_MAP = new HashMap<String, Map<String, Object>>();

	public static Map<String, Object> get(String username) {
		return LOGIN_USER_MAP.get(username);
	}

	public static synchronized Map<String, Object> create(String username) {
		// 查看当前内存中是否有用户信息
		Map<String, Object> userMap = LOGIN_USER_MAP.get(username);

		if (null != userMap) {
			return userMap;
		}

		// 创建用户内存
		userMap = new HashMap<String, Object>();

		LOGIN_USER_MAP.put(username, userMap);

		return userMap;
	}

	public static Object get(String username, String inKey) {
		Map<String, Object> mapObj = LOGIN_USER_MAP.get(username);

		if (null == mapObj) {
			return null;
		}

		return mapObj.get(inKey);
	}

	/**
	 * 考虑多线程并发？
	 * 
	 * @param username
	 * @param inKey
	 * @param value
	 */
	public static void put(String username, String inKey, Object value) {
		Map<String, Object> mapObj = LOGIN_USER_MAP.get(username);

		// 没有就新建
		if (null == mapObj) {
			mapObj = new HashMap<String, Object>();
			mapObj.put(inKey, value);

			LOGIN_USER_MAP.put(username, mapObj);
		} else {
			mapObj.put(inKey, value);
		}
	}

	public static void remove(String username) {
		LOGIN_USER_MAP.remove(username);
	}
}
