package com.zte.zshop.vo;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class CustomerImageVO {
    private Integer id;
    private CommonsMultipartFile file;

    public CustomerImageVO() {
    }

    public CustomerImageVO(Integer id, CommonsMultipartFile file) {
        this.id = id;
        this.file = file;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public CommonsMultipartFile getFile() {
        return file;
    }

    public void setFile(CommonsMultipartFile file) {
        this.file = file;
    }
}
