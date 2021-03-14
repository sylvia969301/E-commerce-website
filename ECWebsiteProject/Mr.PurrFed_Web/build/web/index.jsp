
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
        
        <!--include products.jsp(主頁照片+整個products頁面)-->
       <jsp:include page="/WEB-INF/subviews/products.jsp"/>
        <!--include footer.jsp(聯絡資訊等)-->
       <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
