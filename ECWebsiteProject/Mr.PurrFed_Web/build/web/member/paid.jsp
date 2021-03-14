
<%@page import="java.time.LocalDate"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="uuu.vgb.entity.Order"%>
<%@page import="uuu.vgb.service.OrderService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Customer member = (Customer) session.getAttribute("member");
    Order order = (Order) request.getAttribute("order");
    if (member != null && order == null) {
        String orderId = request.getParameter("orderId");
        if (orderId != null && orderId.matches("\\d+")) {
            OrderService service = new OrderService();
            order = service.getOrderById(Integer.parseInt(orderId));
            if (order != null && !member.equals(order.getMember())) {
                order = null;
            }
        }
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
    </head>
    <body>
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div style="margin-top: 70px;text-align: center">
            <p>通知已轉帳</p>
            <p style="color: darkred">${requestScope.errors}</p>
            <% if (order != null) { %>
          
            <form action="paid.do" method="POST" style="width: 60%;text-align: center;margin: auto">
                <p>
                    <label>訂單編號:</label>
                    <input type="number" name="orderId" value="<%= order.getId()%>" readonly>
                </p>
                <p>
                    <label>信用卡銀行:</label>
                    <input required name="bank" placeholder="請輸入信用卡銀行" >
                </p>
                <p>
                    <label>信用卡後五碼:</label>
                    <input required name="last5Code" placeholder="請輸入信用卡後五碼" pattern="[0-9]{5}">
                </p>
                <p>
                    <label>轉帳金額:</label>
                    <input required name="amount" 
                           value="<%= Math.round(order.getTotalAmount()+order.getPaymentFee()+order.getShippingFee()) %>元">
                </p>
                <p>
                    <label>轉帳日期:</label>
                    <input required type="date" name="date" min="<%= order.getOrderDate() %>" max="<%= LocalDate.now() %>">
                     <label>轉帳時間:</label>
                    <input required type="time" name="time">
                </p>
                <input type="submit" value="確定"/>
                

            </form>
            <%} else {%>
            <p>查無此訂單</p>
            <%}%>
        </div>
        <!--include footer.jsp(聯絡資訊等)-->
        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
