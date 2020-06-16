package com.bookshop.controller.backstage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop.common.ConstantCode;
import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.service.user.ManagerService;
import com.bookshop.utils.TimeUtils;

@Controller
public class BackstageManagerController {
	@Autowired
	private ManagerService managerService;

	@RequestMapping("backstage_getManagerContent")
	public ModelAndView getAdminContent(HttpServletRequest request, ModelAndView model) {
		// 权限验证和超时登陆---------------------------------------------
		String username = (String) request.getSession().getAttribute("adminName");
		if (username == null) {
			model.addObject("message", "您未登陆或者登陆已超时");
			model.addObject("result", -1);
			model.setViewName("backstage/operateResult");
			return model;
		}
		ManagerRecord recorda = new ManagerRecord();
		recorda.setManagerName(username);
		recorda = managerService.getMangerRecordByName(recorda);
		String role = recorda.getRole();
		// 最高管理员或者用户管理员
		if (!role.equals("0") && !role.equals("4")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}
		ManagerRecord record = new ManagerRecord();

		List<ManagerRecord> managerRecordList = managerService.getManagerRecordList(record);
		System.out.println("backstage_getManagerContent打印数据:");
		for (ManagerRecord managerRecord : managerRecordList) {

			System.out.println(managerRecord.getManagerName());
		}
		model.addObject("managerRecordList", managerRecordList);
		model.addObject("currentAdmin", username);
		model.setViewName("backstage/Admind/index");
		return model;

	}

	/**
	 * 删除用户
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_deleteManager")
	public ModelAndView deleteManager(HttpServletRequest request, ModelAndView model) {
		String managerId = request.getParameter("managerId");

		ManagerRecord record = new ManagerRecord();
		record.setManagerId(Integer.valueOf(managerId));

		String result = managerService.deleteManager(record);

		if (result.equals("1")) {
			model.addObject("message", "删除系统用户成功");
			model.setViewName("backstage/operateResult");
			model.addObject("result", 0);
			return model;

		} else {
			model.addObject("message", "删除系统用户失败");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}

	}

	/**
	 * 修改系统用户信息
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_updateManager")
	public ModelAndView updateManager(HttpServletRequest request, ModelAndView model) {
		String managerId = request.getParameter("managerId");
		String managerName = request.getParameter("amanagerName");
		String password = request.getParameter("adminpassword");
		String lastLoginTime = request.getParameter("alastLoginTime");
		String createTime = request.getParameter("acreateTime");
		String selectRoleId = request.getParameter("selectRoleId");
		System.out.println("[INFO]backstage_updateManager/managerId//" + managerId);
		System.out.println("[INFO]backstage_updateManager/managerName//" + managerName);
		System.out.println("[INFO]backstage_updateManager/password//" + password);
		System.out.println("[INFO]backstage_updateManager/createTime//" + createTime);
		System.out.println("[INFO]backstage_updateManager/lastLoginTime//" + lastLoginTime);
		System.out.println("[INFO]backstage_updateManager/selectRoleId//" + selectRoleId);
		System.out.println("baskstage_updateManager正在保存系统用户信息");
		ManagerRecord record = new ManagerRecord();
		record.setManagerId(Integer.valueOf(managerId));
		record.setManagerName(managerName);
		record.setPassword(password);
		record.setCreateTime(createTime);
		record.setLastLoginTime(lastLoginTime);
		record.setRole(selectRoleId);
		String result = managerService.updateManager(record);

		if (result.equals("1")) {
			model.addObject("message", "修改系统用户信息成功");
			model.setViewName("backstage/operateResult");
			model.addObject("result", 0);
			return model;

		} else {
			model.addObject("message", "修改系统用户信息失败");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}

	}

	/**
	 * 跳转到用户编辑页面
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_toUpdateManager")
	public ModelAndView toUpdateManager(HttpServletRequest request, ModelAndView model) {

		String managerId = request.getParameter("managerId");

		System.out.println("[INFO]backstage_toUpdateManager/managerId//" + managerId);

		ManagerRecord record = new ManagerRecord();
		record.setManagerId(Integer.valueOf(managerId));

		ManagerRecord managerRecordById = managerService.getManagerRecordById(record);

		model.addObject("managerRecord", managerRecordById);
		model.addObject("managerId", managerId);
		model.setViewName("/backstage/Admind/edit");

		return model;

	}

	/**
	 * 对用户进行模糊查询
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_getManagerByCondition")
	public ModelAndView getManagerByCondition(HttpServletRequest request, ModelAndView model) {
		String managerName = (String) request.getParameter("managerName");

		System.out.println("backstage_getManagerByCondition/username//" + managerName);
		ManagerRecord record = new ManagerRecord();
		record.setManagerName(managerName);
		List<ManagerRecord> managerRecordList = managerService.selectManagerRecord(record);

		model.addObject("managerRecordList", managerRecordList);
		model.setViewName("/backstage/Admind/index");
		return model;

	}

	/**
	 * 跳转到管理员增加的页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_toAddManager")
	public ModelAndView toAddManager(ModelAndView model) {
		model.setViewName("/backstage/Admind/add");
		return model;

	}

	/**
	 * 保存新增加的管理员账户
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_addManager")
	public ModelAndView addManager(HttpServletRequest request, ModelAndView model) {
		String adminName = request.getParameter("adminName");
		String password = request.getParameter("password");
		String role = request.getParameter("selectRoleId");

		System.out.println("backstage_addManager/role//" + role);
		System.out.println("backstage_addManager/AdminName//" + adminName);
		System.out.println("backstage_addManager/password//" + password);
		System.out.println("backstage_addManager/setCreateTime//"
				+ TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));
		ManagerRecord managerRecord = new ManagerRecord();
		managerRecord.setManagerName(adminName);
		managerRecord.setPassword(password);
		managerRecord.setCreateTime(TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));
		managerRecord.setRole(role);
		String result = managerService.addManagerRecord(managerRecord);

		if (result.equals("1")) {
			model.addObject("message", "增加管理员用户成功");
			model.setViewName("backstage/operateResult");
			model.addObject("result", 0);
			return model;

		} else {
			model.addObject("message", "增加管理员用户失败");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}
	}

	/**
	 * 测试用户是否存在
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("backstage_checkManagerName")
	@ResponseBody
	public String checkManagerName(HttpServletRequest request) {
		String adminName = request.getParameter("adminName");

		System.out.println("backstage_checkMangerName/adminName//" + adminName);

		ManagerRecord record = new ManagerRecord();
		record.setManagerName(adminName);

		String result = managerService.checkManagerRecord(record);
		return result;
	}
}
