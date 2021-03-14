

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ajax = request.getParameter("ajax");
    boolean isAjax = ajax != null && ajax.equalsIgnoreCase("true");
    if (!isAjax) {
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
        <script>
            function isValidForm() {
                var password = document.getElementById("password");
                console.log(password.value.length = 6);
                return password.value.length >= 6;

            }
            function refreshCaptcha() {
                var captchaImg = document.getElementById("captchaImg");
                captchaImg.src = "images/captcha.jpg?refresh=" + new Date();
            }
        </script>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <%
            Object obj = request.getAttribute("errors");
            List<String> errors = null;
            if (obj instanceof List) {//泛型檢查時無法檢查到元素
                errors = (List<String>) obj;//但轉型時可以轉
            }

            //從cookie中讀取資料(Cookie為陣列,利用for迴圈讀出來)
            Cookie[] cookies = request.getCookies();
            String email = "";
            String auto = "";
            if (cookies != null && cookies.length > 0) {
                for (Cookie cookie : cookies) {
                    if ("email".equals(cookie.getName())) {
                        email = cookie.getValue();
                    } else if ("auto".equals(cookie.getName())) {
                        auto = cookie.getValue();
                    }
                }
            }
        %>

        <!--會員登入表單-->
        <div id="loginForm" >
            <p style="text-align: center;color: white;font-size: 30px;background: rgba(0,0,0,0.3);width: 50%;margin: auto">會員登入</p>
            <div id="loginContent">
                <!--TODO jsp param subtitle:會員登入-->

                <form action="<%= request.getContextPath()%>/login.do" method="POST">
                    <br>
                    <p><%= errors != null ? errors : ""%></p>


                    <input type="text" name="email" id="email"value="${param.email}" placeholder="會員信箱 Email" required >
                    <br>
                    <input type="checkbox" name="auto" id="auto" <%= auto%>>
                    <label for="auto">記住我的帳號</label>
                    <br>

                    <input type="password" name="password" id="password" placeholder="密碼 Password" required >
                    <br><br>

                    <input type="text" name="captcha" id="captcha" placeholder="驗證碼 Captcha 不分大小寫" >
                    <br>
                    <img  src="images/captcha.jpg" alt="驗證碼" style="vertical-align: middle" id="captchaImg">
                    <a href="javascript:refreshCaptcha()" title="點選圖案即可更新驗證碼">
                        <img src="images/refresh.png" alt="點選即可更新驗證碼" style="vertical-align: middle;width:15px;height:15px">
                    </a>
                    
                    <br><br>
                    <input type="submit" value="登入">
                </form>
            </div>
        </div> 

        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>

    </body>
</html>
<%} else {%> 
<!-- ------------------------------若isAjax ==true----------------------------->

<html>
    <head>
   
        <script>
            function isValidForm() {
                var password = document.getElementById("password");
                console.log(password.value.length = 6);
                return password.value.length >= 6;

            }
            function refreshCaptcha() {
                var captchaImg = document.getElementById("captchaImg");
                captchaImg.src = "images/captcha.jpg?refresh=" + new Date();
            }
        </script>
        <style>
            #loginFormFancy .headline{
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
            //從cookie中讀取資料(Cookie為陣列,利用for迴圈讀出來)
            Cookie[] cookies = request.getCookies();
            String email = "";
            String auto = "";
            if (cookies != null && cookies.length > 0) {
                for (Cookie cookie : cookies) {
                    if ("email".equals(cookie.getName())) {
                        email = cookie.getValue();
                    } else if ("auto".equals(cookie.getName())) {
                        auto = cookie.getValue();
                    }
                }
            }
        %>

        <!--會員登入表單-->
        <div id="loginFormFancy" >
            <p class="headline" style="">會員登入</p>
            <div id="" style="text-align: center">
                <form action="<%= request.getContextPath()%>/login.do" method="POST">
                    <br>
                    <p><%= errors != null ? errors : ""%></p>
                    <input style="width: 70%; height: 30px;letter-spacing: 2px"
                        type="text" name="email" id="email"value="${param.email}" placeholder="會員信箱 Email" required >
                    <br>
                    <input type="checkbox" style="margin: 5px 0px"
                           name="auto" id="auto" <%= auto%>>
                    <label for="auto">記住我的帳號</label>
                    <br>

                    <input type="password" style="width: 70%; height: 30px;letter-spacing: 2px"
                           name="password" id="password" placeholder="密碼 Password" required >
                    <br><br>

                    <input type="text" style="width: 70%; height: 30px;letter-spacing: 2px"
                           name="captcha" id="captcha" placeholder="驗證碼 Captcha 不分大小寫" >
                    <br>
                    <img  src="images/captcha.jpg" alt="驗證碼" style="vertical-align: middle;margin: 15px 0px" id="captchaImg">
                    <a href="javascript:refreshCaptcha()" title="點選圖案即可更新驗證碼">
                        <img src="images/refresh.png" alt="點選即可更新驗證碼" style="vertical-align: middle;width:15px;height:15px">
                    </a>
                    <br><br>
                    <input id="loginFancyBtn"type="submit"  style="border: none; height: 30px;width: 40%;background:#efdbd4;
                           color: black;letter-spacing: 3px;font-size: 16px"
                           value="登入">
                </form>
            </div>
        </div> 


    </body>
</html>
<%}%>