package com.bookshop.model.address;

/**
 * 
 * 送货地址查询条件实体
 *
 */
public class AddressFilter {
	private String addressId;

	private String userId;

	private String username;

	public String getAddressId() {
		return addressId;
	}

	public void setAddressId(String addressId) {
		this.addressId = addressId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}
