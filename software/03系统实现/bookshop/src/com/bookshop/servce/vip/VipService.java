package com.bookshop.servce.vip;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.bookshop.common.ConstantCode;
import com.bookshop.model.address.AddressFilter;
import com.bookshop.model.user.UserFilter;
import com.bookshop.model.user.UserRecord;
import com.bookshop.model.vip.UserAndFundsDetail;
import com.bookshop.model.vip.UserFundRecord;
import com.bookshop.utils.TimeUtils;

@Service
public class VipService {

	@Resource
	private SqlSession session;

	public UserAndFundsDetail convertUseFundRecordToUserAndFundRecordList(UserRecord record) {
		// 建立一个积分对象
		UserFundRecord fundRecord = new UserFundRecord();
		fundRecord.setUserId(record.getUserId());
		// 根据用户id查询用户的积分
		fundRecord = session.selectOne("vipManageMapper.queryByCondition", fundRecord);

		UserAndFundsDetail userDetail = new UserAndFundsDetail();

		AddressFilter filter = new AddressFilter();
		filter.setUserId(record.getUserId());
		userDetail.setUserFundRecord(fundRecord);
		userDetail.setUserId(record.getUserId());
		userDetail.setUsername(record.getUsername());
		userDetail.setEmail(record.getEmail());
		userDetail.setIsAdmin(record.getIsAdmin());
		userDetail.setIsVip(convertYesNo(record.getIsVip()));
		userDetail.setUserStatus(getUserStatus(record.getUserStatus()));
		userDetail.setUserType(getUserType(record.getUserType()));
		userDetail.setSex(record.getSex());
		userDetail.setPhoneNumber(record.getPhoneNumber());
		userDetail.setUserFundRecord(fundRecord);
		userDetail.setBirthday(TimeUtils.formate(record.getBirthday(), ConstantCode.TIME_FORMAT_YYYYMMDD,
				ConstantCode.TIME_FORMAT_YYYY_MM_DD));

		userDetail.setCreateTime(TimeUtils.formate(record.getCreateTime(), ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS,
				ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

		userDetail.setLastLoginTime(TimeUtils.formate(record.getLastLoginTime(),
				ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS, ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

		return userDetail;
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
	 * 取出所有用户和积分数据
	 * 
	 * @return
	 */
	public List<UserAndFundsDetail> getUserAndFunds(UserFilter filter) {
		List<UserRecord> userRecordList = session.selectList("userManageMapper.queryByCondition", filter);

		List<UserAndFundsDetail> resultList = new ArrayList<UserAndFundsDetail>();

		for (UserRecord record : userRecordList) {
			resultList.add(convertUseFundRecordToUserAndFundRecordList(record));
		}

		return resultList;
	}

	/**
	 * 修改是否是vip
	 * 
	 * @param record
	 * @return
	 */
	public String modifyVip(UserRecord record) {
		int result = session.update("userManageMapper.updateIsVip", record);
		return String.valueOf(result);
	}
}
