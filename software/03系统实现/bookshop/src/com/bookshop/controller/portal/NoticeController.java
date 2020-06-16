package com.bookshop.controller.portal;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bookshop.model.notice.NoticeRecord;
import com.bookshop.service.notice.NoticeService;

@Controller

public class NoticeController {
	@Autowired
	private NoticeService noticeService;

	/**
	 * 门户前台请求公告内容
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "fontstage_getNoticeContentToFont", produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getNoticeContentToFont() {
		System.out.println("Fontstage_getNoticeContentToFont正在获取公告");
		NoticeRecord noticeRecord = new NoticeRecord();
		List<NoticeRecord> noticeRecordList = noticeService.getAllNotice(noticeRecord);
		System.out.println("Fontstage_getNoticeContentToFont获取list" + noticeRecordList);

		String json = JSON.toJSONString(noticeRecordList);
		System.out.println("Fontstage_getNoticeContentToFont传递json" + json);

		System.out.println("Fontstage_getNoticeContentToFont获取公告完成");
		return json;

	}

}
