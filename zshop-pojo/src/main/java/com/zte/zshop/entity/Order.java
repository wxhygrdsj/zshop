package com.zte.zshop.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Order implements Serializable {
    private Integer id;
    private String no;
    private Integer customerId;
    private Double price;
    private Date createDate;
    private List<OrderItem> orderItemList;

    public Order() {
    }

    public Order(String no, Integer customerId, Double price, Date createDate) {
        this.no = no;
        this.customerId = customerId;
        this.price = price;
        this.createDate = createDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public List<OrderItem> getOrderItemList() {
        return orderItemList;
    }

    public void setOrderItemList(List<OrderItem> orderItemList) {
        this.orderItemList = orderItemList;
    }
    public int getTotalNum(){
        int num=0;
        for(OrderItem oi:getOrderItemList()){
            num+=oi.getNum();
        }
        return num;
    }
}
