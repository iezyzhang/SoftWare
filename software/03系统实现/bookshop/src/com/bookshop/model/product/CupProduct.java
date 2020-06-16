package com.bookshop.model.product;

import java.io.Serializable;

public class CupProduct implements Serializable {
	private static final long serialVersionUID = 2923084616874628579L;

	private String cupId;

	private String productId;

	private int count;

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getCupId() {
		return cupId;
	}

	public void setCupId(String cupId) {
		this.cupId = cupId;
	}
}
