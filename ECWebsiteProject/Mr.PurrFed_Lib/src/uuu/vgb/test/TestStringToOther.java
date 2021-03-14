/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

import java.time.LocalDate;

/**
 *
 * @author Admin
 */
public class TestStringToOther {
    public static void main(String[] args) {
        //Other types to String objects
        String str1= String.valueOf(1);
        System.out.println(str1.getClass().getName());
        
        String str2= String.valueOf(true);
        System.out.println(str2.getClass().getName());
        
        String str3 = String.valueOf(LocalDate.now());
        System.out.println(str3.getClass().getName()+":"+str3);
        
        //String objects to Primitive types
        byte age= Byte.parseByte("127");
        System.out.println("age = " + age);//soutv+[Tab]
        
        short quantity= Short.parseShort("32767");
        System.out.println("quantity = " + quantity);
        
        int salary =Integer.parseInt("124567");
        System.out.println("salary = " + salary);
        
        double price= Double.parseDouble("12345.678");
        System.out.println("price = " + price);
        
        //String object toLocalDate object
        LocalDate birthday= LocalDate.parse("1990-02-12");
        System.out.println("birthday = " + birthday);
        
        //String object to Date object :?
        
        //String object to Enum(列舉型態)
        
    }
}
