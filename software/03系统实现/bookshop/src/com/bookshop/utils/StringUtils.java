package com.bookshop.utils;

public abstract class StringUtils {
	/**
	 * 
	 * [简要描述]:转义html为String
	 * 
	 * @param
	 * @return String
	 * @Exception
	 */
	public static String htmlToString(String content) {
		if (content == null) {
			return "";
		}
		String html = content;

		html = html.replace("'", "'");
		html = html.replaceAll("&", "&amp;");
		html = html.replace("\"", "&quot;");
		html = html.replace("\t", "&nbsp;&nbsp;");// 替换跳格
		html = html.replace(" ", "&nbsp;");// 替换空格
		html = html.replace("<", "&lt;");

		html = html.replaceAll(">", "&gt;");

		return html;
	}
	//
	// public static String stringToHtml(String content)
	// {
	// if(null == content)
	// {
	// return "";
	// }
	// String html = content;
	//
	// html = org.apache.commons.lang3.StringUtils.replace(html, "'", "'");
	// html = org.apache.commons.lang3.StringUtils.replace(html, "\\"", """);
	// html = org.apache.commons.lang3.StringUtils.replace(html, "\\t", " ");//
	// 替换跳格
	// // html = org.apache.commons.lang3.StringUtils.replace(html, " ", " ");//
	// 替换空格
	// html = org.apache.commons.lang3.StringUtils.replace(html, "<", "<");
	// html = org.apache.commons.lang3.StringUtils.replace(html, ">", ">");
	// return html;
	// }

	public static String replaceBlank(String str) {
		String dest = "";

		if (org.apache.commons.lang3.StringUtils.isEmpty(str)) {
			return dest;
		}

		dest = str.replaceAll("[\\t\\n\\r]", "");

		return dest;
	}

	public static String htmlReplace(String html) {
		if (html == null) {
			return "";
		}

		// 去掉空格
		// html = replaceBlank(html);

		// 替换"为\"
		html = org.apache.commons.lang3.StringUtils.replace(html, "\"", "\\\"");

		return html;

	}

	public static void main(String[] args) {
		String ss = "abc\"de\"f";
		System.out.println(ss);
		System.out.println(ss.replace('"', '\"'));
		System.out.println(org.apache.commons.lang3.StringUtils.replace(ss, "\"", "\\\""));

	}
}
