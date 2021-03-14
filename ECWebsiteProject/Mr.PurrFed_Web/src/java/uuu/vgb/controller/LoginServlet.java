
package uuu.vgb.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.CustomerService;

//當伺服器收到的請求url是login.do，就會將LoginServlet建立起來並執行
@WebServlet(name = "LoginServlet", urlPatterns = {"/login.do"})
public class LoginServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        //1.取得request中form的輸入欄位值(name):email,password,captcha,auto，並作檢查
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");
        String auto = request.getParameter("auto");

        List<String> errors = new ArrayList<>();//需import:java.util.List、java.util.ArrayList
        if (email == null || email.length() == 0) {
            errors.add("必須輸入信箱");
        }
        if (password == null || password.length() < 6 || password.length() > 20) {
            errors.add("必須輸入6~20個字元的密碼");
        }
        if (captcha == null || captcha.length() == 0) {
            errors.add("必須輸入驗證碼");
        } else {
            String rand = (String) session.getAttribute("CaptchaServlet");
            if (!captcha.equalsIgnoreCase(rand)) {
                errors.add("驗證碼不正確");
            }
            //驗證碼正確之後此筆rand一定要從session中清掉
            session.removeAttribute("CaptchaServlet");
        }

        //2.若1.檢查無誤，才呼叫CustomerService.login商業邏輯
        if (errors.isEmpty()) {
            CustomerService service = new CustomerService();
            try {
                Customer c = service.login(email, password);
                //將cookie物件建立、給值並傳送給client
                Cookie emailCookie = new Cookie("email", email);//要給初值("name",value)
                Cookie autoCookie = new Cookie("auto", "checked");//checked是html check box屬性
                emailCookie.setMaxAge(0);
                autoCookie.setMaxAge(0);
                if (auto != null) {
                    emailCookie.setMaxAge(30 * 24 * 60 * 60);//單位(秒)    
                    autoCookie.setMaxAge(30 * 24 * 60 * 60);//單位(秒)
                }
                response.addCookie(emailCookie);
                response.addCookie(autoCookie);

                //3.1改用Redirect(外部轉交)，不使用forward(內部轉交)首頁
                session.setAttribute("member", c);//將客戶資料一併轉交
                response.sendRedirect(request.getContextPath());
//                session.setMaxInactiveInterval(30);//30 秒即登出使用者(將使用者session id清掉)
                return;
                //拋錯部分要細看
            } catch (VGBException ex) {
                if (ex.getCause() instanceof SQLException) {
                    this.log("客戶登入失敗:", ex);
                }
                errors.add(ex.getMessage());//給前端看
            } catch (Exception ex) {
                this.log("客戶登入失敗，發生非預期錯誤", ex);
                errors.add("發生非預期錯誤" + ex.getMessage());
            }
        }
        //3.2 輸出失敗畫面forward(內部轉交)login.html(登入失敗直接重新登入)
        request.setAttribute("errors", errors);//將錯誤清單一併轉交
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
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
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
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
