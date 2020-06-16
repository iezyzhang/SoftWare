package com.bookshop.service.user;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.bookshop.model.address.AddressFilter;
import com.bookshop.model.address.AddressRecord;
import com.bookshop.model.address.DeliveryAddress;
import com.bookshop.utils.UUIDGenerator;

/**
 * 
 * 地址管理
 */
@Service
public class AddressService {

	@Resource
	private SqlSession session;

	/**
	 * 新增地址
	 * 
	 * @param record
	 */
	public void addAddress(AddressRecord record) {
		// 生成用户ID
		String addressId = UUIDGenerator.getUUID();
		record.setAddressId(addressId);
		session.insert("AddressManageMapper.insert", record);
	}

	/**
	 * 更新地址
	 * 
	 * @param record
	 */
	public void updateAddress(AddressRecord record) {
		// 生成用户ID
		session.update("AddressManageMapper.update", record);
	}

	/**
	 * 更新默认收货地址为空
	 * 
	 * @param record
	 */
	public void updateAllDefaultAddress(AddressRecord record) {
		// 生成用户ID
		session.update("AddressManageMapper.updateAllDefaultAddress", record);
	}

	/**
	 * 删除地址
	 * 
	 * @param record
	 */
	public void deleteAddressByAddressId(String addressId) {
		AddressRecord record = new AddressRecord();
		record.setAddressId(addressId);
		session.delete("AddressManageMapper.delete", record);
	}

	/**
	 * 根据条件查询地址
	 * 
	 * @param filter
	 * @return
	 */
	public List<DeliveryAddress> queryAddressList(AddressFilter filter) {
		List<DeliveryAddress> resultList = new ArrayList<DeliveryAddress>();

		List<AddressRecord> recordList = session.selectList("AddressManageMapper.queryAddressByCondition", filter);

		if (org.springframework.util.CollectionUtils.isEmpty(recordList)) {
			return resultList;
		}

		DeliveryAddress address = null;
		for (AddressRecord r : recordList) {
			address = new DeliveryAddress();
			address.setUserId(r.getUserId());
			address.setAddressId(r.getAddressId());
			address.setDefaultAddress(r.getDefaultAddress());
			address.setAddress(r.getAddress());

			resultList.add(address);
		}

		return resultList;
	}

	/**
	 * 
	 * @param addressId
	 * @return
	 */
	public AddressRecord getAddressRecordByAddressId(String addressId) {
		AddressRecord record = new AddressRecord();
		record.setAddressId(addressId);

		record = session.selectOne("AddressManageMapper.queryByAddressId", record);

		return record;
	}
}
