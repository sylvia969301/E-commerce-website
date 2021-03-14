package uuu.vgb.service;

import uuu.vgb.entity.Customer;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import uuu.vgb.entity.VGBException;
import uuu.vgb.entity.VIP;

class CustomersDAO { // package-friendly DAO class design 不加public 同套件都能使用

    private static final String SELECT_BY_EMAIL = "SELECT email,name,password,phone,gender,"
            + "birthday,address,class_type,discount "
            + "FROM customers WHERE email=?";
    
    Customer select(String email) throws VGBException {//利用主鍵值查詢客戶 
        Customer c = null;
        
        try (
                //2.建立連線
                Connection connection = RDBConnection.getConnection();//呼叫原先另外建立的1,2.步驟( RDBConnection )
                //3.準備指令
                PreparedStatement pstmt = connection.prepareStatement(SELECT_BY_EMAIL);) {

            //3.1傳入?的值
            pstmt.setString(1, email);
            
            try (
                    //4.執行指令
                    ResultSet rs = pstmt.executeQuery();) {//5.處理結果rs(resultSet)
                while (rs.next()) {
                    String classType = rs.getString("class_type");
                    if (classType.equals("VIP")) {
                        c = new VIP();
                    } else {
                        c = new Customer();
                    }
                    
                    c.setEmail(rs.getString("email"));
                    c.setName(rs.getString("name"));
                    c.setPassword(rs.getString("password"));
                    c.setPhone(rs.getString("phone"));
                    c.setGender(rs.getString("gender").charAt(0));//gender 是字元
                    c.setBirthday(rs.getString("birthday"));
                    c.setAddress(rs.getString("address"));
                    
                    if (c instanceof VIP) {
                        ((VIP) c).setDiscount(rs.getInt("discount"));
                    }
                }
            }
            return c;
        } catch (SQLException ex) {
            throw new VGBException("用帳號查詢客戶失敗:", ex.getCause());
        }
        
    }
    private static final String INSERT_SQL = "INSERT INTO customers "
            + "(email,name,password,phone,gender,"
            + "birthday,address,class_type,discount) "
            + "VALUES (?,?,?,?,?,?,?,?,?)";

    //用於新增資料的方法(insert) java新增/修改資料的程式都不用回傳值(void即可)
    public void insert(Customer c) throws VGBException {
        try (
                //1.+2.呼叫RDBConnection的類別方法 (載入Driver+建立資料庫連線)
                Connection connection = RDBConnection.getConnection();
                //3.準備指令
                PreparedStatement pstmt = connection.prepareStatement(INSERT_SQL);) {

            //3.1 傳入?的值
            pstmt.setString(1, c.getEmail());
            pstmt.setString(2, c.getName());
            pstmt.setString(3, c.getPassword());
            pstmt.setString(4, c.getPhone());
            pstmt.setString(5, String.valueOf(c.getGender()));
            pstmt.setString(6, String.valueOf(c.getBirthday()));
            pstmt.setString(7, c.getAddress());
            
            pstmt.setString(8, c.getClass().getSimpleName());//若是.getName()就會存到uuu.vgb.....完整的名稱
            if (c instanceof VIP) {
                pstmt.setInt(9, ((VIP) c).getDiscount());
            } else {
                pstmt.setInt(9, 0);
            }

            //4.執行指令(insert這支新增程式執行指令為.executeUpdate()
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new VGBException("新增客戶失敗", ex);
        }
    }

    //會員修改資料程式
    private static final String UPDATE_SQL = "UPDATE customers "
            + "SET password=?,name=?,phone=?,gender=?,"
            + "birthday=?,address=?,class_type=?,discount=? "
            + "WHERE email=?";
    
    Customer update(Customer c) throws VGBException {
        try (
                //1+2.建立連線
                Connection connection = RDBConnection.getConnection();
                //3.準備指令
                PreparedStatement pstmt = connection.prepareStatement(UPDATE_SQL);) {

            //3.1傳入?的值
            pstmt.setString(9, c.getEmail());
            pstmt.setString(1, c.getPassword());
            pstmt.setString(2, c.getName());
            pstmt.setString(3, c.getPhone());
            pstmt.setString(4, String.valueOf(c.getGender()));
            pstmt.setString(5, String.valueOf(c.getBirthday()));
            pstmt.setString(6, c.getAddress());
            if (c instanceof VIP) {
                pstmt.setInt(7, ((VIP) c).getDiscount());
            } else {
                pstmt.setInt(7, 0);
            }
            pstmt.setString(8, c.getEmail());

            //4.執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new VGBException("客戶修改資料失敗", ex);
        }
        return c;
    }
    
    public static void main(String[] args) {//測試insert
        try {
            CustomersDAO dao = new CustomersDAO();
//            Customer data = new Customer();
//            data.setId("A123123123");
//            data.setEmail("lululikespussy@gmail.com");
//            data.setName("謝政盧");
//            data.setPassword("5487666");
//            data.setPhone("0962341523");
//            data.setGender('M');
//            data.setBirthday("1990-02-20");
//            data.setAddress("桃園市桃園區富錦街一巷24號5樓");
//            data.setBloodType(BloodType.A);
//            data.setMarried(true);
//           
//            
//            dao.insert(data);
            Customer c = dao.select("lululikespussy@gmail.com");
            System.out.println("c=" + c);
            c.setEmail("lulu666@gmail.com");
            System.out.println("c=" + c);
        } catch (VGBException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
}
