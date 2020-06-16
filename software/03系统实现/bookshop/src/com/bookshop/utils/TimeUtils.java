package com.bookshop.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 
 * 
 * 项目名称：bookshop 类名称：TimeUtils 类描述： 创建人：Administrator 创建时间：Mar 1, 2015 1:27:18
 * PM 修改人：Administrator 修改时间：Mar 1, 2015 1:27:18 PM 修改备注：
 * 
 * @version
 *
 */
public abstract class TimeUtils {
	public static String getUTCCurrentTime(String formmat) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(formmat);

		return sdf.format(calendar.getTime());
	}

	public static String formate(String time, String format, String destFormat) {
		SimpleDateFormat formmatter = new SimpleDateFormat(format);
		Date date = null;
		try {
			date = formmatter.parse(time);

		} catch (ParseException e) {
			System.out.println("date format error");
			return time;
		}

		SimpleDateFormat destFormatt = new SimpleDateFormat(destFormat);
		return destFormatt.format(date);
	}
}
