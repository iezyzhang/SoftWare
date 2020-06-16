package com.bookshop.model.user;

public final class UserFunds {
	private String userId;

	private int consumeMoney;

	private int payMoney;

	public UserFunds() {
		super();
	}

	public UserFunds(String userId) {
		super();
		this.userId = userId;
	}

	public UserFunds(String userId, int payMoney) {
		super();
		this.userId = userId;
		this.payMoney = payMoney;
	}

	public UserFunds(String userId, int consumeMoney, int payMoney) {
		super();
		this.userId = userId;
		this.consumeMoney = consumeMoney;
		this.payMoney = payMoney;
	}

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

	public int getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(int payMoney) {
		this.payMoney = payMoney;
	}

}
