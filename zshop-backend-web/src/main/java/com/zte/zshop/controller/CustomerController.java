package com.zte.zshop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zte.zshop.constants.Constant;
import com.zte.zshop.entity.Customer;
import com.zte.zshop.params.CustomerParam;
import com.zte.zshop.service.CustomerService;
import com.zte.zshop.utils.ResponseResult;

import com.zte.zshop.vo.CustomerVO2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:helloboy
 * Date:2021-07-01 15:43
 * Description:<描述>
 */
@Controller
@RequestMapping("/backend/customer")
public class CustomerController {
    @Autowired
    private CustomerService customerService;
    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum= Constant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,2);
        PageInfo<Customer> pageInfo=customerService.findAll();
        model.addAttribute("data",pageInfo);
        return "customerManager";
    }





    @RequestMapping("/checkName")
    @ResponseBody
    public Map<String,Object> checkName(String loginName){
        Map<String,Object> map = new HashMap<>();
        boolean res=customerService.checkName(loginName);
        if(res){
            map.put("valid",true);
        }
        else{
            map.put("valid",false);
            map.put("message","账号【"+loginName+"】已经存在");
        }
        return map;
    }
    //组合查询
    @RequestMapping("/findByParams")
    public String findByParams(CustomerParam customerParam, Integer pageNum, Model model) {
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum, 2);
        List<Customer> customers = customerService.findByParams(customerParam);
        PageInfo<Customer> pageInfo = new PageInfo<>(customers);
        model.addAttribute("customerParam", customerParam);
        model.addAttribute("data", pageInfo);
        System.out.println(customerParam.getLoginName());
        return "customerManager";
    }
    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(Integer id){
        Customer customer=customerService.findById(id);
        return ResponseResult.success(customer);
    }
    @RequestMapping("/modify")
    public String modify(CustomerVO2 customerVO, Integer pageNum, Model model){
        try{
            customerService.modify(customerVO);
            model.addAttribute("successMsg","修改成功");
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("errorMsg","修改失败");
        }
        return "forward:findAll?pageNum="+pageNum;
    }
    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(Integer id){
        try {
            customerService.modifyStatus(id);
            return ResponseResult.success("更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("更新失败");
        }
    }
}
