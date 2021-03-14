/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VIP;

/**
 *
 * @author Admin
 */
public class TestInstanceOf {
    public static void main(String[] args) {
        Object o = null;
        Customer c = null;
        VIP vip =null;
        System.out.println( o instanceof Object);//False
        System.out.println(c instanceof Customer);   //False
        System.out.println(vip instanceof VIP);//False
//        System.out.println(c instanceof String); 無法編譯 String跟Customer不同類別且沒有繼承關係

        Object o1 = new Object();
        Customer c1 = new Customer();
        VIP vip1 =new VIP();
    
        
         System.out.println( o1 instanceof Object);//True
        System.out.println(c1 instanceof Customer);//ture
        System.out.println(vip1 instanceof VIP);//ture
        
        System.out.println(o1.getClass().getName());
        
        if(o1 != null){
            System.out.println(o1.getClass().getName());
        }
        System.out.println(c1!=null?c1.getClass().getName():"c1 is null");
    }
}
