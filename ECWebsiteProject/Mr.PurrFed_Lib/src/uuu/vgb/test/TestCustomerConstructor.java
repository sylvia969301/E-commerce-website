/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

import java.util.logging.Level;
import java.util.logging.Logger;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;

/**
 *
 * @author Admin
 */
public class TestCustomerConstructor {
    public static void main(String[]args){
        try {
            Customer c = new Customer(2,"阿金","123456",'M',"abc@com","1997.02.12");
            
            int age=c.getAge();
            System.out.println(c.getId());
            System.out.println(c.getName());
            System.out.println(c.getPassword());
            System.out.println(c.getGender());
            System.out.println(c.getEmail());
            System.out.println(c.getBirthday());
        } catch (VGBException ex) {
            Logger.getLogger(TestCustomerConstructor.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
