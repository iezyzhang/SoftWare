package com.bookshop.controller.usermanager;

import java.util.List;
import java.util.Map;

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
import com.bookshop.model.product.ProductDetail;
import com.bookshop.model.product.ProductFilter;
import com.bookshop.model.user.UserDetail;
import com.bookshop.model.user.UserFunds;
import com.bookshop.model.user.UserRecord;
import com.bookshop.service.product.ProductService;
import com.bookshop.service.user.UserService;
import com.bookshop.system.UserContext;
import com.bookshop.utils.TimeUtils;

@Controller
public class UserController {
	@Autowired
	private UserService userManager;

	@Autowired
	private ProductService productManager;

	/**
	 * 转到登陆
	 * 
	 * @return
	 */
	@RequestMapping("toLogin")
	public ModelAndView toLogin(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		CommonService.setUserSession(request, model, username);

		model.setViewName("login");
		return model;
	}

	/**
	 * 登陆，需要把用户登录状态保存起来
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("login")
	public ModelAndView login(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		if (StringUtils.isEmpty(username)) {
			model.setViewName("index");
			return model;
		}

		// 更新用户最后登陆时间
		UserRecord userRecord = new UserRecord();
		userRecord.setUsername(username);
		userRecord = userManager.getUserRecordByName(userRecord);

		if (null == userRecord) {

			model.addObject("message", "登陆失败，用户不存在！");
			model.setViewName("success");
			return model;
		}
		int userStatus = userRecord.getUserStatus();
		if (userStatus == 1) {
			model.addObject("message", "登陆失败，此用户已经冻结！请联系管理员激活！");
			model.setViewName("success");
			return model;
		}

		String lastLoginTime = TimeUtils
				.getUTCCurrentTime(TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS));
		userRecord.setLastLoginTime(lastLoginTime);
		userManager.modifyUser(userRecord);

		// 分类
		String categoryId = "7";

		ProductFilter productFilter = new ProductFilter();
		productFilter.setCategoryId(categoryId);

		// 只查询上线的产品
		productFilter.setStatus(ConstantCode.ProductStatus.ONLINE);

		List<ProductDetail> productList = productManager.getProductList(productFilter);

		model.addObject("productList", productList);

		// 往用户上下文对象里存用户信息
		Map<String, Object> userMap = userManager.saveUserLoginInfo(username);

		// 存入session
		WebUtils.setSessionAttribute(request, username, userMap);

		// 把用户名存入session
		String sessionId = WebUtils.getSessionId(request);

		// 获取购物车
		Object cupObj = WebUtils.getSessionAttribute(request, sessionId);

		if (cupObj != null) {
			Map<String, Object> mapCup = (Map<String, Object>) cupObj;
			mapCup.put(ConstantCode.SESSION_USERNAME, username);
		}

		model.setViewName("index");
		model.addObject("username", username);

		return model;
	}

	/**
	 * 转到注册页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addUserPage")
	public ModelAndView addUserPage(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		CommonService.setUserSession(request, model, username);

		model.setViewName("addUserPage");
		return model;
	}

	/**
	 * 校验用户名
	 * 
	 * @param username
	 * @return
	 */
	@RequestMapping("checkUsername")
	@ResponseBody
	public String checkUsername(String username) {

		int result = userManager.checkUsername(username);

		return String.valueOf(result);
	}

	/**
	 * 登陆验证
	 * 
	 * @param username
	 * @return
	 */
	@RequestMapping("checkLoginInfo")
	@ResponseBody
	public String checkLoginInfo(String username, String password) {
		UserRecord record = new UserRecord();
		record.setUsername(username);
		record.setPassword(password);
		int result = userManager.checkLoginInfo(record);

		return String.valueOf(result);
	}

	/**
	 * 添加普通用户
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("addUser")
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

		CommonService.setUserSession(submitForm, model, username);

		model.setViewName("success");
		return model;
	}

	/**
	 * 修改基本信息
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("modifyUser")
	public ModelAndView modifyUser(HttpServletRequest submitForm, ModelAndView model) {
		String username = submitForm.getParameter("username");
		String email = submitForm.getParameter("userEmail");
		String sex = submitForm.getParameter("sexHidden");
		String birthday = submitForm.getParameter("birthday");
		String phoneNumber = submitForm.getParameter("phoneNumber");

		CommonService.setUserSession(submitForm, model, username);

		// 校验用户是否合法
		UserRecord recordCheck = new UserRecord();
		recordCheck.setUsername(username);
		recordCheck = userManager.getUserRecordByName(recordCheck);

		if (recordCheck == null) {
			model.addObject("message", "修改用户信息失败，用户不存在！");
			model.setViewName("modifyUserResult");
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

		model.setViewName("modifyUserResult");
		return model;
	}

	/**
	 * 转到重置密码页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("toResetPassword")
	public ModelAndView toResetPassword(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		// 查询用户信息
		UserRecord userRecord = new UserRecord();
		userRecord.setUsername(username);
		userRecord = userManager.getUserRecordByName(userRecord);

		if (userRecord == null) {
			model.addObject("message", "错误，用户不存在！");
			model.setViewName("modifyUserResult");
			return model;
		}

		CommonService.setUserSession(request, model, username);

		model.setViewName("resetPassword");
		model.addObject("userRecord", userRecord);

		return model;
	}

	/**
	 * 修改密码
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("resetPassword")
	public ModelAndView resetPassword(HttpServletRequest submitForm, ModelAndView model) {
		String username = submitForm.getParameter("username");
		String password = submitForm.getParameter("password");

		CommonService.setUserSession(submitForm, model, username);

		// 校验用户是否合法
		UserRecord recordCheck = new UserRecord();
		recordCheck.setUsername(username);
		recordCheck = userManager.getUserRecordByName(recordCheck);

		if (recordCheck == null) {
			model.addObject("message", "重置密码失败，用户不存在！");
			model.setViewName("modifyUserResult");
			return model;
		}

		recordCheck.setPassword(password);
		userManager.modifyUser(recordCheck);

		model.addObject("message", "重置密码成功！");

		model.setViewName("modifyUserResult");
		return model;
	}

	/**
	 * 登出
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("loginOut")
	public ModelAndView loginOut(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		// 删除session
		request.getSession().removeAttribute(username);

		// 删除内存
		UserContext.remove(username);

		// 删除购物车用户
		String sessionId = WebUtils.getSessionId(request);
		Object cupObj = WebUtils.getSessionAttribute(request, sessionId);

		if (cupObj != null) {
			Map<String, Object> mapCup = (Map<String, Object>) cupObj;
			mapCup.put(ConstantCode.SESSION_USERNAME, null);
		}

		model.setViewName("index");
		return model;
	}

	/**
	 * 用户面板
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("myAccount")
	public ModelAndView toUserManage(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		model.setViewName("myAccount");
		return model;
	}

	/**
	 * 用户面板-基本信息
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("userInfoDetail")
	public ModelAndView toUserInfoDetail(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		// 查询用户信息
		UserDetail userDetail = userManager.getUserDetail(username);

		model.setViewName("userInfoDetail");
		model.addObject("userDetail", userDetail);
		return model;
	}

	/**
	 * 转到用户VIP
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("toVip")
	public ModelAndView toVip(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);

		// 查询用户订购书籍消费总额.
		UserRecord userRecord = userManager.getUserByUserName(username);
		UserFunds ufunds = userManager.getUserFunds(userRecord);
		int userMoney = ufunds == null ? 0 : ufunds.getConsumeMoney();

		model.addObject("userMoney", userMoney);
		model.addObject("userIsVip", userRecord.getIsVip());

		model.setViewName("userVip");

		return model;
	}

	/**
	 * 提交VIP申请
	 * 
	 * @param submitForm
	 * @param model
	 * @return
	 */
	@RequestMapping("applyVip")
	public ModelAndView applyVip(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		CommonService.setUserSession(request, model, username);
		UserRecord userRecrd = userManager.getUserByUserName(username);
		userRecrd.setIsVip(ConstantCode.IS_ADMIN_YES);

		model.addObject("message", "申请VIP成功！");

		model.setViewName("modifyUserResult");
		userManager.modifyUser(userRecrd);
		return model;
	}

	/**
	 * 删除商城用户
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_toDeleteUser")
	public ModelAndView deleteUser(HttpServletRequest request, ModelAndView model) {
		String userId = request.getParameter("userId");
		UserRecord user = new UserRecord();
		user.setUserId(userId);

		String result = userManager.deleteUser(user);
		if (result.equals("1")) {
			model.addObject("message", "删除商城用户成功");
			model.setViewName("backstage/operateResult");
			model.addObject("result", 0);
			return model;

		} else {
			model.addObject("message", "删除商城用户失败");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}

	}
}
