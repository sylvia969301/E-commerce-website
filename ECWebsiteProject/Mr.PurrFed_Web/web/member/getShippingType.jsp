
<%@page import="java.io.Console"%>
<%@page import="uuu.vgb.entity.ShippingType"%>
<%@page import="uuu.vgb.entity.PaymentType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--動態產生和付款方式對應的運送方式-->
<option value="">請選擇...</option>
<%
    String pType = request.getParameter("pType");
    this.log("pType="+pType);
    if (pType != null) {
        try {
            PaymentType paymentType = PaymentType.valueOf(pType);
            for (ShippingType shType : paymentType.getShippingTypeArray()) {

%>
<option value="<%= shType.name()%>"><%= shType%></option>
<%      }
        } catch (Exception ex) {
            this.log("結帳時付款方式的資料不正確");

        }
    }

%>