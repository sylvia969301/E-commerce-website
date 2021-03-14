package uuu.vgb.service;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import uuu.vgb.entity.VGBException;

//將步驟1,2放進此類別中
class RDBConnection { //不加public 同個套件都能使用(package-friendly class design)

    private static final String driver = "com.mysql.jdbc.Driver";
    private static final String url = "jdbc:mysql://localhost:3306/my_web?zeroDateTimeBehavior=convertToNull&characterEncoding=utf8";
    private static final String user = "root";
    private static final String password = "1234";

    public static Connection getConnection() throws VGBException {
        try {
            //1.載入JDBC Driver
            Class.forName(driver);

            try {//這裡的2.不需要放進try的小括號中(因為必須回傳connection 若關閉就不能return了) 將交由其他程式作關閉
                //2.建立資料庫連線後回傳此connection物件
                Connection connection = DriverManager.getConnection(url, user, password);
                return connection;
            } catch (SQLException ex) {
//                Logger.getLogger(RDBConnection.class.getName()).log(Level.SEVERE, null, ex);
                throw new VGBException("無法建立連線", ex);
            }

        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(RDBConnection.class.getName()).log(Level.SEVERE, null, ex);
            throw new VGBException("無法載入JDBC Driver:" + driver, ex);
        }
    }

    public static void main(String[] args) {
        try (Connection conn = RDBConnection.getConnection();) {
            System.out.println(conn.getCatalog());//vgb
        } catch (VGBException ex) {
            Logger.getLogger(RDBConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            System.out.println("發生非預期錯誤!");
        }
    }
}
