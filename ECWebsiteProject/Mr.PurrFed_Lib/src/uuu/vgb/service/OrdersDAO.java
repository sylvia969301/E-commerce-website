package uuu.vgb.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.Order;
import uuu.vgb.entity.OrderItem;
import uuu.vgb.entity.PaymentType;
import uuu.vgb.entity.Product;
import uuu.vgb.entity.ShippingType;
import uuu.vgb.entity.VGBException;
//預防前端扣到此類別 不+public

class OrdersDAO {

    private static final String INSERT_ORDER_SQL = "INSERT INTO orders "
            + "(id,customer_email,order_date,order_time,status,payment_type,payment_fee,"
            + "shipping_type,shipping_fee,receiver_name,receiver_email,"
            + "receiver_phone,receiver_address) "
            + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";

    private static final String INSERT_ORDER_ITEMS_SQL = "INSERT INTO order_items "
            + "(order_id,product_id,price,quantity) "
            + "VALUES(?,?,?,?)";

    public void insert(Order order) throws VGBException {
        try ( //1+2.建立資料庫及Driver連線
                Connection connection = RDBConnection.getConnection();
                PreparedStatement pstmt1 = connection.prepareStatement(INSERT_ORDER_SQL, order.getId() <= 0
                        ? Statement.RETURN_GENERATED_KEYS
                        : Statement.NO_GENERATED_KEYS);
                PreparedStatement pstmt2 = connection.prepareStatement(INSERT_ORDER_ITEMS_SQL);) {

            /*資料庫交易控管 將AutoCommit關掉(代替BeginTran) 
            要自己rollback,commit(若無則會timeout掉)
            這裡使用try-catch來做錯誤的關閉機制*/
            connection.setAutoCommit(false);
            try {
                System.out.println("order.getReceiverName()="+order.getReceiverName());
                //3.1.1 傳入pstmt1參數值
                pstmt1.setInt(1, order.getId());
                pstmt1.setString(2, order.getMember().getEmail());
                //當訂單時間是null 則用現在日期時間 若有給值則用訂單時間
                pstmt1.setString(3, order.getOrderDate() == null ? LocalDate.now().toString() : order.getOrderDate().toString());
                pstmt1.setString(4, order.getOrderTime() == null ? LocalTime.now().toString() : order.getOrderTime().toString());
                pstmt1.setInt(5, order.getStatus());
                //PaymentType是列舉型別 使用.name()存取名子
                pstmt1.setString(6, order.getPaymentType().name());
                pstmt1.setDouble(7, order.getPaymentFee());
                pstmt1.setString(8, order.getShippingType().name());
                pstmt1.setDouble(9, order.getShippingFee());
                pstmt1.setString(10, order.getReceiverName());
                pstmt1.setString(11, order.getReceiverEmail());
                pstmt1.setString(12, order.getReceiverPhone());
                pstmt1.setString(13, order.getReceiverAddress());

                //4.1 執行pstmt1
                pstmt1.executeUpdate();

                //5.取回自動給號的id值
                if (order.getId() <= 0) {
                    try (ResultSet rs = pstmt1.getGeneratedKeys();) {
                        while (rs.next()) {
                            int id = rs.getInt(1);//取第一個欄位
                            order.setId(id);
                        }
                    }
                }
                
                for (OrderItem item : order.getOrderItemSet()) {
                    //3.1.2 傳入pstmt2參數值
                    pstmt2.setInt(1, order.getId());
                    pstmt2.setInt(2, item.getProduct().getId());
                    pstmt2.setDouble(3, item.getPrice());
                    pstmt2.setInt(4, item.getQuantity());
                    //4.1 執行pstmt2
                    pstmt2.executeUpdate();
                }
                connection.commit();
            } catch (SQLException ex) {
                //若有錯誤則roolback
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(true);
            }
        } catch (SQLException ex) {
            throw new VGBException("建立訂單失敗", ex);
        }

    }
    //查詢單筆訂單的項目資料
    private static final String SELECT_ORDER_BY_ID = "SELECT orders.id,order_id,"
            + "customer_email,order_date,order_time,status,payment_type,"
            + "payment_fee,payment_note,shipping_type,shipping_fee,shipping_note,"
            + "receiver_name,receiver_email,receiver_phone,receiver_address,"
            + "products.name as pname,product_id,photo_url,price,quantity "
            + "FROM orders LEFT JOIN order_items ON orders.id= order_items.order_id "/*+"AND orders.id=?"  效能更好*/
            + "LEFT JOIN products ON order_items.product_id = products.id "
            + "WHERE orders.id=?";

    public Order selectOrderById(int id) throws VGBException {
        Order order = null;
        try (
                //1+2建立資料庫,Driver連線
                Connection connection = RDBConnection.getConnection();) {
            //3.準備指令
            PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_BY_ID);
            //3.1傳入?值
            pstmt.setInt(1, id);
            //4.執行指令
            ResultSet rs = pstmt.executeQuery();
            //5.處理結果rs(resultSet)
            while (rs.next()) {
                //當無訂單時才建立新訂單
                if (order == null) {
                    order = new Order();
                    order.setId(id);
                    Customer member = new Customer();
                    member.setEmail(rs.getString("customer_email"));
                    order.setMember(member);
                    //LocalDate要先轉型
                    LocalDate date = LocalDate.parse(rs.getString("order_date"));
                    order.setOrderDate(date);
                    //LocalTime要先轉型
                    LocalTime time = LocalTime.parse(rs.getString("order_time"));
                    order.setOrderTime(time);

                    order.setStatus(rs.getInt("status"));

                    /*PaymentType要先轉型 轉型可能會有錯誤故放進try-catch中 
                    且列舉型別取值要用.valueOf()*/
                    String pType = rs.getString("payment_type");
                    try {
                        order.setPaymentType(PaymentType.valueOf(pType));
                    } catch (RuntimeException ex) {
                        System.out.println("查詢訂單(id=" + id + ")時，paymentType資料不正確");
                    }
                    /*ShippingType要先轉型 轉型可能會有錯誤故放進try-catch中 
                    且列舉型別取值要用.valueOf()*/
                    String shType = rs.getString("shipping_type");
                    try {
                        order.setShippingType(ShippingType.valueOf(shType));
                    } catch (RuntimeException ex) {
                        System.out.println("查詢訂單(id=" + id + ")時，shippingType資料不正確");
                    }
                    order.setShippingFee(rs.getDouble("shipping_fee"));
                    order.setShippingNote(rs.getString("shipping_note"));

                    order.setReceiverName(rs.getString("receiver_name"));
                    order.setReceiverEmail(rs.getString("receiver_email"));
                    order.setReceiverPhone(rs.getString("receiver_phone"));
                    order.setReceiverAddress(rs.getString("receiver_address"));

                }
                /*orderId是基本型別 但資料庫中允許null 故轉型較複雜
                    若orderId != null 代表有明細 即將明細建立起來*/
                Number orderId = (Number) rs.getObject("order_id");
                if (orderId != null) {
                    OrderItem item = new OrderItem();
                    item.setOrderId(orderId.intValue());

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("pname"));
                    p.setPhotoURL(rs.getString("photo_url"));
                    item.setProduct(p);

                    item.setPrice(rs.getShort("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    order.add(item);
                }
            }
            return order;
        } catch (SQLException ex) {
            throw new VGBException("查詢訂單失敗", ex);
        }
    }

    private static final String SELECT_ORDERS_BY_CUSTOMER_EMAIL = "SELECT orders.id,order_id,customer_email,order_date,order_time,status, "
            + "payment_type,payment_fee,shipping_type,shipping_fee, " /* 以上主檔*/
            + "SUM(price*quantity) as total_amount "/*明細檔 : 訂單金額加總 / as : 暱稱*/
            + "FROM orders LEFT JOIN order_items ON orders.id= order_items.order_id "/*關聯條件*/
            + "WHERE customer_email=?"
            + "GROUP BY orders.id "/*group by : 分組加總*/
            + "ORDER BY order_date DESC,order_time DESC";

    public List<Order> selectOrdersByCustomerEmail(String customerEmail) throws VGBException {
        List<Order> list = new ArrayList<>();
        try (
                //1+2建立資料庫,Driver連線
                Connection connection = RDBConnection.getConnection();) {
            //3.準備指令
            PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDERS_BY_CUSTOMER_EMAIL);
            //3.1傳入?值
            pstmt.setString(1, customerEmail);
            try (//4.執行指令
                    ResultSet rs = pstmt.executeQuery();) {
                //5.處理結果rs(resultSet)
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));

                    Customer member = new Customer();
                    member.setEmail(rs.getString("customer_email"));
                    order.setMember(member);
                    order.setOrderDate(LocalDate.parse(rs.getString("order_date")));
                    order.setOrderTime(LocalTime.parse(rs.getString("order_time")));
                    order.setStatus(rs.getInt("status"));

                    String pType = rs.getString("payment_type");
                    try {
                        order.setPaymentType(PaymentType.valueOf(pType));
                    } catch (Exception ex) {
                        System.out.println("查詢客戶歷史訂單(id: " + order.getId() + ")時PaymentType資料不正確");
                    }
                    order.setPaymentFee(rs.getDouble("payment_fee"));

                    String shType = rs.getString("shipping_type");
                    try {
                        order.setShippingType(ShippingType.valueOf(shType));
                    } catch (Exception ex) {
                        System.out.println("查詢客戶歷史訂單(id: " + order.getId() + ")時ShippingType資料不正確");
                    }
                    order.setShippingFee(rs.getDouble("shipping_fee"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    list.add(order);
                }
            }
        } catch (SQLException ex) {
            throw new VGBException("查詢客戶歷史訂單失敗", ex);
        }
        return list;
    }

    private static final String UPDATE_ORDER_STATUS_TO_TRANSFERED = "UPDATE orders SET status=1, "
            + "payment_note=? "
            + "WHERE id=? AND status=0 AND payment_type='" + PaymentType.ATM.name() + "'";

    public void upadteOrderStatusToTransfered(int id, String paymentNote) throws VGBException {
        //TODO:完成...
    }

    //查詢歷史訂單測試
    public static void main(String[] args) {
//        OrdersDAO dao = new OrdersDAO();
//        CustomersDAO cDAO = new CustomersDAO();
//        try {
//            Customer member = cDAO.select("wei.waa@gmail.com");
//
//            OrderItem item = new OrderItem();
//            Product p = new Product();
//            p.setId(1);
//            p.setName("好味貓漢堡｜海味鮮蝦 單一口味 多入");
//            p.setCategory("frozen");
//            p.setStock(10);
//            p.setUnitPrice(100);
//            item.setOrderId(1);
//            item.setPrice(260);
//            item.setProduct(p);
//            item.setQuantity(1);
//            
//            Order order = new Order();
//            order.setId(1);
//            order.add(item);
//            order.setOrderDate(LocalDate.parse("2018-09-07"));
//            order.setOrderTime(LocalTime.parse("12:05:08"));
//            order.setPaymentFee(60);
//            order.setPaymentType(PaymentType.ATM);
//            order.setShippingFee(60);
//            order.setShippingType(ShippingType.STORE);
//            order.setReceiverName("陳書軒");
//            order.setReceiverEmail("n123123@yhaoo.coij");
//            order.setReceiverPhone("0988777444");
//            order.setReceiverAddress("台北市中正路");
//            order.setMember(member);
//            
//            
//            //System.out.println("order = " + order);
//            dao.insert(order);
//            
//        } catch (VGBException ex) {
//            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
    }

}
