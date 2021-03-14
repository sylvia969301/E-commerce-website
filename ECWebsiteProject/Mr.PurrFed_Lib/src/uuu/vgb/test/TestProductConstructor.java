/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

import uuu.vgb.entity.Product;

/**
 *
 * @author Admin
 */
public class TestProductConstructor {
    public static void main(String[] args) {
            Product p = new Product(1,"好味貓漢堡 經典美式 單一口味 多入",269,10);
            System.out.println(p.getId());
            System.out.println(p.getName());
            System.out.println(p.getUnitPrice());
            System.out.println(p.getStock());
    }
}
