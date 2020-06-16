package com.bookshop.controller.backstage;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop.common.Category;
import com.bookshop.common.CommonService;
import com.bookshop.common.ConstantCode;
import com.bookshop.model.manager.ManagerRecord;
import com.bookshop.model.product.CategroyRecord;
import com.bookshop.model.product.ProductDetail;
import com.bookshop.model.product.ProductFilter;
import com.bookshop.model.product.ProductRecord;
import com.bookshop.model.user.FileInfoRecord;
import com.bookshop.service.portal.PortalService;
import com.bookshop.service.product.ProductService;
import com.bookshop.service.user.FileInfoService;
import com.bookshop.service.user.ManagerService;
import com.bookshop.utils.TimeUtils;

@Controller
public class BackstageProductController {
	@Autowired
	private ProductService productManager;

	@Autowired
	private FileInfoService fileInfoManager;

	@Autowired
	private PortalService portalService;

	@Autowired
	private ManagerService managerService;

	/**
	 * 转到后台产品管理
	 * 
	 * @return
	 */
	@RequestMapping("backstage_productManage")
	public ModelAndView toProductManage(HttpServletRequest request, ModelAndView model) {
		// 权限验证---------------------------------------------
		String username = (String) request.getSession().getAttribute("adminName");
		if (username == null) {
			model.addObject("message", "您未登陆或者登陆超时");
			model.addObject("result", -1);
			model.setViewName("/backstage/operateResult");
			return model;
		}
		ManagerRecord record = new ManagerRecord();
		record.setManagerName(username);
		record = managerService.getMangerRecordByName(record);
		System.out.println("[INFO]backstage_userManage/record//" + record);
		String role = record.getRole();
		// 最高管理员或者用户管理员
		if (!role.equals("0") && !role.equals("2")) {
			model.addObject("message", "权限不足");
			model.setViewName("backstage/operateResult");
			model.addObject("result", -1);
			return model;
		}
		// 查询产品
		String productName = request.getParameter("productName");
		ProductFilter productFilter = new ProductFilter();
		productFilter.setProductName(productName);

		List<ProductDetail> productList = productManager.getProductList(productFilter);

		model.setViewName("backstage/Product/productIndex");
		model.addObject("productList", productList);
		return model;
	}

	/**
	 * 转到后台新增
	 * 
	 * @return
	 */
	@RequestMapping("backstage_toAddProduct")
	public ModelAndView toAddProduct(HttpServletRequest request, ModelAndView model) {
		// 获取分类map

		model.addObject("categoryMap", Category.getMap());
		model.setViewName("backstage/Product/productAdd");
		return model;
	}

	/**
	 * 新增产品
	 * 
	 * @return
	 */
	@RequestMapping("backstage_addProduct")
	public ModelAndView addProduct(MultipartFile uploadFile, HttpServletRequest request, ModelAndView model) {
		String productName = request.getParameter("productName");
		String author = request.getParameter("author");
		String press = request.getParameter("press");
		String publicationTime = request.getParameter("publicationTime");
		String categoryId = request.getParameter("categoryId");
		String description = request.getParameter("description");
		String stock = request.getParameter("stock");
		String price = request.getParameter("price");
		String marketPrice = request.getParameter("marketPrice");
		String detailContent = request.getParameter("productDetailContent");

		detailContent = com.bookshop.utils.StringUtils.replaceBlank(detailContent);

		ProductRecord productRecord = new ProductRecord();
		productRecord.setProductName(productName);
		productRecord.setAuthor(author);
		productRecord.setPress(press);
		productRecord.setPublicationTime(TimeUtils.formate(publicationTime, ConstantCode.TIME_FORMAT_YYYY_MM_DD,
				ConstantCode.TIME_FORMAT_YYYYMMDD));

		productRecord.setCategoryId(categoryId);
		productRecord.setDescription(description);
		productRecord.setStock(Integer.valueOf(stock));
		productRecord.setPrice(Float.valueOf(price));
		productRecord.setMarketPrice(Integer.valueOf(marketPrice));

		productRecord.setDetailContent(detailContent);

		// 产品默认是草稿状态
		productRecord.setStatus(ConstantCode.ProductStatus.DRAFT);

		// 图片名为空，则没有上传图片
		String imageName = uploadFile.getOriginalFilename();
		String fileName = null;
		if (StringUtils.isNotEmpty(imageName)) {
			// 产品图片
			fileName = System.currentTimeMillis() + uploadFile.getOriginalFilename();
			productRecord.setIconUrl(fileName);
		}

		// 初始销量0
		productRecord.setSalesvolume(0);

		String crurrentTime = TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS);
		productRecord.setCreateTime(crurrentTime);

		productManager.addProduct(productRecord);

		fileInfoManager.insertFromContent(detailContent, productRecord.getProductId());

		if (StringUtils.isNotEmpty(imageName)) {
			try {
				// 处理图片
				String realPath = request.getSession().getServletContext().getRealPath("/userimages");
				// 这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉
				FileUtils.copyInputStreamToFile(uploadFile.getInputStream(), new File(realPath, fileName));
				FileUtils.copyInputStreamToFile(uploadFile.getInputStream(),
						new File("/Users/hebin/Desktop/CHECK", fileName));

				// 把图片保存到T_FILE_INFO表
				FileInfoRecord recordIcon = new FileInfoRecord();
				recordIcon.setObjectId(productRecord.getProductId());
				recordIcon.setFileType(ConstantCode.FileType.PRODUCT);
				recordIcon.setFileUrl("userimages/" + fileName);
				fileInfoManager.add(recordIcon);
			} catch (IOException e) {
				model.addObject("message", "添加产品成功,图片上传失败");
				model.setViewName("backstage/operateResult");
				model.addObject("result", 0);
				return model;
			}
		}

		model.addObject("message", "添加产品成功");
		model.setViewName("backstage/operateResult");
		model.addObject("result", 0);

		return model;
	}

	/**
	 * 转到后台产品修改
	 * 
	 * @return
	 */
	@RequestMapping("backstage_toModifyProduct")
	public ModelAndView toModifyProduct(HttpServletRequest request, ModelAndView model) {
		// 查询产品
		String productId = request.getParameter("productId");

		ProductDetail detail = productManager.getProductDetailById(productId);

		if (detail == null) {
			model.setViewName("backstage/operateResult");
			model.addObject("message", "产品不存在");
			model.addObject("result", 1);
			return model;
		}
		CategroyRecord record = new CategroyRecord();
		List<CategroyRecord> categroyList = portalService.getCategroyList(record);

		model.setViewName("backstage/Product/productEdit");
		model.addObject("productDetail", detail);
		model.addObject("categoryMap", categroyList);
		return model;
	}

	/**
	 * 产品修改
	 * 
	 * @return
	 */
	@RequestMapping("backstage_modifyProduct")
	public ModelAndView modifyProduct(MultipartFile uploadFile, HttpServletRequest request, ModelAndView model) {
		// 查询产品
		String productId = request.getParameter("productId");
		String productName = request.getParameter("productName");
		String author = request.getParameter("author");
		String press = request.getParameter("press");
		String publicationTime = request.getParameter("publicationTime");
		String categoryId = request.getParameter("categoryId");
		String description = request.getParameter("description");
		String stock = request.getParameter("stock");
		String price = request.getParameter("price");
		String marketPrice = request.getParameter("marketPrice");
		String detailContent = request.getParameter("productDetailContent");

		detailContent = com.bookshop.utils.StringUtils.replaceBlank(detailContent);

		ProductFilter productFilter = new ProductFilter();
		productFilter.setProductId(productId);
		ProductRecord productRecord = productManager.getProductRecordById(productFilter);

		if (productRecord == null) {
			model.setViewName("backstage/operateResult");
			model.addObject("message", "产品不存在");
			model.addObject("result", 1);
			return model;
		}

		productRecord.setProductName(productName);
		productRecord.setAuthor(author);
		productRecord.setPress(press);
		productRecord.setPublicationTime(TimeUtils.formate(publicationTime, ConstantCode.TIME_FORMAT_YYYY_MM_DD,
				ConstantCode.TIME_FORMAT_YYYYMMDD));

		productRecord.setCategoryId(categoryId);
		productRecord.setDescription(description);
		productRecord.setStock(Integer.valueOf(stock));
		productRecord.setPrice(Float.valueOf(price));
		productRecord.setMarketPrice(Float.valueOf(marketPrice));
		productRecord.setDetailContent(detailContent);

		// 保存老图片
		String oldIconName = productRecord.getIconUrl();

		// 图片名为空，则没有上传图片
		String imageName = uploadFile.getOriginalFilename();
		String fileName = null;
		if (StringUtils.isNotEmpty(imageName)) {
			// 产品图片
			fileName = System.currentTimeMillis() + uploadFile.getOriginalFilename();
			productRecord.setIconUrl(fileName);
		}

		String crurrentTime = TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS);
		productRecord.setCreateTime(crurrentTime);

		productManager.updateProduct(productRecord);

		// 处理content里面的图片信息
		// 由于是修改，先删除之前的，然后做新增
		fileInfoManager.deleteByObjectId(productRecord.getProductId());
		fileInfoManager.insertFromContent(detailContent, productRecord.getProductId());

		if (StringUtils.isNotEmpty(imageName)) {
			try {
				// 处理图片
				String realPath = request.getSession().getServletContext().getRealPath("/userimages");
				// 这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉
				FileUtils.copyInputStreamToFile(uploadFile.getInputStream(), new File(realPath, fileName));

				// 删除之前的图片
				CommonService.deleteFile(realPath, oldIconName);

				// 把新图片保存到T_FILE_INFO表
				FileInfoRecord recordIcon = new FileInfoRecord();
				recordIcon.setObjectId(productRecord.getProductId());
				recordIcon.setFileType(ConstantCode.FileType.PRODUCT);
				recordIcon.setFileUrl("userimages/" + fileName);
				fileInfoManager.add(recordIcon);
			} catch (IOException e) {
				model.addObject("message", "修改产品成功,图片上传失败");
				model.setViewName("backstage/operateResult");
				model.addObject("result", 0);
				return model;
			}
		}

		model.setViewName("backstage/operateResult");
		model.addObject("message", "修改成功");
		model.addObject("result", 0);
		return model;
	}

	/**
	 * 
	 * [简要描述]:改变状态,上线或者下线,或者删除
	 * 
	 * @param
	 * @return ModelAndView
	 * @Exception
	 */
	@RequestMapping("backstage_changeProductStatus")
	public ModelAndView changeProductStatus(HttpServletRequest request, ModelAndView model) {
		// 产品ID
		String productId = request.getParameter("productId");

		// 操作类型
		String operateTypeString = request.getParameter("operateType");

		if (StringUtils.isEmpty(operateTypeString)) {
			model.setViewName("backstage/operateResult");
			model.addObject("message", "操作类型不合法，请从新操作");
			model.addObject("result", 1);
			return model;
		}

		int operateType = Integer.parseInt(operateTypeString);

		ProductRecord productRecord = productManager.getProductRecordById(productId);

		if (productRecord == null) {
			model.setViewName("backstage/operateResult");
			model.addObject("message", "产品不存在");
			model.addObject("result", 1);
			return model;
		}

		// 如果是上线或者下线，直接更新状态
		if (operateType == ConstantCode.ProductOperateType.ONLIE
				|| operateType == ConstantCode.ProductOperateType.OFFLINE) {
			// 做更新
			productRecord.setStatus(productManager.convertOperateType(operateType));
			productManager.updateProduct(productRecord);
		} else if (operateType == ConstantCode.ProductOperateType.DELETE) {
			// 做删除
			productManager.deleteProductById(productId);

			// 获取该产品所有图片信息
			List<FileInfoRecord> imagesList = fileInfoManager.getFileInfoListByObjectId(productId);

			// 获取绝对路径
			String homePath = request.getSession().getServletContext().getRealPath("");

			// 删除实体图片
			for (FileInfoRecord fileInfoRecord : imagesList) {
				CommonService.deleteFile(homePath, fileInfoRecord.getFileUrl());
			}

			// 删除数据图片信息
			fileInfoManager.deleteByObjectId(productId);
		}

		model.setViewName("backstage/operateResult");
		model.addObject("message", "操作成功");
		model.addObject("result", 0);
		return model;
	}

}
