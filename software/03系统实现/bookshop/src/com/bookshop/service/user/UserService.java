package com.bookshop.service.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.bookshop.common.ConstantCode;
import com.bookshop.model.address.AddressFilter;
import com.bookshop.model.address.DeliveryAddress;
import com.bookshop.model.user.ShoppingCart;
import com.bookshop.model.user.UserDetail;
import com.bookshop.model.user.UserFilter;
import com.bookshop.model.user.UserFunds;
import com.bookshop.model.user.UserRecord;
import com.bookshop.system.UserContext;
import com.bookshop.utils.TimeUtils;
import com.bookshop.utils.UUIDGenerator;

@Service
public class UserService {

	@Resource
	private SqlSession session;

	@Resource
	private AddressService addressManager;

	/**
	 * 新增用户
	 * 
	 * @param record
	 */
	public void addUser(UserRecord record) {
		// 生成用户ID
		String userId = UUIDGenerator.getUUID();
		record.setUserId(userId);
		session.insert("userManageMapper.insert", record);
	}

	/**
	 * 修改
	 * 
	 * @param record
	 */
	public void modifyUser(UserRecord record) {
		session.update("userManageMapper.update", record);
	}

	/**
	 * 校验用户名是否存在
	 * 
	 * @param username
	 * @return
	 */
	public int checkUsername(String username) {
		UserRecord record = getUserByUserName(username);

		if (null == record) {
			return ConstantCode.USER_NOT_EXISTS;
		}
		return ConstantCode.USER_EXISTS;
	}

	/**
	 * 查询
	 * 
	 * @param username
	 * @return
	 */
	public UserRecord getUserRecordByName(UserRecord record) {
		record = session.selectOne("userManageMapper.querySingleByName", record);

		return record;
	}

	/**
	 * 查询
	 * 
	 * @return
	 */
	public UserRecord getUserRecordById(UserRecord record) {
		record = session.selectOne("userManageMapper.querySingleById", record);

		return record;
	}

	/**
	 * 登陆校验
	 * 
	 * @return
	 */
	public int checkLoginInfo(UserRecord record) {
		record = session.selectOne("userManageMapper.querySingleByNameAndPassword", record);

		if (null == record) {
			return ConstantCode.USER_NOT_EXISTS;
		}
		return ConstantCode.USER_EXISTS;
	}

	/**
	 * 保存内存中用户信息
	 * 
	 * @param username
	 */
	public synchronized Map<String, Object> saveUserLoginInfo(String username) {
		// 创建内存
		Map<String, Object> userMap = UserContext.create(username);

		// 创建购物车
		List<ShoppingCart> cartList = new ArrayList<ShoppingCart>();
		userMap.put(ConstantCode.CONTEXT_SHOPPING_CART, cartList);

		// 查询用户信息

		return userMap;
	}

	/**
	 * 根据用户名查询详细信息
	 * 
	 * @param username
	 */
	public UserDetail getUserDetail(String username) {
		UserRecord userRecord = getUserByUserName(username);

		if (null == userRecord) {
			return null;
		}

		return convertUserRecordToUserDetail(userRecord);

	}

	public UserRecord getUserByUserName(String username) {
		UserRecord userRecord = new UserRecord();
		userRecord.setUsername(username);
		userRecord = session.selectOne("userManageMapper.querySingleByName", userRecord);
		return userRecord;
	}

	/**
	 * 根据userId查询用户
	 */
	public UserDetail getUserDetailById(String userId) {
		UserRecord userRecord = new UserRecord();
		userRecord.setUserId(userId);
		userRecord = session.selectOne("userManageMapper.querySingleById", userRecord);

		if (null == userRecord) {
			return null;
		}

		return convertUserRecordToUserDetail(userRecord);

	}

	/**
	 * 查询所有用户
	 * 
	 * @param username
	 */
	public List<UserDetail> getUserDetailList(UserFilter filter) {
		List<UserRecord> userRecordList = session.selectList("userManageMapper.queryByCondition", filter);

		List<UserDetail> resultList = new ArrayList<UserDetail>();

		if (org.springframework.util.CollectionUtils.isEmpty(userRecordList)) {
			return resultList;
		}

		for (UserRecord record : userRecordList) {
			resultList.add(convertUserRecordToUserDetail(record));
		}

		return resultList;
	}

	/**
	 * 0：否，1：是
	 * 
	 * @param input
	 *            int数字
	 * @return 是或者否
	 */
	public static String convertYesNo(int input) {
		if (ConstantCode.IS_VIP_YES == input) {
			return ConstantCode.IS_VIP_YES_STRING;
		} else if (ConstantCode.IS_VIP_NO == input) {
			return ConstantCode.IS_VIP_NO_STRING;
		} else {
			return ConstantCode.IS_VIP_NO_STRING;
		}
	}

	/**
	 * 状态转换
	 * 
	 * @param userStatus
	 * @return
	 */
	public static String getUserStatus(int userStatus) {
		switch (userStatus) {
		case ConstantCode.USER_STATUS_NORMAL:
			return ConstantCode.USER_STATUS_NORMAL_STRING;
		case ConstantCode.USER_STATUS_SUSPEND:
			return ConstantCode.USER_STATUS_SUSPEND_STRING;
		case ConstantCode.USER_STATUS_NO_ACTIVE:
			return ConstantCode.USER_STATUS_NO_ACTIVE_STRING;
		default:
			return ConstantCode.USER_STATUS_NORMAL_STRING;
		}
	}

	/**
	 * 状态转换
	 * 
	 * @param userStatus
	 * @return
	 */
	public static String getUserType(int userType) {
		return "普通用户";
	}

	public UserDetail convertUserRecordToUserDetail(UserRecord userRecord) {
		UserDetail userDetail = new UserDetail();

		// 查询地址信息
		AddressFilter filter = new AddressFilter();
		filter.setUserId(userRecord.getUserId());
		List<DeliveryAddress> addressList = addressManager.queryAddressList(filter);

		userDetail.setUserId(userRecord.getUserId());
		userDetail.setUsername(userRecord.getUsername());
		userDetail.setEmail(userRecord.getEmail());
		userDetail.setIsAdmin(userRecord.getIsAdmin());
		userDetail.setIsVip(convertYesNo(userRecord.getIsVip()));
		userDetail.setUserStatus(getUserStatus(userRecord.getUserStatus()));
		userDetail.setUserType(getUserType(userRecord.getUserType()));
		userDetail.setSex(userRecord.getSex());
		userDetail.setPhoneNumber(userRecord.getPhoneNumber());

		userDetail.setBirthday(TimeUtils.formate(userRecord.getBirthday(), ConstantCode.TIME_FORMAT_YYYYMMDD,
				ConstantCode.TIME_FORMAT_YYYY_MM_DD));

		userDetail.setCreateTime(TimeUtils.formate(userRecord.getCreateTime(), ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS,
				ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

		userDetail.setLastLoginTime(TimeUtils.formate(userRecord.getLastLoginTime(),
				ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS, ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

		userDetail.setDeliveryAddress(addressList);

		return userDetail;
	}

	public UserFunds getUserFunds(String userId) {
		UserRecord userRecord = new UserRecord();
		userRecord.setUserId(userId);
		return getUserFunds(userRecord);
	}

	public UserFunds getUserFunds(UserRecord userRecord) {
		if (userRecord == null) {
			return null;
		}
		return session.selectOne("userFundsMapper.queryFunds", userRecord);
	}

	public void updateUserFunds(String userId, int payMoney) {
		updateUserFunds(new UserFunds(userId, payMoney));
	}

	public void updateUserFunds(UserFunds userFunds) {
		session.update("userFundsMapper.updateFunds", userFunds);
	}

	public String deleteUser(UserRecord userRecord) {
		int result = session.delete("userManageMapper.delete", userRecord);
		return String.valueOf(result);

	}
}
