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
import uuu.vgb.entity.Cart;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.Order;
import uuu.vgb.entity.PaymentType;
import uuu.vgb.entity.ShippingType;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.OrderService;

@WebServlet(name = "CheckOutServlet", urlPatterns = {"/member/check_out.do"})
public class CheckOutServlet extends HttpServlet {

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
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null && cart.getSize() > 0) {
            cart.setMember(member);
        } else {
            //若購物車沒東西 結帳則傳回購物車畫面
            response.sendRedirect("cart.jsp");
            return;
        }
        /*1.讀取request表單中form的輸入向:paymentType,shippingType,receiverName receiverEmail 
        receiverPhone receiverAddress*/
        String paymentType = request.getParameter("paymentType");
        String shippingType = request.getParameter("shippingType");
        String receiverName = request.getParameter("receiverName");
        String receiverEmail = request.getParameter("receiverEmail");
        String receiverPhone = request.getParameter("receiverPhone");
        String receiverAddress = request.getParameter("receiverAddress");

        List<String> errors = new ArrayList<>();
        if (paymentType == null || paymentType.length() == 0) {
            errors.add("必須選擇付款方式");
        }
        if (shippingType == null || shippingType.length() == 0) {
            errors.add("必須選擇貨運方式");
        }
        if (receiverName == null || receiverName.length() == 0) {
            errors.add("必須輸入收件人姓名");
        }
        if (receiverEmail == null || receiverEmail.length() == 0) {
            errors.add("必須輸入收件人Email");
        }
        if (receiverPhone == null || receiverPhone.length() == 0) {
            errors.add("必須輸入收件人電話");
        }
        if (receiverAddress == null || receiverAddress.length() == 0) {
            errors.add("必須輸入收件人地址");
        }

        //2.若檢查無誤 則呼叫商業邏輯
        if (errors.isEmpty()) {
            try {
                
                Order order = new Order();
                order.setMember(member);
                order.add(cart);
                
                try{
                    order.setPaymentType(PaymentType.valueOf(paymentType));
                    order.setPaymentFee(order.getPaymentType().getFee());
                }catch(Exception ex){
                    errors.add("請選擇正確的付款方式");
                }
                try{
                    order.setShippingType(ShippingType.valueOf(shippingType));
                    order.setShippingFee(order.getShippingType().getFee());
                }catch(Exception ex){
                    errors.add("請選擇正確的貨運方式");
                }
                order.setReceiverName(receiverName);
                order.setReceiverEmail(receiverEmail);
                order.setReceiverPhone(receiverPhone);
                order.setReceiverAddress(receiverAddress);
                OrderService service = new OrderService();
                service.create(order);
                //建立完結帳訂單 要記得將購物車內容清掉
                session.removeAttribute("cart");
                //3.1 forward內部轉交到 /member/order.jsp
                request.setAttribute("order", order);
                request.getRequestDispatcher("order.jsp").forward(request, response);
                return;
                
            } catch (VGBException ex) {
                if (ex.getCause() != null) {
                    this.log("建立訂單失敗", ex);
                }
                errors.add(ex.getMessage());
            } catch (Exception ex) {
                this.log("建立訂單失敗，發生非預期錯誤:", ex);
                errors.add("建立訂單失敗，發生非預期錯誤:" + ex);
            }
        }
        //3.2 若有錯誤則內部轉交回結帳畫面
         request.setAttribute("errors", errors);
                request.getRequestDispatcher(request.getContextPath()+"/member/check_out.jsp").forward(request, response);
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
