package com.bookshop.service.user;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.bookshop.common.ConstantCode;
import com.bookshop.model.user.FileInfoRecord;

/**
 * 
 * 文件信息service
 */
@Service
public class FileInfoService {
	public static final Pattern IMAGE_PATTERN = Pattern.compile("<img\\s+(?:[^>]*)src\\s*=\\s*([^>]+)",
			Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);

	@Resource
	private SqlSession session;

	/**
	 * 新增地址
	 * 
	 * @param record
	 */
	public void add(FileInfoRecord record) {
		session.insert("fileInfoManageMapper.insert", record);
	}

	/**
	 * 删除
	 * 
	 * @param record
	 */
	public void deleteByObjectId(String objectId) {
		FileInfoRecord record = new FileInfoRecord();
		record.setObjectId(objectId);
		session.delete("fileInfoManageMapper.delete", record);
	}

	/**
	 * 
	 * [简要描述]:从详情的content中获取img信息，保存起来，为删除产品用
	 * 
	 * @param
	 * @return void
	 * @Exception
	 */
	public void insertFromContent(String content, String objectId) {
		if (org.apache.commons.lang3.StringUtils.isEmpty(content)) {
			return;
		}

		// 获取图片url
		List<String> urlList = processContent(content);

		FileInfoRecord fileInfoRecord = null;
		for (String fileUrl : urlList) {
			fileInfoRecord = new FileInfoRecord();
			fileInfoRecord.setObjectId(objectId);
			fileInfoRecord.setFileType(ConstantCode.FileType.PRODUCT);
			fileInfoRecord.setFileUrl(fileUrl);
			session.insert("fileInfoManageMapper.insert", fileInfoRecord);
		}
	}

	/**
	 * 
	 * [简要描述]:利用正则匹配获取<img />里面src的内容
	 * 
	 * @param
	 * @return List<String>
	 * @Exception
	 */
	public List<String> processContent(String content) {
		Matcher matcher = IMAGE_PATTERN.matcher(content);
		List<String> list = new ArrayList<String>();

		while (matcher.find()) {
			String group = matcher.group(1);
			if (group == null) {
				continue;
			}

			// 这里可能还需要更复杂的判断,用以处理src="...."内的一些转义符
			if (group.startsWith("'")) {
				list.add(group.substring(1, group.indexOf("'", 1)));
			} else if (group.startsWith("\"")) {
				list.add(group.substring(1, group.indexOf("\"", 1)));
			} else {
				list.add(group.split("\\s")[0]);
			}
		}
		return list;

	}

	/**
	 * 
	 * [简要描述]:查询
	 * 
	 * @param
	 * @return List<String>
	 * @Exception
	 */
	public List<FileInfoRecord> getFileInfoListByObjectId(String objectId) {
		List<FileInfoRecord> resultList = null;

		FileInfoRecord record = new FileInfoRecord();
		record.setObjectId(objectId);
		resultList = session.selectList("fileInfoManageMapper.queryByObjectId", record);

		return org.springframework.util.CollectionUtils.isEmpty(resultList) ? new ArrayList<FileInfoRecord>()
				: resultList;
	}
}
