package com.zte.zshop.dao;

import com.zte.zshop.entity.Order;
import com.zte.zshop.entity.OrderItem;

import java.util.List;

public interface OrderDao {
    public void insertOrder(Order order);

    public void insertOrderItem(OrderItem orderItem);

    public Order selectByNo(String orderNo);


    public List<Order> selectAllOrderByCustomerId(Integer id);

    public void deleteOrder(Integer id);

    public void deleteOrderItem(Integer id);

    public Order selectAllOrderItemByOrderId(Integer id);
}
