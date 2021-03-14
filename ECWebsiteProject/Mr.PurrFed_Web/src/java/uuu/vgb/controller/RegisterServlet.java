package uuu.vgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.CustomerService;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register.do"})
public class RegisterServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        //取得session
        HttpSession session = request.getSession();
        //表單中若有中文欄位，設定request的編碼方式UTF-8
        request.setCharacterEncoding("UTF-8");
        //1.取得表單中的欄位值("name")並做檢查
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        char gender = request.getParameter("gender").charAt(0);
        String birthday = request.getParameter("birthday");
        String address = request.getParameter("address");
        String captcha = request.getParameter("captcha");

        //做檢查
        List<String> errors = new ArrayList<>();
        if (email == null || email.length() == 0) {
            errors.add("必須輸入信箱");
        }
        if (password == null || password.length() == 0) {
            errors.add("必須輸入密碼");
        }
        if (captcha == null || captcha.length() == 0) {
            errors.add("必須輸入驗證碼");
        } else {
            String captchaRand = (String) session.getAttribute("RegisterCaptchaServlet");
            if (!captcha.equalsIgnoreCase(captchaRand)) {
                errors.add("驗證碼不正確");
            }
            //驗證碼輸入正確，一定要將此次的captcha從session中清除(不清除會造成記憶體負擔
            session.removeAttribute("RegisterCaptchaServlet");
        }
        //2.若1.檢查無誤才呼叫商業邏輯CustomerService.register
        if (errors.isEmpty()) {
            Customer c = new Customer();
            try {
                c.setEmail(email);
                c.setPassword(password);
                c.setName(name);
                c.setPhone(phone);
                c.setGender(gender);
                c.setBirthday(birthday);
                c.setAddress(address);
                CustomerService service = new CustomerService();
                service.register(c);

                //3.1 forward到register_ok.jsp輸出成功畫面
                request.setAttribute("customer", c);
                request.getRequestDispatcher("/register_ok.jsp").forward(request, response);
                return;
            } catch (VGBException ex) {
                if (ex.getCause() != null) {
                    this.log(ex.getMessage(), ex);
                }
                errors.add(ex.getMessage());
            } catch (Exception ex) {
                this.log("會員註冊發生非預期的錯誤", ex);
                errors.add("系統發生非預期錯誤" + ex.toString());
            }
        }
        //3.2若檢查有誤，forward到register.jsp輸出失敗畫面(返回註冊畫面+註冊失敗訊息)
        request.setAttribute("errors", errors);
        request.getRequestDispatcher("register.jsp").forward(request, response);
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
