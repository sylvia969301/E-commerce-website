/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

import uuu.vgb.entity.ShippingType;

/**
 *
 * @author Admin
 */
public class TestShippingType {
    public static void main(String[] args) {
        System.out.println(ShippingType.HOME.toString());
        System.out.println(ShippingType.HOME.ordinal());
        System.out.println(ShippingType.HOME.name());
//        ShippingType.HOME.setDescription("送貨到府");
//        ShippingType.HOME.setFee(100);
        System.out.println(ShippingType.HOME.getDesciption());//送貨到府
        System.out.println(ShippingType.HOME.getFee());//100
        System.out.println(ShippingType.HOME);
       
     
        ShippingType shType = ShippingType.STORE;//到時候會從網路上讀下來
        String address="";
        switch(shType){//enum可放進switch case的參數中 
          
            case STORE:
                address = "請選擇便利店門市";
                break;
            case HOME:
                address="";                   
        }
           System.out.println(address);
    }
}
