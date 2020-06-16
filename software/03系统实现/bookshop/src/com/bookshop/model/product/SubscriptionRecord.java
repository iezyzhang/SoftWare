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
public class SubscriptionRecord {
	private String subscriptionId;
	private String userId;
	private String productId;
	private int status;
	private String subscriptionTime;
	private String unsubscribeTime;
	private String message;
	private int totalCount;
	private float totalPrice;
	private String address;

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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public float getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(float totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
