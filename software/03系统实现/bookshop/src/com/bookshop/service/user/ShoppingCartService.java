package com.bookshop.service.user;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.bookshop.common.ConstantCode;
import com.bookshop.model.user.ShoppingCart;
import com.bookshop.system.UserContext;

/**
 * 
 * @author wangbo
 *
 */
public abstract class ShoppingCartService {
	/**
	 * 获取用户的购物车
	 * 
	 * @param username
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<ShoppingCart> getShoppingCart(String username) {
		Map<String, Object> mapObj = UserContext.get(username);

		if (null == mapObj) {
			return null;
		}

		Object obj = mapObj.get(ConstantCode.CONTEXT_SHOPPING_CART);
		if (null != obj) {
			return (List<ShoppingCart>) obj;
		}

		return null;
	}

	/**
	 * 网购物车里添加一
	 * 
	 * @param username
	 * @param sc
	 */
	@SuppressWarnings("unchecked")
	public static synchronized void putShoppingCart(String username, ShoppingCart sc) {
		Map<String, Object> mapObj = UserContext.get(username);

		if (null == mapObj) {
			return;
		}

		Object obj = mapObj.get(ConstantCode.CONTEXT_SHOPPING_CART);

		List<ShoppingCart> scList = null;
		sc = null == sc ? new ShoppingCart() : sc;

		if (null == obj) {
			scList = new ArrayList<ShoppingCart>();
		} else {
			scList = (List<ShoppingCart>) obj;
		}

		scList.add(sc);
		mapObj.put(ConstantCode.CONTEXT_SHOPPING_CART, scList);

	}

	/**
	 * 移除一
	 * 
	 * @param username
	 * @param sc
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	public static synchronized void removeShoppingCart(String username, String key) {
		key = null == key ? StringUtils.EMPTY : key;

		Map<String, Object> mapObj = UserContext.get(username);

		if (null == mapObj) {
			return;
		}

		Object obj = mapObj.get(ConstantCode.CONTEXT_SHOPPING_CART);

		if (null == obj) {
			return;
		}

		List<ShoppingCart> list = (List<ShoppingCart>) obj;

		if (null == list) {
			return;
		}

		Iterator<ShoppingCart> iterator = list.iterator();

		ShoppingCart shoppingCart = null;
		while (iterator.hasNext()) {
			shoppingCart = iterator.next();
			if (key.equals(shoppingCart.getKey())) {
				iterator.remove();
				break;
			}
		}
	}
}
