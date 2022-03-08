package com.zte.zshop.dto;

import java.io.InputStream;

public class CustomerImageDto {
    private Integer id;
    //文件输入流
    private InputStream inputStream;

    //文件名称
    private String fileName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
