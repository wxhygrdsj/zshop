package com.zte.zshop.controller;

import com.github.pagehelper.PageInfo;
import com.zte.zshop.constants.Constant;
import com.zte.zshop.dto.ProductDto;
import com.zte.zshop.entity.Product;
import com.zte.zshop.entity.ProductType;
import com.zte.zshop.service.ProductService;
import com.zte.zshop.service.ProductTypeService;
import com.zte.zshop.utils.ResponseResult;
import com.zte.zshop.vo.ProductVO;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:helloboy
 * Date:2021-06-04 14:54
 * Description:<描述>
 */
@Controller
@RequestMapping("/backend/product")
public class ProductController {
    @Autowired
    private ProductTypeService productTypeService;
    @Autowired
    private ProductService productService;
    @ModelAttribute("productTypes")
    public List<ProductType> loadProductTypes(){
        List<ProductType> productTypes=productTypeService.findByEnable(Constant.PRODUCT_TYPE_ENABLE);
        return productTypes;
    }
    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum= Constant.PAGE_NUM;
        }
        PageInfo<Product> pageInfo= productService.findAll(pageNum, Constant.PAGE_SIZE);
        model.addAttribute("data",pageInfo);
        return "productManager";
    }
    @RequestMapping("/add")
    public String add(ProductVO productVO, Integer pageNum, HttpSession session, Model model){
        ProductDto productDto = new ProductDto();
        try {
            PropertyUtils.copyProperties(productDto,productVO);
            productDto.setFileName(productVO.getFile().getOriginalFilename());
            productDto.setInputStream(productVO.getFile().getInputStream());
            productService.add(productDto);
            model.addAttribute("successMsg","添加成功");

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg","添加失败");
        }
        return "forward:findAll?pageNum="+pageNum;
    }
    @RequestMapping("/checkName")
    @ResponseBody
    public Map<String,Object> checkName(String name){
        Map<String,Object> map = new HashMap<>();
        boolean res=productService.checkName(name);
        if(res){
            map.put("valid",true);
        }
        else{
            map.put("valid",false);
            map.put("message","商品("+name+")已经存在");
        }
        return map;
    }
    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(Integer id){
        Product product=productService.findById(id);
        return ResponseResult.success(product);
    }
    @RequestMapping("/showPic")
    public void showPic(String image, OutputStream out)throws IOException {
        URL url = new URL(image);
        URLConnection urlConnection = url.openConnection();
        InputStream is = urlConnection.getInputStream();
        BufferedOutputStream bos = new BufferedOutputStream(out);
        byte[] data = new byte[4096];
        int size=0;
        size = is.read(data);
        while(size!=-1){
            bos.write(data,0,size);
            size=is.read(data);
        }
        is.close();
        bos.flush();
        bos.close();
    }
    @RequestMapping("/modify")
    public String modify(ProductVO productVO, Integer pageNum, HttpSession session, Model model){
        ProductDto productDto = new ProductDto();
        try {
            PropertyUtils.copyProperties(productDto,productVO);
            if(!"".equals(productVO.getFile().getOriginalFilename())) {
                productDto.setFileName(productVO.getFile().getOriginalFilename());
                productDto.setInputStream(productVO.getFile().getInputStream());
            }
            productService.modifyProduct(productDto);
            model.addAttribute("successMsg","修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg","修改失败");
        }
        return "forward:findAll?pageNum="+pageNum;
    }
    @RequestMapping("/removeById")
    @ResponseBody
    public ResponseResult removeById(Integer id){
        try {
            productService.removeProduct(id);
            return ResponseResult.success("删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("删除失败");
        }
    }
}
