package com.bookshop.controller.backstage;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.model.user.UserFilter;
import com.bookshop.model.user.UserRecord;
import com.bookshop.model.vip.UserAndFundsDetail;
import com.bookshop.servce.vip.VipService;
import com.bookshop.service.user.ManagerService;

@Controller
public class BackstageVipController {
	@Autowired
	private VipService vipService;

	@Autowired
	private ManagerService managerService;

	/**
	 * 跳转到vip页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_toVIP")
	public ModelAndView toVipPage(ModelAndView model, HttpServletRequest request) {
		// 权限验证---------------------------------------------
		String username = (String) request.getSession().getAttribute("adminName");
		if (username == null) {
			model.addObject("message", "您未登陆或者登陆超时");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
		ManagerRecord record = new ManagerRecord();
		record.setManagerName(username);
		record = managerService.getMangerRecordByName(record);
		System.out.println("[INFO]backstage_userManage/record//" + record);
		String role = record.getRole();
		// 最高管理员或者用户管理员
		if (!role.equals("0") && !role.equals("1")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}
		UserFilter filter = new UserFilter();
		// 查询用户信息
		List<UserAndFundsDetail> userDetailList = vipService.getUserAndFunds(filter);

		System.out.println("[INFO]backstage_toVIP/userDetailList//" + userDetailList);

		model.addObject("userDetailList", userDetailList);

		Iterator<UserAndFundsDetail> ir = userDetailList.iterator();
		while (ir.hasNext()) {
			System.out.println("[INFO]backstage_toVIP/UserName//" + ir.next().getUsername());
			// System.out.println("[INFO]backstage_toVIP/ConsumeMoney//"+ir.next().getUserFundRecord().getConsumeMoney());
		}
		model.addObject("userDetailList", userDetailList);
		model.setViewName("/backstage/VIP/index");
		return model;

	}

	/**
	 * 修改是否vip
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("backstage_modifyVip")
	public ModelAndView modifyVIP(ModelAndView model, HttpServletRequest request) {
		String status = request.getParameter("setUserStatus");
		String userId = request.getParameter("userId");
		System.out.println("[INFO]backstage_modifyVip/setUserStatus\\" + status);
		System.out.println("[INFO]backstage_modifyVip/userid\\" + userId);
		UserRecord record = new UserRecord();

		record.setUserId(userId);
		record.setIsVip(Integer.valueOf(status));
		String result = vipService.modifyVip(record);
		System.out.println("backstage_modifyVip/result//" + result);
		if (result.equals("1")) {
			model.setViewName("backstage/operateResult");
			model.addObject("message", "操作成功");
			model.addObject("result", 0);
		} else {
			model.setViewName("backstage/operateResult");
			model.addObject("message", "操作失败");
			model.addObject("result", -1);
		}
		return model;
	}

	/**
	 * 根据名字进行查询
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("backstage_queryVipByName")
	public ModelAndView queryVipByVIP(ModelAndView model, HttpServletRequest request) {
		String username = request.getParameter("username");
		UserFilter filter = new UserFilter();
		filter.setUsername(username);
		// 查询用户信息
		List<UserAndFundsDetail> userDetailList = vipService.getUserAndFunds(filter);

		System.out.println("[INFO]backstage_toVIP/userDetailList//" + userDetailList);

		model.addObject("userDetailList", userDetailList);
		model.setViewName("/backstage/VIP/index");
		return model;

	}
}
