
<%@page import="uuu.vgb.entity.PaymentType"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.OrderItem"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.OrderService"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="uuu.vgb.entity.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
        <style>
            .article thead{
                background: #efdbd4;
                
            }
            .article table{
                width: 100%;
            }
            .article{
                margin-top: 70px;
                min-height: 600px
            }
            #header{
                text-align: center;
                font-weight: 500;
                font-size: 20px;
                color: gray;
                
            }
        </style>
    </head>
    <body> 
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
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
        
        <div class="article" >
            <p id="header" style="font-weight: bold">訂單明細</p>
            <%  if (order != null) {%>
            <table style="width: 70%;margin: auto">
                <thead >
                    <tr>
                       
                        <th>下訂時間</th>
                        <th>出貨狀況</th>
                        <th>總金額</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        
                        <td><%= order.getOrderDate()%> <%= order.getOrderTime()%></td>
                        <td><%= order.getStatus()%></td>
                        <td><%= Math.round(order.getTotalAmount() + order.getPaymentFee() + order.getShippingFee())%>元 </td>
                    </tr>
                </tbody>
            </table>
            <br><br>
            <table style="width: 70%;margin: auto">
                <thead>
                    <tr>
                        <th>付款方式</th>
                        <th>手續費</th>
                        <th>備註</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= order.getPaymentType()%></td>
                        <td><%= order.getPaymentFee()%>元
                            <% if(order.getStatus()==0 && order.getPaymentType()==PaymentType.ATM){%>
                            <a href="paid.jsp?orderId=<%= order.getId() %>">通知已轉帳</a><%}%></td>
                        <td><%= order.getPaymentNote() == null ? "" : order.getPaymentNote()%></td>
                    </tr>
                </tbody>
            </table>
            <br><br>
            <table style="width: 70%;margin: auto">
                <thead>
                    <tr>
                        <th>貨運方式</th>
                        <th>手續費</th>
                        <th>備註</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= order.getShippingType()%></td>
                        <td><%= order.getShippingFee()%>元</td>
                        <td><%= order.getShippingNote() == null ? "" : order.getShippingNote()%></td>
                    </tr>
                </tbody>
            </table>
            <br><br>
            <table style="width: 70%;margin: auto">
                <thead>
                    <tr>
                        <th>訂單明細</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (OrderItem item : order.getOrderItemSet()) {%>
                    <tr>
                        <td>訂單編號：<%= item.getOrderId() %>,
                      <%= item.getProduct()%>  數量：<%= item.getQuantity() %></td>
                        
                    </tr>
                    <%}%>
                </tbody>
            </table>
            <br><br>
            <table style="width: 70%;margin: auto">
                <thead>
                    <tr>
                        <th>收件人姓名</th>
                        <th>收件人Email</th>
                        <th>收件人電話</th>
                        <th>收件地址</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= order.getReceiverName()%></td>
                        <td><%= order.getReceiverEmail()%></td>
                        <td><%= order.getReceiverPhone()%></td>
                        <td><%= order.getReceiverAddress()%></td>
                    </tr>
                </tbody>
            </table>
            <% } else {%>
            <p>查無此訂單</p>
            <%}%>
        </div>

        <!--include footer.jsp(聯絡資訊等)-->
        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
