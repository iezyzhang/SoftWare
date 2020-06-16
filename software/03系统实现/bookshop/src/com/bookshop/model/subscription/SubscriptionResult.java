package com.bookshop.model.subscription;

public class SubscriptionResult {

	private String subscriptionId;

	private String subscriptionTime;

	private String userId;

	private String userName;

	private String productName;

	private int status;

	private String message;

	public String getSubscriptionId() {
		return subscriptionId;
	}

	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
	}

	public String getSubscriptionTime() {
		return subscriptionTime;
	}

	public void setSubscriptionTime(String subscriptionTime) {
		this.subscriptionTime = subscriptionTime;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "SubscriptionResult [subscriptionId=" + subscriptionId + ", subscriptionTime=" + subscriptionTime
				+ ", userId=" + userId + ", userName=" + userName + ", productName=" + productName + ", status="
				+ status + ", message=" + message + "]";
	}

}
