package com.bookshop.model.vip;

/**
 * 用户积分记录
 * 
 * @author hebin
 *
 */
public class UserFundRecord {
	private String userId;
	private int consumeMoney;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getConsumeMoney() {
		return consumeMoney;
	}

	public void setConsumeMoney(int consumeMoney) {
		this.consumeMoney = consumeMoney;
	}

}
