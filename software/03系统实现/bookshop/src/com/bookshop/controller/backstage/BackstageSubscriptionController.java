package com.bookshop.controller.backstage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.model.product.SubscriptionRecord;
import com.bookshop.model.subscription.SubscriptionResult;
import com.bookshop.service.product.SubscriptionService;
import com.bookshop.service.user.ManagerService;

@Controller
public class BackstageSubscriptionController {
	@Autowired
	private ManagerService managerService;

	@Autowired
	private SubscriptionService subscriptionService;

	@RequestMapping("/backstage_toSubscription")
	public ModelAndView toSubscription(HttpServletRequest request, ModelAndView model) {
		// 登陆检测
		String adminName = (String) request.getSession().getAttribute("adminName");
		if (adminName == null) {
			model.addObject("message", "您未登陆或者登陆超时");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
		// 权限控制
		ManagerRecord recorda = new ManagerRecord();
		recorda.setManagerName(adminName);
		recorda = managerService.getMangerRecordByName(recorda);
		String role = recorda.getRole();

		// 最高管理员或者用户管理员
		if (!role.equals("0") && !role.equals("5")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}

		SubscriptionResult result = new SubscriptionResult();

		List<SubscriptionResult> subscriptionResultList = subscriptionService.querySbuscriptionAndUser(result);

		System.out.println("[INFO]backstage_toSubscription/subscriptionResultList//" + subscriptionResultList);

		model.addObject("subscriptionResultList", subscriptionResultList);
		model.setViewName("/backstage/Subscription/index");

		return model;

	}

	/**
	 * 查询未处理订单
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_toNoSubscription")
	public ModelAndView toNoSubscription(HttpServletRequest request, ModelAndView model) {
		// 登陆检测
		String adminName = (String) request.getSession().getAttribute("adminName");
		if (adminName == null) {
			model.addObject("message", "您未登陆或者登陆超时");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
		// 权限控制
		ManagerRecord recorda = new ManagerRecord();
		recorda.setManagerName(adminName);
		recorda = managerService.getMangerRecordByName(recorda);
		String role = recorda.getRole();

		// 最高管理员或者用户管理员
		if (!role.equals("0") && !role.equals("5")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}
		// 查询未处理的订单
		SubscriptionResult result = new SubscriptionResult();

		List<SubscriptionResult> subscriptionResultList = subscriptionService.querySbuscriptionNoCompl(result);
		model.addObject("subscriptionResultList", subscriptionResultList);
		model.setViewName("/backstage/Subscription/index");
		return model;

	}

	/**
	 * 根据id删除记录
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_deleteSubscriptionById")
	public ModelAndView deleteSubscriptionById(HttpServletRequest request, ModelAndView model) {
		String subscriptionId = (String) request.getParameter("subscriptionId");

		System.out.println("[INFO]backstage_deleteSubscriptionById/subscriptionId//" + subscriptionId);

		SubscriptionRecord record = new SubscriptionRecord();
		record.setSubscriptionId(subscriptionId);
		String result = subscriptionService.deleleSbuscriptionById(record);

		if (result.equals("1")) {
			model.addObject("message", "删除订单记录成功");
			model.addObject("result", 0);
			model.setViewName("/backstage/operateResult");
			return model;
		} else {
			model.addObject("message", "删除订单记录失败");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
	}

	/**
	 * 根据用户名 模糊查询订单
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_querySubscriptionByName")
	public ModelAndView querySubscriptionByName(HttpServletRequest request, ModelAndView model) {

		// 登陆检测
		String adminName = (String) request.getSession().getAttribute("adminName");
		if (adminName == null) {
			model.addObject("message", "您未登陆或者登陆超时");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
		// 权限控制
		ManagerRecord recorda = new ManagerRecord();
		recorda.setManagerName(adminName);
		recorda = managerService.getMangerRecordByName(recorda);
		String role = recorda.getRole();

		// 最高管理员或者用户管理员
		if (!role.equals("0") && !role.equals("5")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}
		String username = request.getParameter("managerName");
		// 查询未处理的订单
		SubscriptionResult result = new SubscriptionResult();
		result.setUserName(username);
		List<SubscriptionResult> subscriptionResultList = subscriptionService.querySubscriptionByName(result);
		model.addObject("subscriptionResultList", subscriptionResultList);
		model.setViewName("/backstage/Subscription/index");
		return model;

	}

	/**
	 * 修改订单状态
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_changeSubscriptionStatus")
	public ModelAndView changeSubscriptionStatus(HttpServletRequest request, ModelAndView model) {
		String changeStatus = request.getParameter("changeStatus");
		String subscriptionId = request.getParameter("subscriptionId");

		SubscriptionRecord record = new SubscriptionRecord();
		record = subscriptionService.getSubscriptionRecordById(subscriptionId);

		// 日志
		System.out.println("[INFO]backstage_changeSubscriptionStatus/changeStatus//" + changeStatus);
		System.out.println("[INFO]backstage_changeSubscriptionStatus/ subscriptionId//" + subscriptionId);

		record.setStatus(Integer.valueOf(changeStatus));

		String result = subscriptionService.updateSubscriptionStatus(record);

		if (result.equals("1")) {

			model.addObject("message", "发货成功");
			model.addObject("result", 0);
			model.setViewName("/backstage/operateResult");
			return model;
		} else {
			model.addObject("message", "发货失败");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}

	}

	/**
	 * 确认收货
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_acceptGoods")
	@ResponseBody
	public String AcceptGoods(HttpServletRequest request, ModelAndView model) {
		String changeStatus = request.getParameter("changeStatus");
		String subscriptionId = request.getParameter("subscriptionId");

		SubscriptionRecord record = new SubscriptionRecord();
		record = subscriptionService.getSubscriptionRecordById(subscriptionId);

		record.setStatus(Integer.valueOf(changeStatus));

		String result = subscriptionService.updateSubscriptionStatus(record);
		if (result.equals("1")) {
			return "1";

		} else {
			return "0";
		}

	}
}
