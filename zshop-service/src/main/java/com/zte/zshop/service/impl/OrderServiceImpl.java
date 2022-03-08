package com.zte.zshop.service.impl;

import com.zte.zshop.cart.ShoppingCart;
import com.zte.zshop.cart.ShoppingCartItem;
import com.zte.zshop.dao.OrderDao;
import com.zte.zshop.entity.Order;
import com.zte.zshop.entity.OrderItem;
import com.zte.zshop.service.OrderService;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderDao orderDao;

    @Override
    public void addAllOrderItem(String orderNo, ShoppingCart sc,Integer id) {

        OrderItem orderItem=new OrderItem();
        Order order=new Order(orderNo,id,sc.getTotalMoney(),new Date());

        try {
            orderDao.insertOrder(order);
            order=orderDao.selectByNo(orderNo);
            for(ShoppingCartItem sci:sc.getItems()){

                orderItem.setNum(sci.getQuantity());
                orderItem.setProduct(sci.getProduct());

                orderItem.setPrice(sci.getItemMoney());
                orderItem.setOrder(order);

                orderDao.insertOrderItem(orderItem);
            }
        } catch (Exception e) {
           // e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Order> findAllOrderByCustomerId(Integer id) {
        return orderDao.selectAllOrderByCustomerId(id);
    }

    @Override
    public void removeOrder(Integer id) {
        orderDao.deleteOrderItem(id);
        orderDao.deleteOrder(id);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Order findAllOrderItemByOrderId(Integer id) {
        return orderDao.selectAllOrderItemByOrderId(id);
    }
}
