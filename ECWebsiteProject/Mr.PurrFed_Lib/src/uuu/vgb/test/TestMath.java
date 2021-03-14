/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

/**
 *
 * @author Admin
 */
public class TestMath {
    public static void main(String[] args) {
        System.out.println(Math.round(3.8));//四捨五入
        
        long i = Math.round(3.8);
        System.out.println("i = " + i);
        
        int j=Math.round(3.8F);
        System.out.println("j = " + j);
        System.out.println( Math.ceil(4.3));//Math.ceil()無條件進位
        System.out.println(Math.floor(4.8));//Math.floor()無條件捨去
        
        System.out.println(Math.PI);//Math.Pi 圓周率
        System.out.println(Math.E);//Math.E 自然數
    }
}
