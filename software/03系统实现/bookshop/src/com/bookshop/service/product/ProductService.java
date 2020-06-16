package com.bookshop.service.product;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.bookshop.common.Category;
import com.bookshop.common.ConstantCode;
import com.bookshop.model.comment.CommentRecord;
import com.bookshop.model.comment.CommentResult;
import com.bookshop.model.product.ProductCommentDetail;
import com.bookshop.model.product.ProductCommentRecord;
import com.bookshop.model.product.ProductDetail;
import com.bookshop.model.product.ProductFilter;
import com.bookshop.model.product.ProductRecord;
import com.bookshop.model.user.UserRecord;
import com.bookshop.service.user.UserService;
import com.bookshop.utils.StringUtils;
import com.bookshop.utils.TimeUtils;
import com.bookshop.utils.UUIDGenerator;

/**
 * 
 * 
 * @version
 * 
 */
@Service
public class ProductService {

	@Resource
	private SqlSession session;

	@Resource
	private UserService userManager;

	/**
	 * 新增product
	 * 
	 * @param record
	 */
	public void addProduct(ProductRecord record) {
		// 生成productId
		String productId = UUIDGenerator.getUUID();
		record.setProductId(productId);
		session.insert("ProductManageMapper.insert", record);
	}

	/**
	 * 修改product
	 * 
	 * @param record
	 */
	public void updateProduct(ProductRecord record) {
		session.insert("ProductManageMapper.update", record);
	}

	/**
	 * 更新产品销量与存货
	 * 
	 * @param record
	 */
	public synchronized void updateSalesvolume(ProductRecord record) {
		session.insert("ProductManageMapper.updateSalesvolume", record);
	}

	/**
	 * 删除product
	 * 
	 * @param record
	 */
	public void deleteProductById(String productId) {
		ProductRecord record = new ProductRecord();
		record.setProductId(productId);
		session.delete("ProductManageMapper.delete", record);
	}

	/**
	 * 查询
	 * 
	 * @param record
	 */
	public List<ProductDetail> getProductList(ProductFilter productFilter) {
		List<ProductRecord> queryList = session.selectList("ProductManageMapper.queryByCondition", productFilter);

		List<ProductDetail> resultList = new ArrayList<ProductDetail>();

		if (CollectionUtils.isEmpty(queryList)) {
			return resultList;
		}

		for (ProductRecord record : queryList) {
			resultList.add(covertProductRecord(record));
		}

		return resultList;
	}

	/**
	 * 查询新书
	 * 
	 * @param productFilter
	 * @return
	 */
	public List<ProductDetail> getProductNewList(ProductFilter productFilter) {
		List<ProductRecord> queryList = session.selectList("ProductManageMapper.queryNewBook", productFilter);
		List<ProductDetail> resultList = new ArrayList<ProductDetail>();

		if (CollectionUtils.isEmpty(queryList)) {
			return resultList;
		}

		for (ProductRecord record : queryList) {
			resultList.add(covertProductRecord(record));
		}

		return resultList;
	}

	/**
	 * 根据id查询
	 * 
	 * @param record
	 */
	public ProductRecord getProductRecordById(ProductFilter productFilter) {
		ProductRecord productRecord = session.selectOne("ProductManageMapper.queryById", productFilter);

		return productRecord;
	}

	/**
	 * 根据id查询
	 * 
	 * @param record
	 */
	public ProductRecord getProductRecordById(String productId) {
		ProductFilter productFilter = new ProductFilter();
		productFilter.setProductId(productId);
		ProductRecord productRecord = getProductRecordById(productFilter);

		return productRecord;
	}

	/**
	 * 获取产品详情
	 * 
	 * @param record
	 */
	public ProductDetail getProductDetailById(String productId) {
		ProductFilter productFilter = new ProductFilter();
		productFilter.setProductId(productId);

		ProductRecord record = getProductRecordById(productFilter);

		if (null == record) {
			return null;
		}

		return covertProductRecord(record);
	}

	public ProductDetail covertProductRecord(ProductRecord record) {
		ProductDetail detail = new ProductDetail();

		detail.setStatus(convertStatus(record.getStatus()));

		detail.setAuthor(record.getAuthor());

		detail.setCategoryId(record.getCategoryId());
		detail.setCategory(Category.getMap().get(record.getCategoryId()));

		detail.setCreateTime(TimeUtils.formate(record.getCreateTime(), ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS,
				ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

		detail.setDescription(record.getDescription());
		detail.setIconUrl(record.getIconUrl());
		detail.setMarketPrice(record.getMarketPrice());
		detail.setPrice(record.getPrice());
		detail.setProductId(record.getProductId());
		detail.setProductName(record.getProductName());

		detail.setPress(record.getPress());

		detail.setPublicationTime(TimeUtils.formate(record.getPublicationTime(), ConstantCode.TIME_FORMAT_YYYYMMDD,
				ConstantCode.TIME_FORMAT_YYYY_MM_DD));

		detail.setSalesvolume(record.getSalesvolume());
		detail.setStock(record.getStock());

		// 替换空白符，如换行，回车，Tab
		String content = record.getDetailContent();
		content = StringUtils.replaceBlank(content);

		// 替换特殊字符
		detail.setDetailContent(StringUtils.htmlReplace(content));

		return detail;
	}

	/**
	 * 获取产品评论
	 * 
	 * @param record
	 */
	public List<ProductCommentDetail> getProductCommentByProductId(String productId) {
		ProductCommentRecord recordFilter = new ProductCommentRecord();
		recordFilter.setProductId(productId);
		List<ProductCommentRecord> listRecord = session.selectList("productCommentManageMapper.queryByProductId",
				recordFilter);

		List<ProductCommentDetail> detailList = new ArrayList<ProductCommentDetail>();

		if (CollectionUtils.isEmpty(listRecord)) {
			return detailList;
		}

		ProductCommentDetail detail = null;
		UserRecord userRecord = new UserRecord();
		for (ProductCommentRecord record : listRecord) {
			detail = new ProductCommentDetail();
			detail.setProductId(productId);
			detail.setUserId(record.getUserId());

			userRecord.setUserId(record.getUserId());
			detail.setUsername(userManager.getUserRecordById(userRecord).getUsername());

			detail.setSubscriptionId(record.getSubscriptionId());
			detail.setComment(record.getComment());
			detail.setCommentTime(TimeUtils.formate(record.getCommentTime(), ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS,
					ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

			detailList.add(detail);
		}

		return detailList;
	}

	public void addProductComment(ProductCommentRecord record) {
		session.selectList("productCommentManageMapper.insert", record);
	}

	public List<CommentRecord> getProductCommentAndUser(ProductFilter productFilter) {
		List<CommentRecord> list = session.selectList("queryConmmentAndUser", productFilter);
		return list;
	}

	public String deleteCommentById(CommentRecord commentRecord) {
		int result = session.delete("deleteCommentById", commentRecord);
		return String.valueOf(result);
	}

	public List<CommentResult> queryCommentByName(CommentResult record) {
		List<CommentResult> list = session.selectList("queryConmmentByName", record);
		return list;
	}

	/**
	 * 转换产品状态
	 */
	public String convertStatus(int status) {
		switch (status) {
		case ConstantCode.ProductStatus.DRAFT:
			return ConstantCode.ProductStatus.DRAFT_STRING;
		case ConstantCode.ProductStatus.ONLINE:
			return ConstantCode.ProductStatus.ONLINE_STRING;
		case ConstantCode.ProductStatus.OFFLINE:
			return ConstantCode.ProductStatus.OFFLINE_STRING;
		default:
			return ConstantCode.ProductStatus.DRAFT_STRING;
		}
	}

	/**
	 * 转换产品操作类型
	 */
	public int convertOperateType(int operateType) {
		switch (operateType) {
		case ConstantCode.ProductOperateType.ONLIE:
			return ConstantCode.ProductStatus.ONLINE;
		case ConstantCode.ProductOperateType.OFFLINE:
			return ConstantCode.ProductStatus.OFFLINE;
		default:
			return ConstantCode.ProductStatus.OFFLINE;
		}
	}
}
