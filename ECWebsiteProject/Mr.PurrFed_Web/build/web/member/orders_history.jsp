
<%@page import="uuu.vgb.entity.PaymentType"%>
<%@page import="uuu.vgb.entity.Order"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.OrderService"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
    </head>
    <body>
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <%
            Customer member = (Customer) session.getAttribute("member");
            OrderService service = new OrderService();
            List<Order> list = service.searchOrdersByCustomerEmail(member.getEmail());
        %>
       
        <div class="article" style="margin-top: 70px;min-height: 600px">
            <p style="text-align: center;font-weight: 600;font-size: 20px;color: gray;">歷史訂單</p><p style="margin: auto;width:30%;text-align: center;background:lemonchiffon;color: darkred">  ${sessionScope.report}</p>
            <%
                if (list != null && list.size() > 0) {
            %>
            
            <table style="width: 100%" >
                <thead style="background: #efdbd4;">
                    <tr >
                        <th>訂單編號</th>
                        <th>下訂時間</th>
                        <th>出貨狀況</th>
                        <th>付款方式</th>
                        <th>貨運方式</th>
                        <th>總金額</th>
                        <th>訂單明細</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Order order :list) {%>
                    <tr>
                        <td><a href="order.jsp?orderId=<%= order.getId()%>"><%= order.getId()%></a></td>
                        <td><%= order.getOrderDate() %> <%= order.getOrderTime() %></td>
                        <td><%= order.getStatus() %></td>
                        <td>
                            <%= order.getPaymentType() %><% if(order.getStatus()==0 && order.getPaymentType()==PaymentType.ATM){%>
                            <a href="paid.jsp?orderId=<%= order.getId() %>">通知已轉帳</a><%}%>
                        </td>
                        <td>
                            <%= order.getShippingType() %>
                            
                        </td>
                        <td><%= Math.round(order.getTotalAmount() +order.getPaymentFee()+order.getShippingFee()) %>元 </td>
                        <td><a href="order.jsp?orderId=<%= order.getId()%>"><input type="button" style="font-size: 8px;color:black;border: none;background: lightgray;padding: 5px 8px" value="檢視訂單明細" ></a></td>
                    </tr>
                    <%}%>
                    
                </tbody>
               

            </table>

            <%} else { %>
            <p>查無歷史訂單資料</p>
            <% }%>

        </div>


        <!--include footer.jsp(聯絡資訊等)-->
        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
