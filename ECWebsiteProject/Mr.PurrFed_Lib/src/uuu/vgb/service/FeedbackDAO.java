package uuu.vgb.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import uuu.vgb.entity.Feedback;
import uuu.vgb.entity.VGBException;

public class FeedbackDAO {

    //新增feedback資料到feedback資料表格中
    private static final String INSERT_FEEDBACK_SQL = "INSERT INTO feedbacks "
            + "(user_email, user_name,text)"
            + "VALUES(?,?,?)";
    
    public void insert(Feedback feedback) throws VGBException {
        try ( //1+2建立資料庫及Driver連線
                Connection connection = RDBConnection.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(INSERT_FEEDBACK_SQL);) {
            //3.1.1 傳入pstmt1參數值
            pstmt.setString(1, feedback.getUserEmail());
            pstmt.setString(2, feedback.getUserName());
            pstmt.setString(3, feedback.getText());

            //4.1 執行pstmt1
            pstmt.executeUpdate();
            
        } catch (SQLException ex) {
            throw new VGBException("傳送確認信件失敗", ex);
        }
    }
    
    public static void main(String[] args) throws VGBException {
        try {
            FeedbackDAO dao = new FeedbackDAO();
            Feedback feedback = new Feedback();
            feedback.setUserEmail("n969301@yahoo.com.tw");
            feedback.setUserName("Syl");
            feedback.setText("很好吃!還會再回購的");
            dao.insert(feedback);
            System.out.println("feedback = " + feedback);
        } catch (VGBException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
