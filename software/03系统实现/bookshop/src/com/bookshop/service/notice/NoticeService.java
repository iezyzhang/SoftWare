package com.bookshop.service.notice;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.bookshop.model.notice.NoticeRecord;

@Service
public class NoticeService {

	@Resource
	private SqlSession session;

	/**
	 * 查询所有公告
	 * 
	 * @param noticeRecord
	 * @return
	 */
	public List<NoticeRecord> getAllNotice(NoticeRecord noticeRecord) {

		List<NoticeRecord> noticeRecordList = session.selectList("noticeManageMapper.queryByCondition", noticeRecord);

		return noticeRecordList;

	}

	/**
	 * 根据id查询
	 * 
	 * @param noticeId
	 * @return
	 */
	public NoticeRecord getOneNotice(NoticeRecord notice) {
		NoticeRecord noticeRecord = session.selectOne("noticeManageMapper.queryByCondition", notice);
		return noticeRecord;
	}

	/**
	 * 保存修改的公告
	 * 
	 * @param notice
	 * @return
	 */
	public String saveNotice(NoticeRecord notice) {

		int result = session.update("noticeManageMapper.update", notice);

		if (result == 1) {
			return String.valueOf(1);
		}
		return String.valueOf(-1);

	}

	/**
	 * 保存新增的公告
	 * 
	 * @param notice
	 * @return
	 */
	public String saveNewNotice(NoticeRecord notice) {
		int result = session.update("noticeManageMapper.insert", notice);
		if (result == 1) {
			return String.valueOf(1);
		}
		return String.valueOf(-1);

	}

	/**
	 * 公告查询
	 * 
	 * @param notice
	 * @return
	 */
	public List<NoticeRecord> selectNotice(NoticeRecord notice) {

		List<NoticeRecord> selectList = session.selectList("noticeManageMapper.queryByCondition", notice);

		return selectList;
	}

	/**
	 * 根据id删除公告
	 * 
	 * @param notice
	 * @return
	 */
	public String deleteNoticeContent(NoticeRecord notice) {
		int result = session.update("noticeManageMapper.delete", notice);
		if (result == 1) {
			return String.valueOf(1);
		}
		return String.valueOf(-1);

	}

}
