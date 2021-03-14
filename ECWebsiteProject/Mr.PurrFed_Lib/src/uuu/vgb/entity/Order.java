package uuu.vgb.entity;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Order {

    private int id;//PKey, auto increment
    private LocalDate orderDate = LocalDate.now();
    private LocalTime orderTime = LocalTime.now();
    private Customer member;
    private Set<OrderItem> orderItem;
    private int status = 0;//0-新訂單,1-已轉帳,2-已入帳,3-已出貨...

    private PaymentType paymentType;
    private double paymentFee;
    private String paymentNote;

    private ShippingType shippingType;
    private double shippingFee;
    private String shippingNote;

    private String receiverName;
    private String receiverEmail;
    private String receiverPhone;
    private String receiverAddress;

    private Set<OrderItem> orderItemSet = new HashSet<>();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public LocalTime getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(LocalTime orderTime) {
        this.orderTime = orderTime;
    }

    public Customer getMember() {
        return member;
    }

    public void setMember(Customer member) {
        this.member = member;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public PaymentType getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
    }

    public double getPaymentFee() {
        return paymentFee;
    }

    public void setPaymentFee(double paymentFee) {
        this.paymentFee = paymentFee;
    }

    public String getPaymentNote() {
        return paymentNote;
    }

    public void setPaymentNote(String paymentNote) {
        this.paymentNote = paymentNote;
    }

    public ShippingType getShippingType() {
        return shippingType;
    }

    public void setShippingType(ShippingType shippingType) {
        this.shippingType = shippingType;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public String getShippingNote() {
        return shippingNote;
    }

    public void setShippingNote(String shippingNote) {
        this.shippingNote = shippingNote;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverEmail() {
        return receiverEmail;
    }

    public void setReceiverEmail(String receiverEmail) {
        this.receiverEmail = receiverEmail;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    //orderItemSet's mutators  賦值程式
    public void add(OrderItem item) {//from database
        orderItemSet.add(item);
    }

//將購物車資料倒進來
    public void add(Cart cart) {
        //from check_out.do
        for (CartItem cartItem : cart.getCartItemSet()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setQuantity(cart.getQuantity(cartItem));

            double price = cartItem.getProduct().getUnitPrice();
            if (cart.getMember() instanceof VIP && !(cartItem.getProduct() instanceof Outlet)) {
                price = price * (100 - ((VIP) cart.getMember()).getDiscount()) / 100;
            }
            orderItem.setPrice(price);
            orderItemSet.add(orderItem);

        }
    }
    //orderItemSet's accessors  取值程式

//    public int size() {
//        return orderItemSet.size();
//    }
//
//    public boolean isEmpty() {
//        return orderItemSet.isEmpty();
//    }

    public Set<OrderItem> getOrderItemSet() {
        /*return Collections.unmodifiableSet(orderItemSet);*///回傳一個不可被修改的集合 讓程式只能看不能改 (Collections.unmodifiableSet())
        return new HashSet<>(orderItemSet);//回傳集合的副本
    }
    //存取後端資料庫加總金額
    private double totalAmount;

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getTotalAmount() {
        double amount = 0;
        if (orderItemSet != null && orderItemSet.size() > 0) {
            for (OrderItem item : orderItemSet) {
                amount = amount + item.getPrice() * item.getQuantity();
            }
        } else {
            return totalAmount;
        }
        return amount;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 17 * hash + this.id;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Order other = (Order) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "==========================\nOrder{" + "\n"
                + "id=" + id + "\n"
                + "member=" + member + "\n"
                + "orderDate=" + orderDate + "\n"
                + "orderTime=" + orderTime + "\n"
                + "orderItem=" + orderItem + "\n"
                + "status=" + status + "\n"
                + "paymentType=" + paymentType + "\n"
                + "paymentFee=" + paymentFee + "\n"
                + "paymentNote=" + paymentNote + "\n"
                + "shippingType=" + shippingType + "\n"
                + "shippingFee=" + shippingFee + "\n"
                + "shippingNote=" + shippingNote + "\n"
                + "receiverName=" + receiverName + "\n"
                + "receiverEmail=" + receiverEmail + "\n"
                + "receiverPhone=" + receiverPhone + "\n"
                + "receiverAddress=" + receiverAddress + "\n"
                + "orderItemSet=" + orderItemSet + "\n"
                + " 總金額:" + this.getTotalAmount() + '}' + "\n==============================";
    }

}
