package uuu.vgb.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.vgb.entity.Cart;
import uuu.vgb.entity.CartItem;
import uuu.vgb.entity.Product;

@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/member/update_cart.do"})
public class UpdateCartServlet extends HttpServlet {

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
        //1.1取得session存到變數中
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            Set<CartItem> trash = new HashSet<>();//trash宣告在迴圈的外面
            for (CartItem item : cart.getCartItemSet()) {
                //1.2取得request中form表單的輸入欄位
                Product p = item.getProduct();
                String quantity = request.getParameter("quantity_" + p.getId());
                String delete = request.getParameter("delete_" + p.getId());
                if (delete == null) {
                    //沒有船delete 代表要修改數量
                    if (quantity != null && quantity.matches("\\d+")) {
                        int q = Integer.parseInt(quantity);
                        cart.update(item, q);
                    }
                } else {
                    //有傳delete 代表要刪除商品(item)
                    /* cart.remove(item);//刪除的不是最末筆時 會發生錯誤(java.util.ConcurrentModificationException) */
                    //不直接從Map中刪除此Item(刪除此Item時 將此item加入垃圾桶trash中)
                    trash.add(item);
                }
            }
            //藉由trash中紀錄的item來刪除cart中的item
            for (CartItem item : trash) {
                cart.remove(item);
            }
        }

        String submit = request.getParameter("submit");
        System.out.println("submit = " + submit);
        //3.redirect外部轉交到/member/cart.jsp
        if ("我要結帳".equals(submit)) {
            response.sendRedirect(request.getContextPath() + "/member/check_out.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/member/cart.jsp");
        }
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
