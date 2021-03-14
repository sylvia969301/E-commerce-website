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
public class TestProduct {
    public static void main(String[] args){
        Product p = new Product();
        
        p.setId(1);
        System.out.println(p.getId());
        
        p.setName("好味貓漢堡 經典美式 單一口味 多入");
        System.out.println(p.getName());
        
        p.setUnitPrice(269);
        System.out.println(p.getUnitPrice());
        
        p.setStock(10);
        System.out.println(p.getStock());
        
        p.setDescription("https://i.imgur.com/XtHOODD.jpg&w=1024&h=560");
        System.out.println(p.getDescription());
        
        p.setPhotoURL("https://shoplineimg.com/58a81a0d72fdc0ec2700333f/5ae459ec8d1db9ddc5009523/2000x.webp?source_format=jpg&w=160&h=160");
        System.out.println(p.getPhotoURL());
              
    }
}
