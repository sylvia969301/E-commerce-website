
package uuu.vgb.service;

import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;


public class CustomerService {
    private CustomersDAO dao= new CustomersDAO();
    
    public Customer login(String email,String password)throws VGBException{
        Customer c = dao.select(email);
        if(c!=null && password != null && 
                password.equals(c.getPassword())){
            return c;
        }else{ //一般而言登入檢查不會寫得太清楚(只寫帳號錯誤or密碼錯誤) 防止駭客猜帳號密碼
            throw new VGBException("登入失敗,帳號或密碼不正確");
        }
        
    }
    
    public void register(Customer c) throws VGBException{
        dao.insert(c);
    }
    public void update(Customer c)throws VGBException{
        dao.update(c);
    }
}
