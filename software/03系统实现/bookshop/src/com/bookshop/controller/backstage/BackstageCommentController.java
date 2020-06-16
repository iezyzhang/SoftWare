package com.bookshop.controller.backstage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop.model.comment.CommentRecord;
import com.bookshop.model.comment.CommentResult;
import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.model.product.ProductFilter;
import com.bookshop.service.product.ProductService;
import com.bookshop.service.user.ManagerService;

@Controller
public class BackstageCommentController {

	@Autowired
	private ManagerService managerService;

	@Autowired
	private ProductService productService;

	/**
	 * 跳转到订单评论页面
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("backstage_toComment")
	public ModelAndView toComment(ModelAndView model, HttpServletRequest request) {

		String username = (String) request.getSession().getAttribute("adminName");
		if (username == null) {
			model.addObject("message", "您未登陆或者登陆超时");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}

		ManagerRecord recorda = new ManagerRecord();
		recorda.setManagerName(username);
		recorda = managerService.getMangerRecordByName(recorda);
		String role = recorda.getRole();

		// 最高管理员或者网站管理员
		if (!role.equals("0") && !role.equals("3")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}

		ProductFilter productFilter = new ProductFilter();
		List<CommentRecord> productCommentList = productService.getProductCommentAndUser(productFilter);
		System.out.println("[INFO]backstage_toComment/commentList//" + productCommentList);

		model.addObject("productCommentList", productCommentList);

		model.setViewName("/backstage/Comment/index");
		return model;
	}

	/**
	 * 根据id删除订单评论
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("backstage_deleteCommentById")
	public ModelAndView deleteCommentById(ModelAndView model, HttpServletRequest request) {
		String subscriptionId = request.getParameter("commentId");
		CommentRecord record = new CommentRecord();
		record.setSubscriptionId(subscriptionId);

		String result = productService.deleteCommentById(record);

		System.out.println("[INFO]backstage_deleteCommentById//result//" + result);
		if (result.equals("1")) {
			model.addObject("message", "删除评论成功");
			model.addObject("result", 0);
			model.setViewName("/backstage/operateResult");
			return model;
		} else {
			model.addObject("message", "删除评论失败");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
	}

	/**
	 * 根据用户查询订单
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("backstage_queryCommentByName")
	public ModelAndView queryCommentByName(ModelAndView model, HttpServletRequest request) {
		String username = request.getParameter("managerName");
		CommentResult record = new CommentResult();
		record.setUserName(username);

		List<CommentResult> productCommentList = productService.queryCommentByName(record);
		System.out.println("[INFO]backstage_queryCommentByName//usename//" + productCommentList);
		model.addObject("productCommentList", productCommentList);
		model.setViewName("/backstage/Comment/index");
		return model;
	}

}
