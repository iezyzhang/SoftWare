package com.bookshop.controller.backstage;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.service.user.ManagerService;

@Controller
public class BackstageAuthController {
	@Autowired
	private ManagerService managerService;

	@RequestMapping(value = "backstage_getIndexMenu", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getIndexMenu(HttpServletRequest request) {
		String adminName = request.getParameter("adminName");

		ManagerRecord record = new ManagerRecord();
		record.setManagerName(adminName);
		// 搜索数据库名字的信息
		ManagerRecord managerRecord = managerService.getMangerRecordByName(record);
		// 得到权限值
		String role = managerRecord.getRole();

		System.out.println("[INFO]backstage_getIndexMenu/role//" + role);

		return role;
		// 根据权限值返回相关的菜单
		// 最高权限管理员

	}
}
