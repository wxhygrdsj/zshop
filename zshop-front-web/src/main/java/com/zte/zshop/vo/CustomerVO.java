package com.zte.zshop.vo;


import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class CustomerVO {
    private Integer id;

    private String name;

    private String loginName;

    private String phone;

    private String address;




    public CustomerVO() {
    }

    public CustomerVO(Integer id, String name, String loginName, String phone, String address) {
        this.id = id;
        this.name = name;
        this.loginName = loginName;
        this.phone = phone;
        this.address = address;
    }



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }


}
