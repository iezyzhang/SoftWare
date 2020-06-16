package com.bookshop.controller.usermanager;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop.common.CommonService;
import com.bookshop.model.address.AddressFilter;
import com.bookshop.model.address.AddressRecord;
import com.bookshop.model.address.DeliveryAddress;
import com.bookshop.model.user.UserRecord;
import com.bookshop.service.user.AddressService;
import com.bookshop.service.user.UserService;

/**
 * 地址控制器
 * 
 */
@Controller
public class AddressController {
	@Autowired
	private AddressService addressManager;

	@Autowired
	private UserService userManager;

	/**
	 * 转到收货地址管理
	 * 
	 * @return
	 */
	@RequestMapping("toAddressManage")
	public ModelAndView toAddressManage(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		CommonService.setUserSession(request, model, username);

		// 查询地址信息
		AddressFilter filter = new AddressFilter();
		filter.setUsername(username);
		List<DeliveryAddress> addressList = addressManager.queryAddressList(filter);

		model.addObject("addressList", addressList);

		model.setViewName("addressManage");
		return model;
	}

	/**
	 * 转到新增收货地址
	 * 
	 * @return
	 */
	@RequestMapping("toAddAddress")
	public ModelAndView toAddAddress(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");

		CommonService.setUserSession(request, model, username);

		model.setViewName("addAddress");
		return model;
	}

	/**
	 * 新增收货地址
	 * 
	 * @return
	 */
	@RequestMapping("addAddress")
	public ModelAndView addAddress(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		String address = request.getParameter("address");
		String defalutAddress = request.getParameter("defaultAddress");
		CommonService.setUserSession(request, model, username);

		if (StringUtils.isEmpty(address)) {
			model.addObject("message", "地址不能为空，请从新操作！");
			model.setViewName("modifyUserResult");
			return model;
		}

		// 查询userId
		UserRecord userRecord = new UserRecord();
		userRecord.setUsername(username);
		userRecord = userManager.getUserRecordByName(userRecord);

		if (null == userRecord) {
			model.addObject("message", "新增失败，用户不存在！");
			model.setViewName("modifyUserResult");
			return model;
		}

		AddressRecord addressRecord = new AddressRecord();
		addressRecord.setAddress(address);
		addressRecord.setDefaultAddress(Integer.parseInt(defalutAddress));
		addressRecord.setUserId(userRecord.getUserId());
		addressManager.addAddress(addressRecord);

		model.addObject("message", "新增地址成功！");
		model.setViewName("modifyUserResult");
		return model;
	}

	/**
	 * 转到修改收货地址
	 * 
	 * @return
	 */
	@RequestMapping("toModifyAddress")
	public ModelAndView toModifyAddress(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		String addressId = request.getParameter("addressId");

		CommonService.setUserSession(request, model, username);

		// 校验地址是否存在
		AddressRecord addressRecord = addressManager.getAddressRecordByAddressId(addressId);

		if (null == addressRecord) {
			model.addObject("message", "修改失败，地址不存在！");
			model.setViewName("modifyUserResult");
			return model;
		}

		model.addObject("userId", addressRecord.getUserId());
		model.addObject("addressId", addressRecord.getAddressId());
		model.addObject("address", addressRecord.getAddress());
		model.addObject("defaultAddress", addressRecord.getDefaultAddress());

		model.setViewName("modifyAddress");
		return model;
	}

	/**
	 * 修改收货地址
	 * 
	 * @return
	 */
	@RequestMapping("modifyAddress")
	public ModelAndView modifyAddress(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		String userId = request.getParameter("userId");
		String addressId = request.getParameter("addressId");
		String address = request.getParameter("address");
		String defaultAddress = request.getParameter("defaultAddress");

		CommonService.setUserSession(request, model, username);

		if (StringUtils.isEmpty(address)) {
			model.addObject("message", "地址不能为空，请从新操作！");
			model.setViewName("modifyUserResult");
			return model;
		}

		// 查询userId
		UserRecord userRecord = new UserRecord();
		userRecord.setUsername(username);
		userRecord = userManager.getUserRecordByName(userRecord);

		if (null == userRecord) {
			model.addObject("message", "修改失败，用户不存在！");
			model.setViewName("modifyUserResult");
			return model;
		}

		// 校验地址是否存在
		AddressRecord addressRecord = addressManager.getAddressRecordByAddressId(addressId);

		if (null == addressRecord) {
			model.addObject("message", "修改失败，地址不存在！");
			model.setViewName("modifyUserResult");
			return model;
		}

		addressRecord.setAddress(address);
		addressRecord.setUserId(userId);
		addressRecord.setAddressId(addressId);
		int type = Integer.parseInt(defaultAddress);
		addressRecord.setDefaultAddress(type);

		if (type == 1) {
			// 去除当前用户全部收货地址默认设置
			addressManager.updateAllDefaultAddress(addressRecord);
		}
		addressManager.updateAddress(addressRecord);

		model.addObject("message", "修改地址成功！");
		model.setViewName("modifyUserResult");
		return model;
	}

	/**
	 * 删除收货地址
	 * 
	 * @return
	 */
	@RequestMapping("deleteAddress")
	public ModelAndView deleteAddress(HttpServletRequest request, ModelAndView model) {
		// 获取用户名
		String username = request.getParameter("username");
		String addressId = request.getParameter("addressId");

		CommonService.setUserSession(request, model, username);

		addressManager.deleteAddressByAddressId(addressId);

		model.addObject("message", "删除地址成功！");
		model.setViewName("modifyUserResult");
		return model;
	}
}
