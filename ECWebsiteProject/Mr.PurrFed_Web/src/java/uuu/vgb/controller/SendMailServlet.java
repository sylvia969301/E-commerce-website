package uuu.vgb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.demo.service.MailService;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.Feedback;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.FeedbackService;

@WebServlet(name = "SendMailServlet", urlPatterns = {"/send_mail.do"})
public class SendMailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Customer member = (Customer) session.getAttribute("member");
        //1.取得request中的form輸入資料email/name/text 
        String userEmail = request.getParameter("email");
        String userName = request.getParameter("name");
        String text = request.getParameter("text");
        //1.2建立錯誤清單 並做欄位項目檢查
        List<String> errors = new ArrayList<>();
        if (userEmail == null || userEmail.length() == 0) {
            errors.add("必須輸入Email");
        }
        if (userName == null || userName.length() == 0) {
            errors.add("必需輸入名字");
        }
        if (text == null || text.length() == 0) {
            errors.add("必須輸入內容");
        }

        //2.若檢查無誤 則呼叫商業邏輯
        if (errors.isEmpty()) {
            Feedback customersFeedback= new Feedback();
            try {
                customersFeedback.setUserEmail(userEmail);
                customersFeedback.setUserName(userName);
                customersFeedback.setText(text);
                FeedbackService service = new FeedbackService();
                service.create(customersFeedback);
                MailService.sendMail(userEmail); 
                
                //3.1 forward內部轉交到首頁 
                request.getRequestDispatcher("/").forward(request, response);
                return;
            } catch (VGBException ex) {
                if (ex.getCause() != null) {
                    this.log("傳送確認信件失敗", ex);
                }
                errors.add(ex.getMessage());
            } catch (Exception ex) {
                this.log("傳送確認信件失敗，發生非預期錯誤", ex);
                errors.add("傳送確認信件失敗，發生非預期錯誤" + ex);
            }

        }
        //3.2 若有錯誤則內部轉交回首頁畫面
        request.setAttribute("errors", errors);
        request.getRequestDispatcher("/").forward(request, response);
        return;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
