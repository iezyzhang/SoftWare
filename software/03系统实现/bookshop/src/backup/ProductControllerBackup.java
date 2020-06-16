package backup;



public class ProductControllerBackup {
	/**
     * 新增产品备份
     * 
     * @return
     */
//    @RequestMapping("backstage_addProduct")
//    public ModelAndView addProduct(MultipartFile uploadFile, HttpServletRequest request, ModelAndView model)
//    {
//        String productName = request.getParameter("productName");
//        String author = request.getParameter("author");
//        String press = request.getParameter("press");
//        String publicationTime = request.getParameter("publicationTime");
//        String categoryId = request.getParameter("categoryId");
//        String description = request.getParameter("description");
//        String stock = request.getParameter("stock");
//        String price = request.getParameter("price");
//        String marketPrice = request.getParameter("marketPrice");
//        String detailContent = request.getParameter("productDetailContent");
//        
//        detailContent = com.bookshop.utils.StringUtils.replaceBlank(detailContent);
//        
//        ProductRecord productRecord = new ProductRecord();
//        productRecord.setProductName(productName);
//        productRecord.setAuthor(author);
//        productRecord.setPress(press);
//        productRecord.setPublicationTime(TimeUtils.formate(publicationTime,
//            ConstantCode.TIME_FORMAT_YYYY_MM_DD,
//            ConstantCode.TIME_FORMAT_YYYYMMDD));
//        
//        productRecord.setCategoryId(categoryId);
//        productRecord.setDescription(description);
//        productRecord.setStock(Integer.valueOf(stock));
//        productRecord.setPrice(Float.valueOf(price));
//        productRecord.setMarketPrice(Float.valueOf(marketPrice));
//        
//        productRecord.setDetailContent(detailContent);
//        
//        // 产品默认是草稿状态
//        productRecord.setStatus(ConstantCode.ProductStatus.DRAFT);
//        
//        // 图片名为空，则没有上传图片
//        String imageName = uploadFile.getOriginalFilename();
//        String fileName = null;
//        if (StringUtils.isNotEmpty(imageName))
//        {
//            // 产品图片
//            fileName = System.currentTimeMillis() + uploadFile.getOriginalFilename();
//            productRecord.setIconUrl(fileName);
//        }
//        
//        
//        
//        // 初始销量0
//        productRecord.setSalesvolume(0);
//        
//        String crurrentTime = TimeUtils.getUTCCurrentTime(ConstantCode.TIME_FORMAT_YYYYMMDDHHMMSS);
//        productRecord.setCreateTime(crurrentTime);
//        
//        productManager.addProduct(productRecord);
//        
//        fileInfoManager.insertFromContent(detailContent,productRecord.getProductId());
//        
//        if (StringUtils.isNotEmpty(imageName))
//        {
//            try
//            {
//                // 处理图片
//                String realPath = request.getSession().getServletContext().getRealPath("/userimages");
//                // 这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉
//                File upPath = new File(realPath, fileName);
//                System.out.println("upPath:"+upPath);
//                FileUtils.copyInputStreamToFile(uploadFile.getInputStream(), upPath);
//     
//                // 把图片属性保存到T_FILE_INFO表
//                FileInfoRecord recordIcon = new FileInfoRecord();
//                recordIcon.setObjectId(productRecord.getProductId());
//                recordIcon.setFileType(ConstantCode.FileType.PRODUCT);
//                recordIcon.setFileUrl("userimages/" + fileName);
//                fileInfoManager.add(recordIcon);
//            }
//            catch (IOException e)
//            {
//                model.addObject("message", "添加产品成功,图片上传失败");
//                model.setViewName("backstage/operateResult");
//                model.addObject("result", 0);
//                return model;
//            }
//        }
//        
//        model.addObject("message", "添加产品成功");
//        model.setViewName("backstage/operateResult");
//        model.addObject("result", 0);
//        
//        return model;
//    }
}
