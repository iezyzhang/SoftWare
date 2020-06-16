package com.bookshop.controller.backstage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop.common.ConstantCode;
import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.model.notice.NoticeRecord;
import com.bookshop.service.notice.NoticeService;
import com.bookshop.service.user.ManagerService;
import com.bookshop.utils.TimeUtils;

@Controller
public class BackstageNoticeController {
	@Autowired
	private NoticeService noticeService;

	@Autowired
	private ManagerService managerService;

	/*
	 * 查询并返回所有公告
	 */
	@RequestMapping("backstage_getNoticeContent")
	public ModelAndView getNoticeContent(ModelAndView model, HttpServletRequest request) {
		// 超时登陆---------------------------------------------
		String adminName = (String) request.getSession().getAttribute("adminName");
		if (adminName == null) {
			model.addObject("message", "您未登陆或者登陆已超时");
			model.addObject("result", -1);
			model.setViewName("backstage/operateResult");
			return model;
		}

		// 权限验证---------------------------------------------
		String username = (String) request.getSession().getAttribute("adminName");
		ManagerRecord recorda = new ManagerRecord();
		recorda.setManagerName(username);
		recorda = managerService.getMangerRecordByName(recorda);
		String role = recorda.getRole();
		// 最高管理员或者用户管理员
		if (!role.equals("0") && !role.equals("3")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}

		System.out.println("backstage_getNoticeContent正在获取公告");
		NoticeRecord noticeRecord = new NoticeRecord();
		List<NoticeRecord> noticeRecordList = noticeService.getAllNotice(noticeRecord);
		System.out.println("backstage_getNoticeContent获取list" + noticeRecordList);
		model.addObject("noticeRecordList", noticeRecordList);
		model.setViewName("backstage/Notice/index");
		System.out.println("backstage_getNoticeContent获取公告完成");
		return model;

	}

	/**
	 * 转到公告编辑页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_editNoticeContent")
	public ModelAndView editNoticeContent(HttpServletRequest request, ModelAndView model) {
		System.out.println("backstage_editNoticeContent start running对编辑菜单进行加载");
		String noticeId = request.getParameter("noticeId");
		int id = Integer.valueOf(noticeId);

		NoticeRecord record = new NoticeRecord();
		record.setNoticeId(id);

		System.out.println("noticeId=" + id);
		NoticeRecord noticeRecord = noticeService.getOneNotice(record);
		model.addObject("noticeDetail", noticeRecord);
		model.setViewName("backstage/Notice/edit");
		System.out.println("backstage_editNoticeContent running complete加载完成");
		return model;
	}

	/**
	 * 修改保存公告
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_modifyNotice")
	public ModelAndView modifyNotice(HttpServletRequest request, ModelAndView model) {
		System.out.println("backstage_modifyNotice 公告保存代码 is runnning");
		String textAreaContent = request.getParameter("textArea");
		int noticeId = Integer.valueOf(request.getParameter("noticeId"));
		System.out.println("noticeId:" + noticeId);
		NoticeRecord notice = new NoticeRecord();
		notice.setNoticeId(noticeId);
		notice.setNoticeContent(textAreaContent.replace(" ", ""));

		notice.setCreateTime(TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

		String result = noticeService.saveNotice(notice);
		if (result.equals("1")) {
			model.addObject("message", "保存公告成功！");
			model.addObject("result", 0);
			model.setViewName("/backstage/operateResult");
			System.out.println("backstage_modifyNotice公告保存成功");

		} else {
			model.addObject("message", "保存公告失败！");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			System.out.println("backstage_modifyNotice公告保存失败");
		}
		return model;

	}

	/**
	 * 跳转到公告增加页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_toAddNotice")
	public ModelAndView toAddNotice(ModelAndView model) {
		model.setViewName("/backstage/Notice/add");
		return model;

	}

	/**
	 * 保存新增的公告
	 * 
	 * @param request
	 * @param model
	 * @return
	 */

	@RequestMapping("backstage_saveNewNotice")
	public ModelAndView saveNewNotice(HttpServletRequest request, ModelAndView model) {
		System.out.println("backstage_saveNewNotice保存新增公告 is running");
		String noticeContent = request.getParameter("textArea");

		NoticeRecord record = new NoticeRecord();
		record.setNoticeContent(noticeContent.replace(" ", ""));
		record.setCreateTime(TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

		String result = noticeService.saveNewNotice(record);
		if (result.equals("1")) {
			model.addObject("message", "新增公告成功！");
			model.addObject("result", 0);

			System.out.println("backstage_modifyNotice公告保存成功");

		} else {
			model.addObject("message", "新增公告失败！");
			model.addObject("result", -1);

			System.out.println("backstage_modifyNotice公告保存失败");
		}
		model.setViewName("/backstage/operateResult");
		return model;
	}

	/**
	 * 公告查询
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("backstage_noticeManage")
	public ModelAndView selectNotice(HttpServletRequest request, ModelAndView model) {
		System.out.println("backstage_noticeManage查询公告 is running");

		String noticeSeclect = request.getParameter("noticeSelect");
		System.out.println("backstage_noticeManage查询公告:" + noticeSeclect);

		NoticeRecord notice = new NoticeRecord();
		notice.setNoticeContent(noticeSeclect);

		List<NoticeRecord> noticeRecordList = noticeService.selectNotice(notice);
		model.addObject("noticeRecordList", noticeRecordList);
		model.setViewName("/backstage/Notice/index");
		System.out.println("backstage_noticeManage查询公告完成");
		return model;

	}

	@RequestMapping("backstage_deleteNoticeContent")
	public ModelAndView deleteNoticeContent(HttpServletRequest request, ModelAndView model) {
		String noticeId = request.getParameter("noticeId");

		NoticeRecord notice = new NoticeRecord();
		notice.setNoticeId(Integer.valueOf(noticeId));

		String result = noticeService.deleteNoticeContent(notice);
		if (result.equals("1")) {
			model.addObject("message", "公告删除成功！");
			model.addObject("result", 0);

			System.out.println("backstage_deleteNoticeContent公告删除成功");

		} else {
			model.addObject("message", "公告删除失败！");
			model.addObject("result", -1);

			System.out.println("backstage_deleteNoticeContent公告删除失败");
		}
		model.setViewName("/backstage/operateResult");

		return model;

	}
}
