package uuu.vgb.entity;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class Cart {

    private Customer member;

    public Customer getMember() {
        return member;
    }

    public void setMember(Customer member) {
        this.member = member;
    }
    private Map<CartItem, Integer> cart = new HashMap<>();

    //mutator methods 集合元件的setter
    //將商品加入購物車
    public void add(Product p) {
        this.add(p, 1);
    }

    public void add(Product p, int quantity) {
        if (p == null) {
            throw new java.lang.IllegalArgumentException("加入購物車商品不得為null");
        }
        //使用CartItem記憶體位置做比對(判斷有無購物車 若建立新的 若有則使用舊的)
        CartItem item = new CartItem(p);
        Integer oldQuantity = cart.get(item);
        if (oldQuantity == null) {//若沒有之前加的數量，則數量為這次新增的數量quantity
            cart.put(item, quantity);
        } else {
            cart.put(item, oldQuantity + quantity);//若之前有新增數量，則數量再+這次新增的數量quantity
        }
    }

    //修改購物車
    public void update(CartItem item, int quantity) {
        if (item == null) {
            throw new IllegalArgumentException("修改購物車時item不得為null");
        }
        cart.put(item, quantity);
    }

    //刪除購物車
    public void remove(CartItem item) {
        if (item == null) {
            throw new IllegalArgumentException("刪除購物車時item不得為null");
        }
        cart.remove(item);
    }

    //查詢購物車:accessor methods集合元件的getter(代理人程式delegates)
    public int getSize() {
        return cart.size();
    }

    public boolean isEmpty() {
        return cart.isEmpty();
    }

    //取得項目數量(共-項商品)
    public Set<CartItem> getCartItemSet() {
        return cart.keySet();
    }

    //取得單筆項目數量(此項商品買了-個)
    public Integer getQuantity(CartItem item) {
        return cart.get(item);
    }

    //取得商品總件數(所有商品共買了-個)
    public int getTotalQuantity() {
        int totalQuantity = 0;
        for (CartItem item : cart.keySet()) {
            totalQuantity += cart.get(item);
        }
        return totalQuantity;
    }

    //取得訂單總金額(一般客戶)
    public double getTotalAmount() {
        double amount = 0;
        //先將幾項商品讀出來 買幾項就跑幾次for迴圈
        for (CartItem item : cart.keySet()) {
            double price = item.getProduct().getUnitPrice();//將商品價格放進變數price中
            Integer quantity = cart.get(item);//將購買數量放進變數quantity中
            if (quantity != null) {
                amount = amount + price * quantity;
            }
        }
        return amount;
    }

    //取得訂單總金額(VIP客戶)
    public double getVIPTotalAmount() {
        double VIPTotalAmount = 0;

        for (CartItem item : cart.keySet()) {
            double price = item.getProduct().getUnitPrice();
            Integer quantity = cart.get(item);
            if (quantity != null) {
                double sum = price * quantity;
                //檢查客戶是VIP且商品不得為特價品
                if (member instanceof VIP && !(item.getProduct() instanceof Outlet)) {
                    sum = sum * (100-((VIP) member).getDiscount()) / 100;
                }
                VIPTotalAmount += sum;
            }
        }
        return VIPTotalAmount;
    }
}
