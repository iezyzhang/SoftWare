package com.bookshop.controller.backstage;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.model.product.CategroyRecord;
import com.bookshop.service.portal.PortalService;
import com.bookshop.service.user.ManagerService;

@Controller
public class BackstageCategroyController {
	@Autowired
	private PortalService portalService;
	@Autowired
	private ManagerService managerService;

	/**
	 * 目录品类管理页面
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_toCategroyIndex")
	public ModelAndView toCategroyIndex(HttpServletRequest request, ModelAndView model) {
		String adminName = request.getParameter("adminName");
		String username = (String) request.getSession().getAttribute("adminName");
		if (username == null) {
			model.addObject("message", "您未登陆或者登陆超时");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
		// 获取权限
		ManagerRecord recorda = new ManagerRecord();
		recorda.setManagerName(username);
		recorda = managerService.getMangerRecordByName(recorda);
		String role = recorda.getRole();
		// 检测权限
		if (!role.equals("0") && !role.equals("2")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}
		CategroyRecord record = new CategroyRecord();
		List<CategroyRecord> categroyList = portalService.getCategroyList(record);
		System.out.println("backstage_toCategroyIndex/categroyList//" + categroyList);
		Iterator<CategroyRecord> iterator = categroyList.iterator();
		while (iterator.hasNext()) {
			System.out.println(
					"[INFO]:backstage_toCategroyIndex/categroyList//categroyId//" + iterator.next().getCategroyItem());
		}
		System.out.println("backstage_toCategroyIndex/categroyList//" + categroyList);

		model.addObject("categroyList", categroyList);
		model.addObject("adminName", adminName);
		model.setViewName("/backstage/Categroy/index");
		return model;

	}

	/**
	 * 根据名字查询类别
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_queryCategroyByName")
	public ModelAndView queryCategroyByName(HttpServletRequest request, ModelAndView model) {
		String categroyName = request.getParameter("username");
		CategroyRecord record = new CategroyRecord();
		record.setCategroyItem(categroyName);
		List<CategroyRecord> categroyList = portalService.queryCategroyListByName(record);

		model.addObject("categroyList", categroyList);
		model.setViewName("/backstage/Categroy/index");
		return model;
	}

	@RequestMapping("backstage_deleteCategroyById")
	public ModelAndView deleteCategroyById(HttpServletRequest request, ModelAndView model) {
		String categroyId = request.getParameter("categroyId");

		CategroyRecord record = new CategroyRecord();
		record.setCategroyId(Integer.valueOf(categroyId));
		String result = portalService.deleteCategroy(record);

		if (result.equals("1")) {
			model.addObject("message", "删除类目成功！");
			model.addObject("result", 0);

			System.out.println("[INFO]backstage_deleteCategroyById删除类目成功");

		} else {
			model.addObject("message", "删除类目失败！");
			model.addObject("result", -1);

			System.out.println("[INFO]backstage_deleteCategroyById删除类目失败");
		}
		model.setViewName("/backstage/operateResult");
		return model;
	}

	/**
	 * 跳转到新增目录页面
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_toAddCategroy")
	public ModelAndView toAddCategroy(HttpServletRequest request, ModelAndView model) {
		model.setViewName("/backstage/Categroy/add");
		return model;

	}

	/**
	 * 新增目录
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_addCategroy")
	public ModelAndView addCategroyById(HttpServletRequest request, ModelAndView model) {
		String categroyName = request.getParameter("categroyName");

		CategroyRecord record = new CategroyRecord();
		record.setCategroyItem(categroyName);
		String result = portalService.insertCategroy(record);

		if (result.equals("1")) {
			model.addObject("message", "删除类目成功！");
			model.addObject("result", 0);

			System.out.println("[INFO]backstage_deleteCategroyById新增类目成功");

		} else {
			model.addObject("message", "删除类目失败！");
			model.addObject("result", -1);

			System.out.println("[INFO]backstage_deleteCategroyById删新增类目失败");
		}
		model.setViewName("/backstage/operateResult");
		return model;
	}
}
