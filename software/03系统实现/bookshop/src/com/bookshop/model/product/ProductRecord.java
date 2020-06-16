package com.bookshop.model.product;

import com.bookshop.model.IRecord;

/**
 * 
 * 
 * 项目名称：bookshop 类名称：ProductRecord 类描述：产品（书籍） 创建人：Administrator 创建时间：Mar 1, 2015
 * 11:12:00 PM 修改人：Administrator 修改时间：Mar 1, 2015 11:12:00 PM 修改备注：
 * 
 * @version
 *
 */
public class ProductRecord implements IRecord {
	private String productId;
	private String productName;
	private int status;
	private String author;
	private String press;
	private String publicationTime;
	private String categoryId;
	private String description;
	private int stock;
	private float marketPrice;
	private float price;
	private int salesvolume;
	private String iconUrl;
	private String createTime;
	private String detailContent;

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

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublicationTime() {
		return publicationTime;
	}

	public void setPublicationTime(String publicationTime) {
		this.publicationTime = publicationTime;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public float getMarketPrice() {
		return marketPrice;
	}

	public void setMarketPrice(float marketPrice) {
		this.marketPrice = marketPrice;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public int getSalesvolume() {
		return salesvolume;
	}

	public void setSalesvolume(int salesvolume) {
		this.salesvolume = salesvolume;
	}

	public String getIconUrl() {
		return iconUrl;
	}

	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getDetailContent() {
		return detailContent;
	}

	public void setDetailContent(String detailContent) {
		this.detailContent = detailContent;
	}

	public String getPress() {
		return press;
	}

	public void setPress(String press) {
		this.press = press;
	}
}
