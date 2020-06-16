package com.bookshop.service.portal;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.bookshop.model.product.CategroyRecord;

@Service
public class PortalService {
	@Resource
	private SqlSession session;

	/**
	 * 初始化菜单
	 * 
	 * @param record
	 * @return
	 */
	public List<CategroyRecord> getCategroyList(CategroyRecord record) {
		List<CategroyRecord> categroyList = session.selectList("categroyMapper.queryAll", record);
		System.out.println("getCategroyList/service/categroyList//" + categroyList);
		return categroyList;
	}

	/**
	 * 模糊搜索类别
	 * 
	 * @param record
	 * @return
	 */
	public List<CategroyRecord> queryCategroyListByName(CategroyRecord record) {
		List<CategroyRecord> categroyList = session.selectList("categroyMapper.queryByCondition", record);
		System.out.println("【info】queryCategroyListByName/service/categroyList//" + categroyList);
		return categroyList;
	}

	/**
	 * 删除类别
	 * 
	 * @param record
	 * @return
	 */
	public String deleteCategroy(CategroyRecord record) {
		int result = session.delete("categroyMapper.delete", record);
		return String.valueOf(result);
	}

	/**
	 * 修改类别
	 * 
	 * @param record
	 * @return
	 */
	public String updateCategroy(CategroyRecord record) {
		int result = session.update("categroyMapper.update", record);
		return String.valueOf(result);
	}

	/**
	 * 新增标题
	 * 
	 * @param record
	 * @return
	 */
	public String insertCategroy(CategroyRecord record) {
		int result = session.update("categroyMapper.insert", record);
		return String.valueOf(result);
	}
}