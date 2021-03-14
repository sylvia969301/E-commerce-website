
<%@page import="uuu.vgb.entity.CartItem"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.VIP"%>
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Cart"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        Customer member = (Customer) session.getAttribute("member");
        Cart cart = (Cart) session.getAttribute("cart");
        if (member != null && cart != null) {
            cart.setMember(member);
        }
    %>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
        <script>
            function goShopping() {
                location.href = "<%= request.getContextPath()%>/products_list.jsp";
            }
        </script>
    </head>
    <body>
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div calss="article"style="margin-top: 70px;min-height: 400px">
            <%--<p style="letter-spacing: 3px; margin-top:70px;font-size: 18px;background:#efdbd4;padding: 5px;text-align: center ">${sessionScope.member.name}的購物車</p>--%>
            <% if (cart != null && cart.getSize() > 0) {%>
            <form  action="update_cart.do" method="POST" id="cart_form" >
                <table style="width: 100%;min-height: 500px;text-align: center;top: 70px">
                    <caption style="text-align: center;font-weight: 600;font-size: 20px;color: gray;">購物明細</caption>
                    <thead>
                        <tr style=" ">
                            <th>商品照片</th>
                            <th style="text-align: center">商品名稱</th> 
                            <th>定價</th>
                            <th>折扣</th>
                            <th>售價</th>
                            <th>數量</th>
                            <th>刪除</th>  
                        </tr> 
                    </thead>

                    <tbody>

                        <% for (CartItem item : cart.getCartItemSet()) {
                                Product p = item.getProduct();
                        %>
                        <tr style="">
                            <td> <a href="javascript:getProduct('<%=p.getId()%>')"><img src="<%= p.getPhotoURL()%>"style="width:50px; height:50px;margin: 0px;" onerror="getDefaultImage(this)" id="photoURL<%= p.getId()%>" ></a></td>
                            <td><%= p.getName()%></td>
                            <td><%= p instanceof Outlet ? ((Outlet) p).getListPrice() : p.getUnitPrice()%>元</td>
                            <td><%= p instanceof Outlet ? ((Outlet) p).getDiscountString()
                                        : (cart.getMember() instanceof VIP ? ((VIP) cart.getMember()).getDiscountString() : "")%></td>

                            <td><%=p.getUnitPrice()%>元</td>
                            <td><input type="number" value="<%= cart.getQuantity(item)%>" 
                                       name="quantity_<%= p.getId()%>"></td>
                            <td><input type="checkbox" name="delete_<%= p.getId()%>" ></td>
                        </tr>

                        <%}%>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="5"></td>
                            <td colspan="2" style="text-align: center;font-weight: bold">共<%= cart.getSize()%>項,<%=cart.getTotalQuantity()%>件</td>
                        </tr>
                        <%if (cart.getMember() instanceof VIP) {%>
                        <tr>
                            <td colspan="5" style="text-align: right">原始金額 :</td>
                            <td colspan="2"><%= cart.getTotalAmount()%>元</td>
                        </tr>
                        <tr>
                            <td colspan="5" style="text-align: right">VIP折扣 :</td>
                            <td colspan="2"><%= cart.getMember() instanceof VIP ? (100-((VIP)cart.getMember()).getDiscount())+"折" :"無" %></td>
                        </tr>
                        <%}%>
                        <tr style="color: #aa0719;font-weight: bold">
                            <td colspan="5" style="text-align: right">結帳金額 :</td>
                            <td colspan="2"><%= Math.round(cart.getVIPTotalAmount())%>元</td>
                        </tr>
                        
                        <tr>
                            <td colspan="5" style="text-align: right">
                                <a href="javascript:goShopping()"><input type="button" value="回賣場購物"
                                                                         style="border: 0;background: #fff;color: gray;line-height: 25px;font-size: 14px;padding: 2px 8px;letter-spacing: 2px;"></a>
                            </td>
                            <td colspan="4">
                                <button type="submit" name="submit" 
                                        style="border: 0;background:  #fff;color:gray;line-height: 25px;font-size: 14px;padding: 2px 8px;letter-spacing: 2px;margin-right: 20px;">
                                    修改購物車
                                </button>
                                <input type="submit" name="submit" value="我要結帳"
                                       style="border: 0;background: #fff;color:gray;line-height: 25px;font-size: 14px;padding: 2px 8px;letter-spacing: 2px;">
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </form>
            <% } else {%>
            <p>尚未有購物車清單，返回<a href="<%= request.getContextPath()%>/products_list.jsp">商品頁</a>進行購物!</p>
            <%}%>
        </div>

        <!--include footer.jsp(聯絡資訊等)-->
        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
