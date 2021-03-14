package uuu.vgb.service;

import java.util.List;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.Order;
import uuu.vgb.entity.Outlet;
import uuu.vgb.entity.Product;
import uuu.vgb.entity.VGBException;
import uuu.vgb.entity.VIP;

public class OrderService {

    private OrdersDAO dao = new OrdersDAO();
    //OCPJP Mod10 示範polymorphism 多型

    public double order(Customer c, Product p, int quantity) {
        double amount = p.getUnitPrice() * quantity;
        if (c instanceof VIP && !(p instanceof Outlet)) {
            VIP vip = (VIP) c;
            amount *= (100D - vip.getDiscount()) / 100;
        }
        return amount;
    }

    //建立訂單的程式
    public void create(Order order) throws VGBException {
        dao.insert(order);
    }

    public List<Order> searchOrdersByCustomerEmail(String customerEmail) throws VGBException {
        return dao.selectOrdersByCustomerEmail(customerEmail);
    }

    public Order getOrderById(int id) throws VGBException {
        return dao.selectOrderById(id);
    }
//通知已轉帳

    public void upadteOrderStatusToTransfered(int id, String bank, String last5Code,
            double amount, String date, String time) throws VGBException {
        String paymentNote = "銀行: " + bank + "," + "帳號: " + last5Code + "," + "金額: " + amount
                + "轉帳日期時間: " + date + " " + time;

        dao.upadteOrderStatusToTransfered(id, paymentNote);
    }
}
