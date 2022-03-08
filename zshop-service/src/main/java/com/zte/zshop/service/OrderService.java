package com.zte.zshop.service;

import com.zte.zshop.cart.ShoppingCart;
import com.zte.zshop.entity.Order;

import java.util.List;

public interface OrderService {

    public void addAllOrderItem(String orderNo, ShoppingCart sc, Integer id);

    public List<Order> findAllOrderByCustomerId(Integer id);

    public void removeOrder(Integer id);

    public Order findAllOrderItemByOrderId(Integer id);
}
