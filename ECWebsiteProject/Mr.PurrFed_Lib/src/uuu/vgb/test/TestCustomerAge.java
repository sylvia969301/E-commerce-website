/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.test;

import java.time.LocalDate;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;

/**
 *
 * @author Admin
 */
public class TestCustomerAge {
    public static void main(String[] args) {
        try{
        Customer c = new Customer();
        c.setId(2);
        c.setName("Jimmy");
        System.out.println(c.getName());
        
       // c.birthday=LocalDate.of(1997, 05, 26);//不好做維護及檢查
        c.setBirthday(1997,05,26);//將生日作封裝(封裝成setBirthday方法)，以便檢查及維護
        c.setBirthday("1997-05-26");
        int age=c.getAge();
        System.out.println(age);
        }catch(VGBException ex){
            System.out.println(ex.getMessage());
        }catch(Exception ex){
            System.out.println("發生非預期錯誤"+ex);
        }
        
    }
}
