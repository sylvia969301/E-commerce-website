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
public class TestCharGender {
    public static void main(String[] args) {
        try {
            Customer c1 = new Customer();
            c1.setGender(Customer.MALE);
            System.out.println(c1.getGender()=='M'?"男":"女");
        } catch (VGBException ex) {
            Logger.getLogger(TestCharGender.class.getName()).log(Level.SEVERE, null, ex);
        }
       
    }
}
