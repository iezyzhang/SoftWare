package com.bookshop.model.notice;

/**
 * 
 * 公告的记录
 * 
 * @author hebin
 *
 */
public class NoticeRecord {
	private int noticeId;
	private String noticeContent;
	private String createTime;

	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
