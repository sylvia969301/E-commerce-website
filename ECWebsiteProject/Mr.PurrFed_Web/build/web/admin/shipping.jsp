
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <%@include file="/WEB-INF/subviews/global.jsp" %>
    </head>
    <body>
        <!--include header.jsp(navBar等主要介面)-->
       <jsp:include page="/WEB-INF/subviews/header.jsp"/>
       <h4>出貨作業</h4>
        


        <!--include footer.jsp(聯絡資訊等)-->
        <%@include file="/WEB-INF/subviews/footer.jsp" %>
    </body>
</html>
