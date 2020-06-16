package com.bookshop.controller.portal;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.bookshop.common.CommonService;
import com.bookshop.common.ConstantCode;
import com.bookshop.model.product.CategroyRecord;
import com.bookshop.model.product.ProductDetail;
import com.bookshop.model.product.ProductFilter;
import com.bookshop.service.portal.PortalService;
import com.bookshop.service.product.ProductService;

@Controller
public class HomeController {
	@Autowired
	private ProductService productManager;

	@Autowired
	private PortalService portalService;

	/**
	 * 首页
	 * 
	 * @return
	 */
	@RequestMapping("index")
	public ModelAndView index(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		CommonService.setUserSession(request, model, username);

		ProductFilter productFilter = new ProductFilter();

		// 只查询上线的产品
		productFilter.setStatus(ConstantCode.ProductStatus.ONLINE);

		List<ProductDetail> productNewList = productManager.getProductNewList(productFilter);

		// 将软件工程累的书设置为特色产品
		String categoryId = "7";
		productFilter.setCategoryId(categoryId);

		List<ProductDetail> productList = productManager.getProductList(productFilter);

		model.addObject("productList_special", productList);
		model.addObject("productList", productNewList);
		model.setViewName("index");
		return model;
	}

	/**
	 * 获取菜单
	 * 
	 * @return
	 */
	@RequestMapping(value = "getCategroyRecordList", produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getCategroyRecordList() {
		CategroyRecord categroyRecord = new CategroyRecord();
		List<CategroyRecord> categroyList = portalService.getCategroyList(categroyRecord);
		System.out.println("getCategroyRecordList/categroyList//" + categroyList);
		String json = JSON.toJSONString(categroyList);
		// json = json.substring(1, json.length()-1);
		System.out.println("getCategroyRecordList/categroyList/传递json//" + json);
		return json;
	}

	/***
	 * 关于
	 * 
	 * @return
	 */
	@RequestMapping("about")
	public ModelAndView about(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		System.out.println("[INFO]about/username//" + username);
		CommonService.setUserSession(request, model, username);

		model.setViewName("about");
		return model;
	}

	/***
	 * 发货
	 * 
	 * @return
	 */
	@RequestMapping("delivery")
	public ModelAndView delivery(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		CommonService.setUserSession(request, model, username);

		model.setViewName("delivery");
		return model;
	}

	/***
	 * 新闻
	 * 
	 * @return
	 */
	@RequestMapping("news")
	public ModelAndView news(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		CommonService.setUserSession(request, model, username);

		model.setViewName("news");
		return model;
	}

	/***
	 * 联系我们
	 * 
	 * @return
	 */
	@RequestMapping("contact")
	public ModelAndView contact(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		CommonService.setUserSession(request, model, username);

		model.setViewName("contact");
		return model;
	}

}
