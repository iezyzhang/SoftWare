package com.bookshop.common;

import java.util.HashMap;
import java.util.Map;

public abstract class Category {
	private static Map<String, String> categoryMap = new HashMap<String, String>();

	static {
		categoryMap.put("1", "游戏");
		categoryMap.put("2", "操作系统");
		categoryMap.put("3", "数据库");
		categoryMap.put("4", "图形图像");
		categoryMap.put("5", "多媒体");
		categoryMap.put("6", "网络与通信");
		categoryMap.put("7", "软件程序设计");
		categoryMap.put("8", "硬件维护");
		categoryMap.put("9", "教材");
		categoryMap.put("10", "考试认证");
		categoryMap.put("11", "电子电气");
		categoryMap.put("12", "工具书软件");
	}

	public static Map<String, String> getMap() {
		return categoryMap;
	}
}
