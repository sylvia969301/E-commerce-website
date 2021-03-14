
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
            Object obj = request.getAttribute("customer");
            Customer c = null;
            if (obj instanceof Customer) {
                c = (Customer) obj;
            }
        %>
        <div style="min-height: 200px;text-align: center;margin:200px;padding:60px;background-color: lightgoldenrodyellow">
            <h3 style="">註冊成功, <%= c.getName()%>您好!</h3>
            <a href="<%= request.getContextPath() %>"><input type="button" class="button" value="返回首頁"></a>
        </div>
        <!--include footer.jsp(聯絡資訊等)-->
       <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
