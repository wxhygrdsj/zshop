package com.zte.zshop.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class OrderNoUtils {
    public static  String randomOrderNo(){
        String randomInt="0";
        for(int i=0;i<6;i++){
            int x=new Random().nextInt(10);
            randomInt=randomInt+x;
        }
        return new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+randomInt;
    }

    public static void main(String[] args) {
        System.out.println(randomOrderNo());
    }
}
