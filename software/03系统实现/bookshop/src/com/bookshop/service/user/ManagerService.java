package com.bookshop.service.user;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.model.user.UserRecord;

@Service
public class ManagerService {

	private ManagerRecord managerRecord;
	@Resource
	private SqlSession session;

	/**
	 * 查询管理员
	 * 
	 * @param record
	 * @return
	 */
	// 查询管理员
	public ManagerRecord checkMangerInfo(ManagerRecord record) {
		managerRecord = session.selectOne("managerMapper.querySingleByName", record);

		return managerRecord;

	}

	/**
	 * 更新用户状态
	 * 
	 * @param user
	 * @return
	 */
	// 更新用户状态
	public String updateUserStatus(UserRecord user) {

		session.update("userManageMapper.updateStatus", user);
		return String.valueOf(1);

	}

	public List<ManagerRecord> getManagerRecordList(ManagerRecord record) {
		List<ManagerRecord> managerRecordList = session.selectList("managerMapper.queryByCondition", record);

		if (org.springframework.util.CollectionUtils.isEmpty(managerRecordList)) {
			System.out.println("managerRecordList取到了空集");
			return managerRecordList;
		}
		return managerRecordList;
	}

	/**
	 * 按id取用户信息
	 * 
	 * @param record
	 * @return
	 */
	public ManagerRecord getManagerRecordById(ManagerRecord record) {

		return record = session.selectOne("managerMapper.queryByCondition", record);
	}

	/**
	 * 修改系统用户信息
	 * 
	 * @param managerRecord
	 * @return
	 */
	public String updateManager(ManagerRecord managerRecord) {

		int result = session.update("managerMapper.update", managerRecord);
		return String.valueOf(result);

	}

	/**
	 * 删除系统用户
	 * 
	 * @param managerRecord
	 * @return
	 */
	public String deleteManager(ManagerRecord managerRecord) {
		int result = session.delete("managerMapper.delete", managerRecord);
		return String.valueOf(result);
	}

	/**
	 * 根据系统用户名字取记录
	 * 
	 * @param managerRecord
	 * @return
	 */
	public ManagerRecord getMangerRecordByName(ManagerRecord managerRecord) {
		ManagerRecord record = session.selectOne("managerMapper.getManagerRecordByName", managerRecord);
		return record;
	}

	/**
	 * 根据系统用户名进行模糊查询
	 * 
	 * @param managerRecord
	 * @return
	 */
	public List<ManagerRecord> selectManagerRecord(ManagerRecord managerRecord) {
		List<ManagerRecord> ManagerRecordList = session.selectList("managerMapper.queryByCondition", managerRecord);
		return ManagerRecordList;
	}

	/**
	 * 新增系统用户
	 * 
	 * @param managerRecord
	 * @return
	 */
	public String addManagerRecord(ManagerRecord managerRecord) {
		int result = session.insert("managerMapper.insert", managerRecord);
		return String.valueOf(result);
	}

	/**
	 * 测试用户是否存在
	 * 
	 * @param managerRecord
	 * @return
	 */
	public String checkManagerRecord(ManagerRecord record) {

		Object ob = session.selectOne("managerMapper.queryByCondition", record);

		System.out.println("checkManagerRecord/ob//" + ob);
		if (ob != null && ob != "") {
			return String.valueOf(1);
		}
		return String.valueOf(0);
	}
}
