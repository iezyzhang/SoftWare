package com.bookshop.controller.portal;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.bookshop.common.CommonService;
import com.bookshop.common.ConstantCode;
import com.bookshop.model.address.DeliveryAddress;
import com.bookshop.model.product.CupProduct;
import com.bookshop.model.product.ProductCommentDetail;
import com.bookshop.model.product.ProductCommentRecord;
import com.bookshop.model.product.ProductDetail;
import com.bookshop.model.product.ProductFilter;
import com.bookshop.model.product.ProductRecord;
import com.bookshop.model.product.SubscriptionDetail;
import com.bookshop.model.product.SubscriptionRecord;
import com.bookshop.model.user.UserDetail;
import com.bookshop.model.user.UserFunds;
import com.bookshop.model.user.UserRecord;
import com.bookshop.service.product.ProductService;
import com.bookshop.service.product.SubscriptionService;
import com.bookshop.service.user.UserService;
import com.bookshop.utils.TimeUtils;
import com.bookshop.utils.UUIDGenerator;

@Controller
public class ProductController {
	@Autowired
	private ProductService productManager;

	@Autowired
	private UserService userManager;

	@Autowired
	private SubscriptionService subscriptionManager;

	@RequestMapping("searchProduct")
	public ModelAndView toProductManage(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		// 目前只支持产品名
		String condition = request.getParameter("condition");

		// 分类
		String categoryId = request.getParameter("categroyId");

		ProductFilter productFilter = new ProductFilter();
		productFilter.setProductName(condition);
		productFilter.setCategoryId(categoryId);

		// 只查询上线的产品
		productFilter.setStatus(ConstantCode.ProductStatus.ONLINE);

		List<ProductDetail> productList = productManager.getProductList(productFilter);

		model.setViewName("productList");
		model.addObject("productList", productList);
		return model;
	}

	/**
	 * 
	 * [简要描述]:详情
	 * 
	 * @param
	 * @return ModelAndView
	 * @Exception
	 */
	@RequestMapping("productDetail")
	public ModelAndView productDetail(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		String productId = request.getParameter("productId");

		ProductDetail productDetail = productManager.getProductDetailById(productId);

		if (null == productDetail) {
			model.setViewName("error");
			model.addObject("message", "出错啦！产品不存在！");
			return model;
		}

		model.setViewName("productDetail");
		model.addObject("productDetail", productDetail);

		// 查询评论
		List<ProductCommentDetail> commentList = productManager.getProductCommentByProductId(productId);
		model.addObject("commentList", commentList);

		// 分类
		model.addObject("category", productDetail.getCategory());

		return model;
	}

	/**
	 * 
	 * [简要描述]:转到产品评价
	 * 
	 * @param
	 * @return ModelAndView
	 * @Exception
	 */
	@RequestMapping("toAddComment")
	public ModelAndView toAddComment(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		String productId = request.getParameter("productId");
		String subscriptionId = request.getParameter("subscriptionId");

		ProductDetail productDetail = productManager.getProductDetailById(productId);

		if (null == productDetail) {
			model.setViewName("error");
			model.addObject("message", "出错啦！产品不存在！");
			return model;
		}

		model.setViewName("productDetail");
		model.addObject("productDetail", productDetail);
		model.addObject("subscriptionId", subscriptionId);

		model.setViewName("addProductComment");

		return model;
	}

	/**
	 * 
	 * [简要描述]:新增评价
	 * 
	 * @param
	 * @return ModelAndView
	 * @Exception
	 */
	@RequestMapping("addProductComment")
	public ModelAndView addProductComment(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);
		String commentText = request.getParameter("commentText");
		String productId = request.getParameter("productId");
		String subscriptionId = request.getParameter("subscriptionId");

		ProductDetail productDetail = productManager.getProductDetailById(productId);
		UserRecord userRecord = new UserRecord();
		userRecord.setUsername(username);
		userRecord = userManager.getUserRecordByName(userRecord);

		if (null == productDetail) {
			model.setViewName("error");
			model.addObject("message", "出错啦！产品不存在！");
			return model;
		}

		ProductCommentRecord productCommentRecord = new ProductCommentRecord();
		productCommentRecord.setComment(commentText);
		productCommentRecord.setCommentTime(TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS));
		productCommentRecord.setProductId(productId);
		productCommentRecord.setUserId(userRecord.getUserId());
		productCommentRecord.setSubscriptionId(subscriptionId);

		productManager.addProductComment(productCommentRecord);

		// 更新订购关系状态为已评论
		SubscriptionRecord subscriptionRecord = subscriptionManager.getSubscriptionRecordById(subscriptionId);

		if (null == subscriptionRecord) {
			model.setViewName("error");
			model.addObject("message", "出错啦！订单不存在！");
			return model;
		}
		subscriptionRecord.setStatus(ConstantCode.SubscriptionStatus.COMMENTED);
		subscriptionManager.modify(subscriptionRecord);

		model.setViewName("success");
		model.addObject("message", "添加评价成功！");

		return model;
	}

	/**
	 * 
	 * [简要描述]:转到购买页面
	 * 
	 * @param
	 * @return ModelAndView
	 * @Exception
	 */
	@RequestMapping("toSubscribe")
	public ModelAndView toSubscribe(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		String totalCount = request.getParameter("buyCount");
		CommonService.setUserSession(request, model, username);

		String productId = request.getParameter("productId");

		ProductDetail productDetail = productManager.getProductDetailById(productId);

		if (null == productDetail) {
			model.setViewName("error");
			model.addObject("message", "出错啦！产品不存在！");
			return model;
		}

		// 查询用户信息
		UserDetail userInfo = userManager.getUserDetail(username);
		List<DeliveryAddress> deliveryAddressList = userInfo.getDeliveryAddress();

		model.setViewName("submitSubscription");

		List<ProductDetail> productList = new ArrayList<ProductDetail>();
		productList.add(productDetail);
		model.addObject("productList", productList);

		// 收货地址
		model.addObject("address", deliveryAddressList);

		// 是VIP，价格就打八折
		String vipPriceString = "无";
		String totalPriceString = "无";
		float totalPrice = 0;
		if (ConstantCode.IS_VIP_YES_STRING.equals(userInfo.getIsVip())) {
			float vipPrice = productDetail.getPrice() * 0.8f;
			vipPriceString = String.valueOf(vipPrice);
			totalPrice = vipPrice * Integer.valueOf(totalCount);
			totalPriceString = String.valueOf(totalPrice);
		} else {
			totalPrice = productDetail.getPrice() * Integer.valueOf(totalCount);
			totalPriceString = String.valueOf(totalPrice);
		}

		productDetail.setVipPrice(vipPriceString);
		// 数量
		productDetail.setTotalCount(Integer.valueOf(totalCount));
		productDetail.setTotalPrice(totalPriceString);

		model.addObject("allPrice", totalPrice);

		return model;
	}

	/**
	 * 
	 * [简要描述]:提交订单
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws UnsupportedEncodingException
	 * @Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("submitSubscribe")
	public ModelAndView submitSubscribe(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		// 获取字符串数组,里面有productId和数量
		String paramArr = request.getParameter("jsonArr");
		String jsonArrMessage = request.getParameter("jsonArrMessage");

		// 总价
		// String allPrice = request.getParameter("allPrice");

		// 发货地址
		String address = request.getParameter("address");

		if (StringUtils.isEmpty(paramArr)) {
			model.setViewName("error");
			model.addObject("message", "没有购买商品!");
			return model;
		}

		String[] paramStringArr = paramArr.split(" " + "\\|");
		String[] jsonArrMessageArr = jsonArrMessage.split(" " + "\\|");

		// 获取产品
		List<ProductDetail> productList = new ArrayList<ProductDetail>();
		ProductDetail productDetail = null;

		int x = 0;
		for (String s : paramStringArr) {
			if (StringUtils.isEmpty(s)) {
				continue;
			}
			String[] sArr = s.split(" ");
			productDetail = productManager.getProductDetailById(sArr[0]);

			if (null == productDetail) {
				model.setViewName("error");
				model.addObject("message", "出错啦！产品不存在，请检查重新购买!");
				return model;
			}

			productDetail.setTotalCount(Integer.parseInt(sArr[1]));
			productDetail.setTotalPrice(sArr[2]);
			productDetail.setMessage(jsonArrMessageArr[x]);
			productList.add(productDetail);
			x++;
		}

		if (StringUtils.isEmpty(paramArr)) {
			model.setViewName("error");
			model.addObject("message", "没有订购商品!");
			return model;
		}

		// 查询用户信息
		UserDetail userInfo = userManager.getUserDetail(username);

		// 处理订单
		SubscriptionRecord subsRecord = null;
		for (ProductDetail pro : productList) {
			// 存货
			if (pro.getStock() <= 0) {
				model.setViewName("error");
				model.addObject("message", "没有库存了,请选购其他的书籍");
				return model;
			}

			subsRecord = new SubscriptionRecord();
			subsRecord.setUserId(userInfo.getUserId());
			subsRecord.setProductId(pro.getProductId());

			// 收货完成，可以添加评价
			subsRecord.setStatus(ConstantCode.SubscriptionStatus.WAIT_SEND);
			String crurrentTime = TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS);
			subsRecord.setSubscriptionTime(crurrentTime);
			subsRecord.setMessage(pro.getMessage());
			subsRecord.setTotalCount(pro.getTotalCount());
			subsRecord.setTotalPrice(Float.parseFloat(pro.getTotalPrice()));
			subsRecord.setAddress(address);
			subscriptionManager.addSubscription(subsRecord);

			// 更新产品销量,和存货
			ProductRecord record = new ProductRecord();
			record.setProductId(pro.getProductId());
			record.setSalesvolume(pro.getTotalCount());
			productManager.updateSalesvolume(record);
			UserFunds userFunds = userManager.getUserFunds(userInfo.getUserId());
			if (userFunds == null) {
				userFunds = new UserFunds();
				userFunds.setUserId(userInfo.getUserId());
			}
			userFunds.setPayMoney(new Float(NumberUtils.toFloat(pro.getTotalPrice())).intValue());
			userManager.updateUserFunds(userFunds);
		}

		model.setViewName("success");
		model.addObject("message", "订购成功，请等待发货！");

		// 清空购物车
		String sessionId = WebUtils.getSessionId(request);
		Object cupObj = WebUtils.getSessionAttribute(request, sessionId);

		if (cupObj != null) {
			Map<String, Object> mapCup = (Map<String, Object>) cupObj;

			mapCup.put(ConstantCode.SESSION_COUNT, "0");
			mapCup.put(ConstantCode.SESSION_PRODUCTLIST, new ArrayList<CupProduct>());
		}

		return model;
	}

	/**
	 * 
	 * [简要描述]:我的订单
	 * 
	 * @param
	 * @return ModelAndView
	 * @Exception
	 */
	@RequestMapping("mySubscription")
	public ModelAndView mySubscription(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		// 查询用户信息
		UserDetail userInfo = userManager.getUserDetail(username);

		// 查询用户订单信息
		List<SubscriptionDetail> subList = subscriptionManager.getSubByUserId(userInfo.getUserId());

		// 查询产品信息
		ProductRecord productRecord = null;
		for (SubscriptionDetail subDetail : subList) {

			productRecord = productManager.getProductRecordById(subDetail.getProductId());
			subDetail.setIconUrl(productRecord.getIconUrl());
			subDetail.setPrice(productRecord.getPrice());
			subDetail.setMarketPrice(productRecord.getMarketPrice());
			subDetail.setProductName(productRecord.getProductName());
		}

		model.setViewName("mySubscription");
		model.addObject("subList", subList);

		return model;
	}

	/**
	 * 
	 * [简要描述]:加入购物车
	 * 
	 * @param
	 * @return 数量
	 * @Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("addToCup")
	@ResponseBody
	public String addToCup(HttpServletRequest request, String username, String productId, String bookCount) {
		// 获取购物车
		String sessionId = WebUtils.getSessionId(request);
		Object cupObj = WebUtils.getSessionAttribute(request, sessionId);

		if (cupObj != null) {
			Map<String, Object> mapCup = (Map<String, Object>) cupObj;

			String countString = (String) mapCup.get(ConstantCode.SESSION_COUNT);

			int addInt = Integer.parseInt(countString) + Integer.parseInt(bookCount);

			mapCup.put(ConstantCode.SESSION_COUNT, String.valueOf(addInt));

			// 添加productId
			List<CupProduct> productList = (List<CupProduct>) mapCup.get(ConstantCode.SESSION_PRODUCTLIST);

			CupProduct cupProduct = new CupProduct();
			String cupId = UUIDGenerator.getUUID();
			cupProduct.setCupId(cupId);
			cupProduct.setCount(Integer.valueOf(bookCount));
			cupProduct.setProductId(productId);
			productList.add(cupProduct);

			return String.valueOf(addInt);
		}

		return "0";
	}

	/**
	 * 转到购物车ﳵ
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("shoppingCar")
	public ModelAndView shoppingCar(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		String sessionId = WebUtils.getSessionId(request);
		Object cupObj = WebUtils.getSessionAttribute(request, sessionId);

		if (cupObj == null) {
			model.setViewName("myCup");
			return model;
		}

		Map<String, Object> mapCup = (Map<String, Object>) cupObj;
		List<CupProduct> productList = (List<CupProduct>) mapCup.get(ConstantCode.SESSION_PRODUCTLIST);

		// 查询图书
		List<ProductDetail> cupProduct = new ArrayList<ProductDetail>();
		ProductDetail detail = null;

		float totalPrice = 0;
		for (CupProduct product : productList) {
			detail = productManager.getProductDetailById(product.getProductId());
			detail.setCupCount(product.getCount());
			detail.setCupId(product.getCupId());
			cupProduct.add(detail);

			totalPrice += detail.getPrice() * product.getCount();
		}

		model.setViewName("myCup");
		model.addObject("cupProductList", cupProduct);
		model.addObject("totalPrice", totalPrice);
		return model;
	}

	/**
	 * 
	 * [简要描述]:清空
	 * 
	 * @param
	 * @return 数量
	 * @Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("clearCup")
	public ModelAndView clearCup(HttpServletRequest request, ModelAndView model) {

		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		// 获取购物车
		String sessionId = WebUtils.getSessionId(request);
		Object cupObj = WebUtils.getSessionAttribute(request, sessionId);

		if (cupObj != null) {
			Map<String, Object> mapCup = (Map<String, Object>) cupObj;

			mapCup.put(ConstantCode.SESSION_COUNT, "0");
			mapCup.put(ConstantCode.SESSION_PRODUCTLIST, new ArrayList<CupProduct>());
		}

		model.setViewName("myCup");
		model.addObject("totalPrice", 0);
		return model;
	}

	/**
	 * 
	 * [简要描述]:删除
	 * 
	 * @param
	 * @return
	 * @Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("deleteCup")
	public ModelAndView deleteCup(HttpServletRequest request, ModelAndView model) {

		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		String productId = request.getParameter("productId");
		String cupCount = request.getParameter("cupCount");

		// 获取购物车
		String sessionId = WebUtils.getSessionId(request);
		Object cupObj = WebUtils.getSessionAttribute(request, sessionId);

		if (cupObj != null) {
			Map<String, Object> mapCup = (Map<String, Object>) cupObj;

			List<CupProduct> productList = (List<CupProduct>) mapCup.get(ConstantCode.SESSION_PRODUCTLIST);

			int count = Integer.parseInt(cupCount);

			Iterator<CupProduct> iterator = productList.iterator();

			while (iterator.hasNext()) {
				CupProduct product = iterator.next();
				if (product.getProductId().equals(productId) && count == product.getCount()) {
					iterator.remove();
					break;
				}
			}

			String countString = (String) mapCup.get(ConstantCode.SESSION_COUNT);

			int addInt = Integer.parseInt(countString) - Integer.parseInt(cupCount);

			mapCup.put(ConstantCode.SESSION_COUNT, String.valueOf(addInt));

			// 查询图书
			List<ProductDetail> cupProduct = new ArrayList<ProductDetail>();
			ProductDetail detail = null;

			// 总价格
			float totalPrice = 0;
			for (CupProduct product : productList) {
				detail = productManager.getProductDetailById(product.getProductId());
				detail.setCupCount(product.getCount());
				detail.setCupId(product.getCupId());
				cupProduct.add(detail);

				totalPrice += detail.getPrice() * product.getCount();
			}

			model.addObject("cupProductList", cupProduct);
			model.addObject("totalPrice", totalPrice);
		}

		model.setViewName("myCup");
		return model;
	}

	/**
	 * 
	 * [简要描述]:购物车结算
	 * 
	 * @param
	 * @return ModelAndView
	 * @Exception
	 */
	@RequestMapping("cupCount")
	public ModelAndView cupCount(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		// 获取字符串数组,里面有productId和数量
		String paramArr = request.getParameter("jsonArr");

		if (StringUtils.isEmpty(paramArr)) {
			model.setViewName("error");
			model.addObject("message", "购物车中没有商品!");
			return model;
		}

		String[] arr = paramArr.split("\\|");

		// 获取产品
		List<ProductDetail> productList = new ArrayList<ProductDetail>();
		ProductDetail productDetail = null;
		for (String s : arr) {
			if (StringUtils.isEmpty(s)) {
				continue;
			}
			String[] sArr = s.split(",");
			productDetail = productManager.getProductDetailById(sArr[0]);
			productDetail.setTotalCount(Integer.parseInt(sArr[1]));
			productList.add(productDetail);
		}

		// 查询用户信息
		UserDetail userInfo = userManager.getUserDetail(username);

		// 处理价格信息
		float allPrice = 0;
		for (ProductDetail detail : productList) {
			// 是VIP，价格就打八折
			String vipPriceString = "无";
			String totalPriceString = "无";
			float totalPrice = 0;
			if (ConstantCode.IS_VIP_YES_STRING.equals(userInfo.getIsVip())) {
				float vipPrice = detail.getPrice() * 0.8f;
				vipPriceString = String.valueOf(vipPrice);
				totalPrice = vipPrice * detail.getTotalCount();
				totalPriceString = String.valueOf(totalPrice);
			} else {
				totalPrice = detail.getPrice() * detail.getTotalCount();
				totalPriceString = String.valueOf(totalPrice);
			}

			detail.setVipPrice(vipPriceString);
			detail.setTotalPrice(totalPriceString);
			allPrice += totalPrice;
		}

		List<DeliveryAddress> deliveryAddressList = userInfo.getDeliveryAddress();

		model.addObject("productList", productList);
		// 收货地址
		model.addObject("address", deliveryAddressList);

		model.addObject("allPrice", allPrice);

		model.setViewName("submitSubscription");

		return model;
	}

	@RequestMapping("changeSubscriptionStatus")
	@ResponseBody
	public String changeSubscriptionStatus(HttpServletRequest request) {
		String changeStatus = request.getParameter("changeStatus");
		String subscriptionId = request.getParameter("subscriptionId");

		// 日志
		System.out.println("[INFO]changeSubscriptionStatus/changeStatus//" + changeStatus);
		System.out.println("[INFO]changeSubscriptionStatus/ subscriptionId//" + subscriptionId);

		SubscriptionRecord records = subscriptionManager.getSubscriptionRecordById(subscriptionId);
		records.setStatus(Integer.valueOf(changeStatus));

		String result = subscriptionManager.updateSubscriptionStatus(records);

		return result;

	}
}
