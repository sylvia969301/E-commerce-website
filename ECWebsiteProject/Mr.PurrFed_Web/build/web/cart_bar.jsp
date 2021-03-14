

<%@page import="uuu.vgb.entity.Cart"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="uuu.vgb.entity.VIP"%>
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.CartItem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Object obj = session.getAttribute("member");
    Customer member = null;
    if (obj instanceof Customer) {
        member = (Customer) obj;
    }
    Cart cart = (Cart) session.getAttribute("cart");
%>
<%--購物車彈跳視窗--%>
<a href="javascript:closeCartNavHandler()">
    <img src="<%=request.getContextPath()%>/images/exit.png" alt="購物車" style="text-align: center;width:25px;height:25px"/>
    <div class="cartExit" style="">
    </div>
</a>
<a href="<%= request.getContextPath()%>/member/cart.jsp" id="cart_button">
    <input style="width: 184px;color: black;font-size: 10px;border: 0;background:#fff;padding: 5px 10px;margin: 5px 0px" type="button" value="查看/修改購物車">
</a>
<%
    if (cart != null && cart.getSize() > 0) {
        for (CartItem item : cart.getCartItemSet()) {
            Product p = item.getProduct();
%>
<div>
    <img src="<%= p.getPhotoURL()%>" style="width:100%;vertical-align: middle">
</div>
<span style="font-size: 12px;font-weight: bold;color: lightgrey;"><%= p.getName()%>
</span><br>
<span style="color: white">定價 : <%= p instanceof Outlet ? ((Outlet) p).getListPrice() + "元" : p.getUnitPrice() + "元"%>
</span><br>
<span style="color: white">折扣 : <%= p instanceof Outlet ? ((Outlet) p).getDiscountString()
        : (cart.getMember() instanceof VIP ? ((VIP) cart.getMember()).getDiscountString() : "")%>
</span><br>
<span style="color: white">售價 : <%=p.getUnitPrice()%>元
</span><br>
<span style="color: white">數量 : <%= cart.getQuantity(item)%></span>
<%}
    }%>

<script>

    function closeCartNavHandler() {
        $(".cartNav").animate({right: '-460px'});

    }
</script>

