
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <%@include file="/WEB-INF/subviews/global.jsp" %>
        <style>
            .article{
                min-height: 600px;
                background-image: url(images/show404.png);
                background-repeat: no-repeat;
                background-position: center;
               
            }
        </style>
    </head>
    <body>
        <!--include header.jsp(navBar等主要介面)-->
        <%@include file="/WEB-INF/subviews/header.jsp" %>
        <div class="article">


        </div>

        <!--include footer.jsp(聯絡資訊等)-->
        <%@include file="/WEB-INF/subviews/footer.jsp" %>
    </body>
</html>
