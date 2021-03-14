package uuu.vgb.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.Order;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.OrderService;

@WebServlet(name = "PaidServlet", urlPatterns = {"/member/paid.do"})
public class PaidServlet extends HttpServlet {

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
        Customer member = (Customer) session.getAttribute("member");
        List<String> errors = new ArrayList<>();
        if (member == null) {
            errors.add("請重新登入");
        }
        //1.讀取request中form的表單輸入值:order,bank,last5Code,amount,time並做檢查
        String orderId = request.getParameter("orderId");
        String bank = request.getParameter("bank");
        String last5Code = request.getParameter("last5Code");
        String amount = request.getParameter("amount");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String report = "";
        //做檢查
        if (orderId == null || !orderId.matches("\\d+")) {//\\d+表示正整數 可二位數以上
            errors.add("訂單編號不正確");
        }
        if (bank == null || bank.length()== 0) {
            errors.add("必須輸入轉帳銀行");
        }
        if (last5Code == null || last5Code.length() == 0) {
            errors.add("必須輸入帳號後五碼");
        }
        if (amount == null || amount.length() == 0) {
            errors.add("必輸入轉帳金額");
        }

        try {
            LocalDate.parse(date);
        } catch (Exception ex) {
            errors.add("必須輸入轉帳日期");
        }
        try {
            LocalTime.parse(time);
        } catch (Exception ex) {
            errors.add("必須輸入轉帳時間");
        }

        //若檢查無誤  則呼叫商業邏輯
        if (errors.isEmpty()) {
            try {
                OrderService service = new OrderService();
                int oid = Integer.parseInt(orderId);
                Order order = service.getOrderById(oid);
                if (member.equals(order.getMember())) {
                    service.upadteOrderStatusToTransfered(oid, bank, last5Code, oid, date, time);
                    //3.1redirect外部轉交到歷史訂單
                    report="通知已轉帳成功!";
                    response.sendRedirect("orders_history.jsp");
                    session.setAttribute("report",report);
                    return;
                } else {
                    errors.add("訂單編號不正確");
                }
            } catch (VGBException ex) {
                if (ex.getCause() != null) {
                    this.log("通知已轉帳失敗", ex);
                }
                errors.add(ex.toString());
            } catch (Exception ex) {
                this.log("通知已轉帳時發生非預期的錯誤", ex);
                errors.add("通知已轉帳時發生非預期的錯誤" + ex);
            }
        }
        //3.2將錯誤清單放進request中 並forward內部轉交到paid.jsp
        request.setAttribute("errors", errors);
        request.getRequestDispatcher("paid.jsp").forward(request, response);
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
