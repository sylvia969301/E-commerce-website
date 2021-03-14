
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
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
        <script>
            function isValidForm() {
                var password = document.getElementById("password");
                console.log(password.value.length = 6);
                return password.value.length >= 6;

            }
            function refreshCaptcha() {
                var captchaImg = document.getElementById("captchaImg");
                captchaImg.src = "images/register_captcha.jpg?refresh=" + new Date();
            }
        </script>
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
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <!--註冊表單-->

        <div class="registerForm" >
            <p style="text-align: center;color: white">會員註冊</p>
            <div class="registerContent" >
                <form action="<%= request.getContextPath()%>/register.do" method="POST" >
                    <ul style="list-style: none;padding-bottom: 10px">

                        <li><%= errors != null ? errors : ""%></li>
                        <li>

                            <input type="text" id="email" name="email" 
                                   required placeholder="信箱 Email" value="${param.email}">
                        </li>
                        <li>

                            <input type="password" id="password" name="password" 
                                   required placeholder="密碼 Password">
                        </li>
                        <li>

                            <input type="password" id="passwordCheck" name="passwordCheck" 
                                   required placeholder="確認密碼 Password Check">
                        </li>
                        <li>

                            <input type="text" id="name" name="name" 
                                   required placeholder="姓名 Name">
                        </li>
                        <li>

                            <input type="tel" id="phone" name="phone" 
                                   required placeholder="手機號碼 Phone">
                        </li>
                        <li id="FM" style="font-size: 12px">
                            <div>
                                <input type="radio" id="male" name="gender" required value="M">
                                <label style="" for="male">男</label>
                                <input type="radio" id="female" name="gender" required value="F">
                                <label for="female">女</label>
                            </div>

                        </li>
                        <p style="margin-top: 20px;">
                            <label for="birthday">生日:</label><br>
                            <input type="date" id="birthday" name="birthday" required>
                        </p>
                        <li>

                            <input type="text" id="address" name="address" placeholder="地址 Address">
                        </li>
                        <li>

                            <input type="text" id="captchaImg" name="captcha" 
                                   required placeholder="驗證碼 Captcha">
                        </li>
                        <p style="margin-top: 10px">
                            <img src="images/register_captcha.jpg" style="">
                            <a style="width: 8px" href="javascript:refreshCaptcha()" title="點選圖案即可更新驗證碼">
                                <img src="images/refresh.png" alt="點選即可更新驗證碼" style="vertical-align: middle;width:15px;height:15px">
                            </a>
                        </p>
                        <input style="margin: auto;padding: 2px 0px;line-height: 28px;border: 0;background:#d1ab9e;text-decoration: none;font-size: 12px ;width: 100px" type="submit" value="註冊">
                    </ul>
                </form>
            </div>
        </div>
        <!--include footer.jsp(聯絡資訊等)-->
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
                captchaImg.src = "images/register_captcha.jpg?refresh=" + new Date();
            }
        </script>
        <style>
            #registerFormFancy .headline{
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
        <!--註冊表單-->
        <div id="registerFormFancy" >
            <p class="headline" style="">會員註冊</p>
            <div class="" >
                <form action="<%= request.getContextPath()%>/register.do" method="POST" >
                    <ul style="list-style: none;padding-bottom: 10px">

                        <li><%= errors != null ? errors : ""%></li>
                        <li>
                            <input type="text" id="email" name="email" 
                                   style="width: 80%; height: 30px;letter-spacing: 2px;margin: 10px 20px"
                                   required placeholder="信箱 Email" value="${param.email}">
                        </li>
                        <li>
                            <input type="password" id="password" name="password" 
                                   style="width: 80%; height: 30px;letter-spacing: 2px;margin: 10px 20px"
                                   required placeholder="密碼 Password">
                        </li>
                        <li>
                            <input type="password" id="passwordCheck" name="passwordCheck" 
                                   style="width: 80%; height: 30px;letter-spacing: 2px;margin: 10px 20px"
                                   required placeholder="確認密碼 Password Check">
                        </li>
                        <li>
                            <input type="text" id="name" name="name" 
                                   style="width: 80%; height: 30px;letter-spacing: 2px;margin: 10px 20px"
                                   required placeholder="姓名 Name">
                        </li>
                        <li>
                            <input type="tel" id="phone" name="phone" 
                                   style="width: 80%; height: 30px;letter-spacing: 2px;margin: 10px 20px"
                                   required placeholder="手機號碼 Phone">
                        </li>
                        <li id="FM" style="font-size: 14px">
                            <div style="letter-spacing: 2px;margin: 5px 20px">
                                <input type="radio" id="male" name="gender" 
                                       style=""required value="M">
                                <label style="" for="male">男</label>
                                <input type="radio" id="female" name="gender" 
                                       required value="F">
                                <label style=""for="female">女</label>
                            </div>
                        </li>
                      
                        <label style="letter-spacing: 2px;margin: 2px 20px 0px 20px;"
                               for="birthday">生日:</label><br>
                            <input type="date" id="birthday" name="birthday" 
                                   style="width: 80%; height: 30px;letter-spacing: 2px;margin: 2px 20px 10px 20px"required>
                     
                        <li>
                            <input type="text" id="address" name="address" 
                                   style="width: 80%; height: 30px;letter-spacing: 2px;margin: 10px 20px"placeholder="地址 Address">
                        </li>
                        <li>
                            <input type="text"  name="captcha" 
                                   style="width: 80%; height: 30px;letter-spacing: 2px;margin: 10px 20px"
                                   required placeholder="驗證碼 Captcha">
                        </li>
                        
                            <img id="captchaImg"src="images/register_captcha.jpg" style="vertical-align: middle;margin: 15px 5px 15px 110px">
                            <a style="width: 8px" href="javascript:refreshCaptcha()" title="點選圖案即可更新驗證碼">
                                <img src="images/refresh.png" alt="點選即可更新驗證碼" style="width:15px;height:15px">
                            </a>
                       
                        <input  style="border: none; height: 30px;width: 40%;background:#efdbd4;
                                color: black;letter-spacing: 3px;font-size: 16px;margin: 10px 100px"
                                type="submit" value="註冊">
                    </ul>
                </form>
            </div>
        </div>
    </body>
</html>
<%}%>