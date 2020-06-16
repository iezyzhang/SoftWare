package com.bookshop.model.comment;

public class CommentResult {
	private String subscriptionId;
	private String comment;
	private String userId;
	private String userName;
	private String productId;
	private String productName;
	private String commentTime;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCommentTime() {
		return commentTime;
	}

	public void setCommentTime(String commentTime) {
		this.commentTime = commentTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getSubscriptionId() {
		return subscriptionId;
	}

	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	@Override
	public String toString() {
		return "CommentResult [subscriptionId=" + subscriptionId + ", comment=" + comment + ", userId=" + userId
				+ ", userName=" + userName + ", productId=" + productId + ", productName=" + productName
				+ ", commentTime=" + commentTime + "]";
	}

}
