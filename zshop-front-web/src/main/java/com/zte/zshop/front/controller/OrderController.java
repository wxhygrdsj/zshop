package com.zte.zshop.front.controller;


import com.zte.zshop.cart.ShoppingCart;
import com.zte.zshop.cart.ShoppingCartUtils;
import com.zte.zshop.entity.Order;
import com.zte.zshop.service.OrderService;
import com.zte.zshop.utils.OrderNoUtils;
import com.zte.zshop.utils.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("front/order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @RequestMapping("/generateOrder")
    @ResponseBody
    public ResponseResult generateOrder(HttpSession session, Integer id){
        ShoppingCart sc=ShoppingCartUtils.getShoppingCart(session);
        ShoppingCart sc2 = ShoppingCartUtils.getShoppingCart2(session);
        Integer []keySet = sc2.getProducts().keySet().toArray(new Integer[0]);  //获取key集合对象

        for(Integer id2:keySet){
            sc.removeItem(id2);
        }
        System.out.println("session:shoppingCart2的值"+sc2);
        if(sc2.isEmpty()){
            return ResponseResult.fail("生成订单失败,请先加入购物车");
        }
        String orderNo=OrderNoUtils.randomOrderNo();
        try {
            orderService.addAllOrderItem(orderNo,sc2,id);
            //session.removeAttribute("shoppingCart2");
            return ResponseResult.success(orderNo);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("生成订单失败");
        }
    }
    @RequestMapping("/removeOrder")
    @ResponseBody
    public ResponseResult removeOrder(Integer id){
        try {
            orderService.removeOrder(id);
            return ResponseResult.success("删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("删除失败");
        }
    }
    @RequestMapping("/toOrderDetail")
    public String toOrderDetail(Integer id, Model model){
        Order order=new Order();
        order=orderService.findAllOrderItemByOrderId(id);
        model.addAttribute("order",order);
        return "orderDetail";
    }
}
