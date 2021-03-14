package uuu.vgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;
import uuu.vgb.entity.VIP;
import uuu.vgb.service.CustomerService;

@WebServlet(name = "UpdateServlet", urlPatterns = {"/member/update.do"})
public class UpdateServlet extends HttpServlet {

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
        /*1..取得request中form的輸入欄位值(name)並做檢查:
        userId password passwordCheck  name gender email birthday phone
        address married bloodType captcha*/
        String email = request.getParameter("email");
        String previousPassword = request.getParameter("previousPassword");
        String password = request.getParameter("password");
        String passwordCheck = request.getParameter("passwordCheck");
        String name = request.getParameter("name");
        char gender = request.getParameter("gender").charAt(0);
        String birthday = request.getParameter("birthday");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String captcha = request.getParameter("captcha");

        Customer member = (Customer) session.getAttribute("member");
        List<String> errors = new ArrayList<>();
        if (email == null || email.equals(member.getEmail())) {
            errors.add("主鍵值帳號不正確");
        }
        if (previousPassword == null) {
            errors.add("請輸入舊密碼");
        } else if (previousPassword == password) {
            errors.add("新密碼不得與舊密碼相同");
        }
        if (passwordCheck == null) {
            errors.add("必須確認密碼");
        }
        if (password == null || password.length() < 6 || password.length() > 20) {
            errors.add("必須輸入6~20個字元的密碼");
        }
        if (captcha == null || captcha.length() == 0) {
            errors.add("必須輸入驗證碼");
        } else {
            String rand = (String) session.getAttribute("RegisterCaptchaServlet");
            if (!captcha.equalsIgnoreCase(rand)) {
                errors.add("驗證碼不正確");
            }
            //驗證碼正確之後此筆rand一定要從session中清掉
            session.removeAttribute("RegisterCaptchaServlet");
        }
        //2.若1.檢查無誤，才呼叫CustomerService.update商業邏輯
        if (errors.isEmpty()) {
            try {
                Customer c = member.getClass().newInstance();
                c.setEmail(email);
                c.setPassword(password);
                c.setName(name);
                c.setGender(gender);
                c.setPhone(phone);
                c.setEmail(email);
                c.setBirthday(birthday);
                c.setAddress(address);
                if (c instanceof VIP) {
                    ((VIP) c).setDiscount(((VIP) member).getDiscount());
                }

                CustomerService service = new CustomerService();
                service.update(c);

                //3.1 修改成功則redirect到首頁 TODO:成功畫面
                session.setAttribute("member", c);
                response.sendRedirect(request.getContextPath());
                return;
            } catch (VGBException ex) {
                if (ex.getCause() != null) {
                    this.log(ex.getMessage(), ex);
                }
                errors.add(ex.getMessage());
            } catch (Exception ex) {
                this.log("會員修改發生非預期錯誤", ex);
                errors.add("會員修改發生非預期錯誤:" + ex.toString());
            }
        }
        //3.2若有錯，forward到update.jsp輸出修改失敗畫面
        request.setAttribute("errors", errors);
        request.getRequestDispatcher("update.jsp").forward(request, response);
        return;//不要忘記return
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
//@Override
//        protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

