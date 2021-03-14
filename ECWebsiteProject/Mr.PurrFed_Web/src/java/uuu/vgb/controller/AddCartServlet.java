package uuu.vgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.vgb.entity.Cart;
import uuu.vgb.entity.Product;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.ProductService;

@WebServlet(name = "AddCartServlet", urlPatterns = {"/add_cart.do"})
public class AddCartServlet extends HttpServlet {

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
        //1.取得request中的form輸入資料productId/quantity
        String productId = request.getParameter("productId");
        String quantity = request.getParameter("quantity");
        //做檢查 \\d代表整數 +代表可寫到二位數以上
        if (productId != null && productId.matches("\\d+"));
        //2.若檢查無誤 呼叫商業邏輯
        ProductService service = new ProductService();

        try {
            Product p = service.getProductById(Integer.parseInt(productId));
            if (p != null && quantity != null && quantity.matches("\\d+")) {
                int q = Integer.parseInt(quantity);
                //從session中檢查有無購物車 若無則建立新的 若有則沿用舊的
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null) {
                    cart = new Cart();
                    session.setAttribute("cart", cart);
                    cart.add(p, q);
                }else{
                cart.add(p, q);
                }
            }
        } catch (VGBException ex) {
            this.log("加入購物車失敗", ex);
        }catch(Exception ex){
            this.log("加入購物車時發生非預期錯誤", ex);
        }
        //3.redirect給/member/cart.jsp改成forward給/WEB-INF/small_cart.jsp
        request.getRequestDispatcher("/WEB-INF/small_cart.jsp").forward(request, response);
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
