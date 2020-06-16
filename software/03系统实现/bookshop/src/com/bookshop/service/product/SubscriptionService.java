package com.bookshop.service.product;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.bookshop.common.ConstantCode;
import com.bookshop.model.product.SubscriptionDetail;
import com.bookshop.model.product.SubscriptionFilter;
import com.bookshop.model.product.SubscriptionRecord;
import com.bookshop.model.subscription.SubscriptionResult;
import com.bookshop.utils.TimeUtils;
import com.bookshop.utils.UUIDGenerator;

/**
 * 
 * 
 * 项目名称：bookshop 类名称：ProductService 类描述：产品组件 创建人：sunjin 创建时间：Mar 1, 2015
 * 11:24:44 PM 修改人：Administrator 修改时间：Mar 1, 2015 11:24:44 PM 修改备注：
 * 
 * @version
 * 
 */
@Service
public class SubscriptionService {

	@Resource
	private SqlSession session;

	/**
	 * 新增
	 * 
	 * @param record
	 */
	public void addSubscription(SubscriptionRecord record) {
		String subscriptionId = UUIDGenerator.getUUID();
		record.setSubscriptionId(subscriptionId);
		session.insert("subscriptionManageMapper.insert", record);
	}

	/* 查询所有订单 */
	public List<SubscriptionDetail> getList(String userId) {
		SubscriptionFilter filter = new SubscriptionFilter();
		filter.setUserId(userId);
		List<SubscriptionRecord> list = session.selectList("subscriptionManageMapper.querySubList", filter);

		List<SubscriptionDetail> resultList = new ArrayList<SubscriptionDetail>();

		if (CollectionUtils.isEmpty(list)) {
			return resultList;
		}

		SubscriptionDetail deSubscriptionDetail;
		for (SubscriptionRecord r : list) {
			deSubscriptionDetail = convert(r);
			resultList.add(deSubscriptionDetail);
		}

		return resultList;
	}

	// querySubList
	/**
	 * 查询
	 * 
	 * @param record
	 */
	public List<SubscriptionDetail> getSubByUserId(String userId) {
		SubscriptionFilter filter = new SubscriptionFilter();
		filter.setUserId(userId);
		List<SubscriptionRecord> list = session.selectList("subscriptionManageMapper.queryByCondition", filter);

		List<SubscriptionDetail> resultList = new ArrayList<SubscriptionDetail>();

		if (CollectionUtils.isEmpty(list)) {
			return resultList;
		}

		SubscriptionDetail deSubscriptionDetail;
		for (SubscriptionRecord r : list) {
			deSubscriptionDetail = convert(r);
			resultList.add(deSubscriptionDetail);
		}

		return resultList;
	}

	public SubscriptionRecord getSubscriptionRecordById(String subscriptionId) {
		SubscriptionRecord record = new SubscriptionRecord();
		record.setSubscriptionId(subscriptionId);
		record = session.selectOne("subscriptionManageMapper.queryOneById", record);
		return record;
	}

	public void modify(SubscriptionRecord record) {
		session.update("subscriptionManageMapper.update", record);
	}

	/**
	 * 查询所有订单和用户数据
	 * 
	 * @param result
	 * @return
	 */
	public List<SubscriptionResult> querySbuscriptionAndUser(SubscriptionResult result) {
		List<SubscriptionResult> list = session.selectList("querySbuscriptionAndUser", result);

		System.out.println("[INFO]querySbuscriptionAndUser//" + list);

		return list;
	}

	/**
	 * 查询没有处理的订单
	 * 
	 * @param result
	 * @return
	 */
	public List<SubscriptionResult> querySbuscriptionNoCompl(SubscriptionResult result) {
		List<SubscriptionResult> list = session.selectList("querySbuscriptionNoCompl", result);
		return list;
	}

	/**
	 * 根据id删除订单记录
	 * 
	 * @param result
	 * @return
	 */
	public String deleleSbuscriptionById(SubscriptionRecord result) {
		int re = session.delete("subscriptionManageMapper.deleteSbuscriptionById", result);
		return String.valueOf(re);
	}

	/**
	 * 根据用户名字模糊查询订单记录
	 * 
	 * @param record
	 * @return
	 */
	public List<SubscriptionResult> querySubscriptionByName(SubscriptionResult record) {
		List<SubscriptionResult> list = session.selectList("subscriptionManageMapper.querySbuscriptionByName", record);
		return list;

	}

	/**
	 * 更新订单的状态
	 * 
	 * @param record
	 * @return
	 */
	public String updateSubscriptionStatus(SubscriptionRecord record) {
		int result = session.update("subscriptionManageMapper.update", record);
		return String.valueOf(result);
	}

	public SubscriptionDetail convert(SubscriptionRecord r) {
		SubscriptionDetail deSubscriptionDetail = new SubscriptionDetail();
		deSubscriptionDetail.setSubscriptionId(r.getSubscriptionId());
		deSubscriptionDetail.setUserId(r.getUserId());
		deSubscriptionDetail.setProductId(r.getProductId());
		deSubscriptionDetail.setAddress(r.getAddress());
		deSubscriptionDetail.setMessage(r.getMessage());

		deSubscriptionDetail.setSubscriptionTime(TimeUtils.formate(r.getSubscriptionTime(),
				ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS, ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));

		if (StringUtils.isNotEmpty(r.getUnsubscribeTime())) {
			deSubscriptionDetail.setUnsubscribeTime(TimeUtils.formate(r.getUnsubscribeTime(),
					ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS, ConstantCode.TIME_FORMAT_YYYY_MM_DD_HH_MM_SS));
		}

		deSubscriptionDetail.setTotalCount(r.getTotalCount());
		deSubscriptionDetail.setTotalPrice(r.getTotalPrice());

		deSubscriptionDetail.setStatus(r.getStatus());
		deSubscriptionDetail.setStatusString(getStatusString(r.getStatus()));

		return deSubscriptionDetail;
	}

	public String getStatusString(int status) {
		switch (status) {
		case ConstantCode.SubscriptionStatus.COMLETE:
			return ConstantCode.SubscriptionStatus.COMLETE_STRING;
		case ConstantCode.SubscriptionStatus.COMMENTED:
			return ConstantCode.SubscriptionStatus.COMLETE_STRING;
		case ConstantCode.SubscriptionStatus.DRAFT:
			return ConstantCode.SubscriptionStatus.DRAFT_STRING;
		case ConstantCode.SubscriptionStatus.UNSUBSCRIBED:
			return ConstantCode.SubscriptionStatus.UNSUBSCRIBED_STRING;
		case ConstantCode.SubscriptionStatus.UNSUBSCRIBING:
			return ConstantCode.SubscriptionStatus.UNSUBSCRIBING_STRING;
		case ConstantCode.SubscriptionStatus.WAIT_EVALUATION:
			return ConstantCode.SubscriptionStatus.WAIT_EVALUATION_STRING;
		case ConstantCode.SubscriptionStatus.WAIT_PAY:
			return ConstantCode.SubscriptionStatus.WAIT_PAY_STRING;
		case ConstantCode.SubscriptionStatus.WAIT_RECIVE:
			return ConstantCode.SubscriptionStatus.WAIT_RECIVE_STRING;
		case ConstantCode.SubscriptionStatus.WAIT_SEND:
			return ConstantCode.SubscriptionStatus.WAIT_SEND_STRING;
		default:
			return ConstantCode.SubscriptionStatus.DRAFT_STRING;
		}
	}
}
