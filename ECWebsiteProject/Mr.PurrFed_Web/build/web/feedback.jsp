<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
    String ajax = request.getParameter("ajax");
    boolean isAjax = ajax != null && ajax.equalsIgnoreCase("true");
    if (isAjax) {
%>
<!DOCTYPE html>
<html>
    <head>
     

        <style>
            #feedbackFormFancy .headline{
                text-align: center;
                color: black;
                font-weight: 600;
                background:#efdbd4 ;
                letter-spacing: 3px;
                font-size: 24px;
                padding: 2px 5px;
                margin-top: 15px;
            }


        </style>
    </head>
    <body>

        <%
            Object obj = request.getAttribute("errors");
            List<String> errors = null;
            if (obj instanceof List) {//泛型檢查時無法檢查到元素
                errors = (List<String>) obj;//但轉型時可以轉
            }
        %>
        <!---------------Feedback表單-------------------->
        <div id="feedbackFormFancy" >
            <p class="headline" style="">聯絡我們</p>
            <div id="" style="text-align: center">
                <form action="<%= request.getContextPath()%>/send_mail.do" method="POST">
                    <br>
                    <p><%= errors != null ? errors : ""%></p>
                    <input style="width: 70%; height: 30px;letter-spacing: 2px"
                           type="text" name="email" id="email" placeholder="聯絡信箱 Email" required >
                    <br> <br>
                    <input type="text" style="width: 70%; height: 30px;letter-spacing: 2px"
                           name="name" id="name" placeholder="名字 Name" required >
                    <br> <br>
                    <textarea  name="text"placeholder="想對我們說..." style="width: 70%; height: 60px;letter-spacing: 2px" required></textarea>
                    <br> <br>
                    <input id="sendFeedbackBtn"type="submit"  style="border: none; height: 30px;width: 40%;background:#efdbd4;
                           color: black;letter-spacing: 3px;font-size: 16px"
                           value="確認送出">
                </form>
            </div>
        </div> 


    </body>
</html>
<%}%>

