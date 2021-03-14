/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

import uuu.vgb.entity.Outlet;

/**
 *
 * @author Admin
 */
public class TestOutlet {
    public static void main(String[] args) {
        Outlet outlet = new Outlet();
        outlet.setId(2);
        outlet.setName("好味貓漢堡 3件組");
        outlet.setUnitPrice(319);
        outlet.setDiscount(15);
//        System.out.println(outlet.getId());
//        System.out.println(outlet.getName());
//        System.out.println(outlet.getListPrice());//定價
//        System.out.println(outlet.getUnitPrice());//售價
//        System.out.println(outlet.getDiscount());
//        System.out.println(outlet.getDiscountString());
        System.out.println("outlet="+outlet);
        
    }
}
