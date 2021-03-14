<%-- 
    Document   : error
    Created on : 2018/8/20, 下午 04:00:46
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>error page</title>
        <script>
            function displayError() {
                var details = document.getElementById("details");
                if (details.style.display != "block") {
                    details.style.display = "block";
                } else {
                    details.style.display = "none";
                }
            }
        </script>
    </head>
    <body>
        <h2>系統發生錯誤</h2>
        <% if (exception != null) {%>
        <p><%= exception%></p>
        <a href="javascript:displayError()">顯示錯誤明細</a>
        <% this.log("系統發生JSP錯誤", exception);%>
        <div style="font-size: 14px; display:none" id="details">
            <% exception.printStackTrace(new java.io.PrintWriter(out)); %>
        </div>
        <% }%>
    </body>
</html>
