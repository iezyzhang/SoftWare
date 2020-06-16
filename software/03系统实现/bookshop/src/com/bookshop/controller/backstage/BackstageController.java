package com.bookshop.controller.backstage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.bookshop.common.CommonService;
import com.bookshop.common.ConstantCode;
import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.model.user.UserDetail;
import com.bookshop.model.user.UserFilter;
import com.bookshop.model.user.UserRecord;
import com.bookshop.service.user.ManagerService;
import com.bookshop.service.user.UserService;
import com.bookshop.utils.TimeUtils;

@Controller
public class BackstageController {

	@Autowired
	private UserService userManager;
	@Autowired
	private ManagerService managerService;

	/**
	 * 转到后台登陆
	 * 
	 * @return
	 */
	@RequestMapping("backstage_toLogin")
	public ModelAndView toLogin(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String adminName = request.getParameter("adminName");

		CommonService.setAdminSession(request, model, adminName);
		System.out.println("backstage_toLogin/session/adminName：" + request.getSession().getAttribute("adminName"));
		model.setViewName("backstage/login");

		return model;
	}

	/**
	 * 后台登出
	 * 
	 * @return
	 */
	@RequestMapping("backstage_logOut")
	public ModelAndView logOut(HttpServletRequest request, ModelAndView model) {
		request.getSession().removeAttribute("adminName");
		request.setAttribute("adminName", null);
		System.out.println("backstage_logOut/logOut监视/adminName/" + request.getSession().getAttribute("adminName"));
		model.setViewName("backstage/login");
		return model;
	}

	/**
	 * 校验后台用户名和密码
	 * 
	 * @return 1正确 -1不正确
	 */
	@RequestMapping("backstage_checkAdminLoginInfo")
	@ResponseBody
	public String checkAdminLoginInfo(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String adminName = request.getParameter("adminName");
		String password = request.getParameter("password");
		System.out.println("BACKSTAGE_checkAdminLoginInfo is running");
		System.out.println("adminName is " + adminName);
		System.out.println("password is " + password);
		ManagerRecord manager = new ManagerRecord();
		manager.setManagerName(adminName);

		manager = managerService.checkMangerInfo(manager);
		if (manager.getManagerName().equals(adminName) && manager.getPassword().equals(password)) {
			return String.valueOf(1);
		}

		return String.valueOf(-1);
	}

	/**
	 * 登陆成功转到后台index
	 * 
	 * @return
	 */
	@RequestMapping("backstage_login")
	public ModelAndView login(HttpServletRequest request, ModelAndView model) {
		String adminName = request.getParameter("adminName");
		String sessionName = request.getParameter("adminName");
		request.getSession().setAttribute("adminName", adminName);
		if (adminName != null) {
			request.getSession().setAttribute("adminName", adminName);
		}
		// 检测登陆
		if (sessionName != null) {

		} else {
			model.addObject("message", "您未登陆或者登陆超时");
			model.addObject("result", 0);
			model.setViewName("/backstage/operateResult");
		}
		// 输出到屏幕监视
		String admin_user = (String) WebUtils.getSessionAttribute(request, "adminName");
		System.out.println("backstage_login/admin_user//" + admin_user);

		try {
			ManagerRecord managerRecord = new ManagerRecord();

			// 刷新登陆时间
			String currentTime1 = TimeUtils
					.getUTCCurrentTime(TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));
			// 日志输出

			System.out.println("[INFO]backstage_login/currentTime/117//" + currentTime1);

			if (adminName != null) {
				System.out.println("[INFO]backstage_login/adminName != null/admin_user//" + admin_user);
				managerRecord.setManagerName(adminName);
				ManagerRecord mangerRecordByName = managerService.getMangerRecordByName(managerRecord);
				mangerRecordByName.setLastLoginTime(currentTime1);
				managerService.updateManager(mangerRecordByName);
			} else {
				System.out.println("[INFO]backstage_login/adminName == null/session/admin_user//" + admin_user);
				model.addObject("adminName", admin_user);
			}
			model.setViewName("backstage/index");

			model.addObject("adminName", adminName);
		} catch (Exception e) {
			// 日志输出
			System.out.println("backstage_login/126/异常抛出");
			e.printStackTrace();
			model.setViewName("backstage/login");

		} finally {

		}
		return model;

	}

	/**
	 * 后台用户管理
	 * 
	 * @return
	 */
	@RequestMapping("backstage_userManage")
	public ModelAndView userManage(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String adminname = (String) request.getSession().getAttribute("adminName");
		System.out.println("[INFO]backstage_userManage/username//" + adminname);
		// 登陆超时
		if (adminname == null) {
			model.addObject("message", "您未登陆或者登陆超时!");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
		// 权限验证---------------------------------------------
		ManagerRecord record = new ManagerRecord();
		record.setManagerName(adminname);
		record = managerService.getMangerRecordByName(record);
		System.out.println("[INFO]backstage_userManage/record//" + record);
		String role = record.getRole();
		System.out.println("[INFO]backstage_userManage/role//" + role);
		// 最高管理员或者用户管理员
		if (!role.equals("0") && !role.equals("1")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}
		String username = request.getParameter("username");
		// 查询用户信息
		UserFilter userFilter = new UserFilter();

		if (StringUtils.isNotEmpty(username)) {
			userFilter.setUsername(username);
		}

		List<UserDetail> userDetailList = userManager.getUserDetailList(userFilter);
		for (UserDetail userDetail : userDetailList) {

			System.out.println(userDetail.getUserStatus());
		}
		model.addObject("userDetailList", userDetailList);

		model.setViewName("backstage/User/index");
		// model.addObject("username",username)
		return model;
	}

	/**
	 * 转到后台用户修改
	 * 
	 * @return
	 */
	@RequestMapping("backstage_toModifyUser")
	public ModelAndView toModifyUser(HttpServletRequest request, ModelAndView model) {

		// 获取userId
		String userId = request.getParameter("userId");

		// 查询用户信息
		UserDetail userDetail = userManager.getUserDetailById(userId);

		model.setViewName("backstage/User/edit");
		model.addObject("userDetail", userDetail);
		return model;
	}

	/**
	 * 修改基本信息
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_modifyUser")
	public ModelAndView modifyUser(HttpServletRequest submitForm, ModelAndView model) {

		String userId = submitForm.getParameter("userId");
		String email = submitForm.getParameter("userEmail");
		String sex = submitForm.getParameter("sexHidden");
		String birthday = submitForm.getParameter("birthday");
		String phoneNumber = submitForm.getParameter("phoneNumber");

		// 校验用户是否合法
		UserRecord recordCheck = new UserRecord();
		recordCheck.setUserId(userId);
		recordCheck = userManager.getUserRecordById(recordCheck);

		if (recordCheck == null) {
			model.addObject("message", "修改用户信息失败，用户不存在！");
			model.setViewName("backstage/operateResult");
			model.addObject("result", 1);
			return model;
		}

		// 目前只有修改邮箱
		recordCheck.setEmail(email);
		recordCheck.setBirthday(
				TimeUtils.formate(birthday, ConstantCode.TIME_FORMAT_YYYY_MM_DD, ConstantCode.TIME_FORMAT_YYYYMMDD));
		recordCheck.setPhoneNumber(phoneNumber);
		recordCheck.setSex(sex);
		userManager.modifyUser(recordCheck);

		model.addObject("message", "修改用户信息成功！");
		model.addObject("result", 0);

		model.setViewName("backstage/operateResult");
		return model;
	}

	/**
	 * 转到后台新增用户
	 * 
	 * @return
	 */
	@RequestMapping("backstage_toAddUser")
	public ModelAndView toAddUser(HttpServletRequest request, ModelAndView model) {

		model.setViewName("backstage/User/add");
		return model;
	}

	/**
	 * 后台普通用户
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_addUser")
	public ModelAndView addNormalUser(HttpServletRequest submitForm, ModelAndView model) {

		// 获取用户名
		String username = submitForm.getParameter("username");
		String password = submitForm.getParameter("password");
		String email = submitForm.getParameter("userEmail");
		String sex = submitForm.getParameter("sexHidden");
		String birthday = submitForm.getParameter("birthday");
		String phoneNumber = submitForm.getParameter("phoneNumber");

		UserRecord record = new UserRecord();
		record.setUsername(username);
		record.setPassword(password);
		record.setEmail(email);
		record.setIsAdmin(ConstantCode.IS_ADMIN_NO);
		record.setIsVip(ConstantCode.IS_VIP_NO);
		record.setUserStatus(ConstantCode.USER_STATUS_NORMAL);
		record.setUserType(ConstantCode.USER_TYPE_NORMAL);

		record.setSex(sex);
		record.setBirthday(
				TimeUtils.formate(birthday, ConstantCode.TIME_FORMAT_YYYY_MM_DD, ConstantCode.TIME_FORMAT_YYYYMMDD));
		record.setPhoneNumber(phoneNumber);
		record.setCreateTime(TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS));
		record.setLastLoginTime(TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS));

		userManager.addUser(record);

		model.addObject("message", "注册成功！");
		model.addObject("result", 0);

		CommonService.setUserSession(submitForm, model, username);

		model.setViewName("backstage/operateResult");
		return model;
	}

	/**
	 * 转到后台用户修改
	 * 
	 * @return
	 */
	@RequestMapping("backstage_vipIndex")
	public ModelAndView vipIndex(HttpServletRequest request, ModelAndView model) {

		// 获取userId
		String userId = request.getParameter("userId");

		// 查询用户信息
		UserDetail userDetail = userManager.getUserDetailById(userId);

		model.setViewName("backstage/User/edit");
		model.addObject("userDetail", userDetail);
		return model;
	}

	@RequestMapping("backstage_toModifyUserStatus")
	public ModelAndView modifyUserStatus(HttpServletRequest request, ModelAndView model) {

		String userId = request.getParameter("userId");
		System.out.println(request.getParameter("userStatus"));
		int userStatus = Integer.parseInt(request.getParameter("userStatus"));
		System.out.println(userStatus);
		UserRecord user = new UserRecord();
		user.setUserId(userId);
		user.setUserStatus(userStatus);
		managerService.updateUserStatus(user);

		String message = null;
		if (userStatus == 0) {
			message = "激活账户成功";
		} else {
			message = "暂停账户成功";
		}
		model.addObject("message", message);
		model.setViewName("backstage/operateResult");
		model.addObject("result", 0);
		return model;

	}

	/**
	 * 删除用户记录
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_deleteUser")
	public ModelAndView deleteUser(HttpServletRequest request, ModelAndView model) {
		String userId = (String) request.getAttribute("userId");
		UserRecord record = new UserRecord();
		record.setUserId(userId);
		String result = userManager.deleteUser(record);
		String message = null;
		if (result.equals("0")) {
			message = "删除账户成功";
			model.addObject("result", 0);
		} else {
			message = "删除账户失败";
			model.addObject("result", 1);

		}
		model.addObject("message", message);
		model.setViewName("backstage/operateResult");
		return model;

	}

}
