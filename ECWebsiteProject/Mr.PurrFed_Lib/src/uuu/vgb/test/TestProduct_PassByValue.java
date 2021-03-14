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
public class TestProduct_PassByValue {
    public static void main(String[] args) {
        int i=1;
        int j = i;
        i +=1;
        System.out.println(i);//2
        System.out.println(j);//1
        
        Product p1 = new Product(1,"好味貓漢堡",269,10);
//        Product p2 = p1;
        
        System.out.println(p1.getUnitPrice());//269
       
        ProductDemoService service = new ProductDemoService();
        service.addPrice(p1.getUnitPrice());
        System.out.println(p1.getUnitPrice());//? 269
        
        service.addPrice(p1);
        System.out.println(p1.getUnitPrice());//? 369
    }
}
class ProductDemoService{
//    public void addPrice(double price){
//        price +=100;
//        
//    }
//    public void addPrice(Product p ){
//        p.setUnitPrice(p.getUnitPrice()+100);
//    }
     public double addPrice(double price){
        double rtn =price +100;
         System.out.println("price:"+rtn);
         return rtn;
        
    }
    public double addPrice(Product p ){
        double rtn= p.getUnitPrice()+100;
        return rtn;
    }
    
}

