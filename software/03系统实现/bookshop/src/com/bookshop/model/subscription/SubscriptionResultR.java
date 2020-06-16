package com.bookshop.model.subscription;

public class SubscriptionResultR {
	private String subscriptionId;

	private String subscriptionTime;

	private String userId;

	private String userName;

	private String productName;

	private String status;

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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "SubscriptionResultR [subscriptionId=" + subscriptionId + ", subscriptionTime=" + subscriptionTime
				+ ", userId=" + userId + ", userName=" + userName + ", productName=" + productName + ", status="
				+ status + ", message=" + message + ", getSubscriptionId()=" + getSubscriptionId()
				+ ", getSubscriptionTime()=" + getSubscriptionTime() + ", getUserId()=" + getUserId()
				+ ", getUserName()=" + getUserName() + ", getProductName()=" + getProductName() + ", getStatus()="
				+ getStatus() + ", getMessage()=" + getMessage() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}

}
