package com.bookshop.common;

/**
 * 常量类
 * 
 * @author sunjin2
 * 
 */
public abstract class ConstantCode {
	public static final String SESSION_USERNAME = "USERNAME";

	public static final String SESSION_PRODUCTLIST = "PRODUCTLIST";

	public static final String SESSION_COUNT = "COUNT";

	public static final int IS_ADMIN_YES = 1;

	public static final int IS_ADMIN_NO = 0;

	public static final int IS_VIP_NO = 0;

	public static final int IS_VIP_YES = 1;

	public static final String IS_VIP_NO_STRING = "否";

	public static final String IS_VIP_YES_STRING = "是";

	public static final int USER_STATUS_NORMAL = 0;

	public static final int USER_STATUS_NO_ACTIVE = 1;

	public static final int USER_STATUS_SUSPEND = 2;

	public static final String USER_STATUS_NORMAL_STRING = "正常";

	public static final String USER_STATUS_NO_ACTIVE_STRING = "未激活";

	public static final String USER_STATUS_SUSPEND_STRING = "暂停";

	public static final int USER_TYPE_NORMAL = 1;

	public static final int USER_TYPE_ADMIN = 1;

	/** 用户已存在. * */
	public static final int USER_EXISTS = 1;

	/** 用户不存在. * */
	public static final int USER_NOT_EXISTS = 0;

	/** 购物车内存关键字. * */
	public static final String CONTEXT_SHOPPING_CART = "CONTEXT_SHOPPING_CART";

	/** 用户session关键字. * */
	public static final String USER_SESSION_KEY = "USER_SESSION_KEY";

	public static final String TIME_FORMAT_YYYYMMDDHHMMSS = "yyyyMMddHHmmss";

	public static final String TIME_FORMAT_YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";

	public static final String TIME_FORMAT_YYYYMMDD = "yyyyMMdd";

	public static final String TIME_FORMAT_YYYY_MM_DD = "yyyy-MM-dd";

	/** 产品状态. * */
	public abstract class ProductStatus {
		/** 草稿. * */
		public static final int DRAFT = 0;

		/** 上架. * */
		public static final int ONLINE = 1;

		/** 下架. * */
		public static final int OFFLINE = 2;

		/** 草稿. * */
		public static final String DRAFT_STRING = "草稿";

		public static final String ONLINE_STRING = "上架";

		public static final String OFFLINE_STRING = "下架";

	}

	/** 产品状态. * */
	public abstract class ProductOperateType {
		/** 上线产品. * */
		public static final int ONLIE = 1;

		/** 下线产品. * */
		public static final int OFFLINE = 2;

		/** 删除产品. * */
		public static final int DELETE = 3;
	}

	public abstract class FileType {
		/** 用户. * */
		public static final int USER = 1;

		/** 产品. * */
		public static final int PRODUCT = 2;
	}

	public abstract class SubscriptionStatus {
		// 草稿
		public static final int DRAFT = 0;

		// 代付款
		public static final int WAIT_PAY = 1;

		// 代发货
		public static final int WAIT_SEND = 2;

		// 代确认收货
		public static final int WAIT_RECIVE = 3;

		// 代评价
		public static final int WAIT_EVALUATION = 4;

		// 交易结束
		public static final int COMLETE = 5;

		// 已评论
		public static final int COMMENTED = 6;

		// 退订中
		public static final int UNSUBSCRIBING = 10;

		// 已退订
		public static final int UNSUBSCRIBED = 11;

		// 删除
		public static final int DELETED = 99;

		// 草稿
		public static final String DRAFT_STRING = "草稿";

		// 代付款
		public static final String WAIT_PAY_STRING = "待付款";

		// 代发货
		public static final String WAIT_SEND_STRING = "待发货";

		// 代确认收货
		public static final String WAIT_RECIVE_STRING = "待确认收货";

		// 代评价
		public static final String WAIT_EVALUATION_STRING = "待评价";

		// 交易结束
		public static final String COMLETE_STRING = "交易结束";

		// 退订中
		public static final String UNSUBSCRIBING_STRING = "退订中";

		// 已退订
		public static final String UNSUBSCRIBED_STRING = "已退订";

		// 删除
		public static final String DELETED_STRING = "删除";
	}
}
