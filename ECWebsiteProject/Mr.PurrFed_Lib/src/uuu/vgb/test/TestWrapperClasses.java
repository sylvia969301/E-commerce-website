/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class TestWrapperClasses {
    public static void main(String[] args) {
        ArrayList<Integer> list;
        list = new ArrayList<> ();
        list.add(new Integer(3));//boxing基本型別包裝成包裝類別wrapper class
        list.add(0,2);//auto-boxing
        list.add(0,new Integer(1));//boxing
        System.out.println(list);
        Integer i = list.get(0);
        Integer j = list.get(0);
        Integer k = list.get(0);
        Integer m = 100;//auto-boxing
        int sum = i.intValue()+j.intValue()+k.intValue();//unboxing將包裝類別中的基本型別取出
        int sum2= i+j-k*m;//auto-unboxing
        
        System.out.println(new Boolean(true).booleanValue());
        System.out.println(new Byte((byte)127).byteValue());
        System.out.println(new Short((short)32767).shortValue());
        
        
    }
}
