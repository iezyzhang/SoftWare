package com.bookshop.model.product;

/**
 * 
 * 
 * 项目名称：bookshop 类名称：SubscriptionRecord 类描述：订单 创建人：Administrator 创建时间：Mar 8,
 * 2015 1:22:00 PM 修改人：Administrator 修改时间：Mar 8, 2015 1:22:00 PM 修改备注：
 * 
 * @version
 *
 */
public class SubscriptionFilter {
	private String subscriptionId;
	private String userId;
	private String productId;
	private int status = -1;
	private String subscriptionTime;
	private String unsubscribeTime;

	public String getSubscriptionId() {
		return subscriptionId;
	}

	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getSubscriptionTime() {
		return subscriptionTime;
	}

	public void setSubscriptionTime(String subscriptionTime) {
		this.subscriptionTime = subscriptionTime;
	}

	public String getUnsubscribeTime() {
		return unsubscribeTime;
	}

	public void setUnsubscribeTime(String unsubscribeTime) {
		this.unsubscribeTime = unsubscribeTime;
	}
}
