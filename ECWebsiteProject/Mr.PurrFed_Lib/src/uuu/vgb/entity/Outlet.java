/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.entity;

/**
 *
 * @author Admin
 */
public class Outlet extends Product {
    private int discount;
    //查詢售價, Override原先父類別(Product)中的方法(getUnitPrice()
    @Override
    public double getUnitPrice() {
       return Math.floor(super.getUnitPrice()*(100-discount)/100);
    }

    //查詢定價, 為Outlet定義的新方法
    public double getListPrice(){
        return super.getUnitPrice();
    }
    
    public int getDiscount(){
        return this.discount;
    }
    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public String getDiscountString(){
        int discount =100-this.discount;
        if(discount % 10 !=0){
            return discount+"折";
        }else{
            return discount/10+"折";
        }
    }

    @Override
    public String toString() {
        return super.toString() +".\n折扣="+discount
                +",售價"+this.getUnitPrice(); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
