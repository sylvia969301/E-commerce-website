
<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="uuu.vgb.entity.VIP"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <%----%>
                function refreshCaptcha() {
                 var captchaImg = document.getElementById("captchaImg");
                 captchaImg.src = "<%= request.getContextPath()%>/images/register_captcha.jpg?refresh=" + new Date();
             }
        </script>
    </head>
    <body>
        <%
            Customer member = (Customer) session.getAttribute("member");

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
        <div class="registerForm" >
            <h3 style="text-align: center;color: white">會員修改資料</h3>
            <div class="registerContent" >
                <form action="<%= request.getContextPath()%>/update.do" method="POST" >
                    <p><%= errors != null ? errors : ""%></p>
                    <p>
                        <label>信箱:</label>
                        <input type="text" id="email" name="email" 
                               required placeholder="請輸入信箱" 
                               value="${empty param.email? sessionScope.member.getEmail():param.email}">
                        <%if (member instanceof VIP) {%><!--disabled只能看 不能給使用者作修改-->
                        <input type="checkbox" checked disabled><label>VIP,享有專屬折扣:</label><input type="text" disabled value="<%= ((VIP) member).getDiscountString()%>">
                        <%}%>
                    </p><br>
                    <p>
                        <label for="previousPassword">舊密碼:</label>
                        <input type="password" id="previousPassword" name="previousPassword" 
                               required placeholder="請輸入舊密碼">
                    </p><br>
                    <p>
                        <label for="password">新密碼:</label>
                        <input type="password" id="password" name="password" 
                               required placeholder="請輸入新密碼">
                    </p><br>
                    <p>
                        <label for="passwordCheck">確認密碼:</label>
                        <input type="password" id="passwordCheck" name="passwordCheck" 
                               required placeholder="請確認密碼">
                    </p><br>
                    <p>
                        <label for="name">姓名:</label>
                        <input type="text" id="name" name="name" 
                               required placeholder="請輸入姓名">
                    </p><br>
                    <p>
                        <label for="phone" >手機號碼:</label>
                        <input type="tel" id="phone" name="phone" 
                               required placeholder="請輸入手機號碼">
                    </p><br>
                    <p>
                        <label for="gender">性別:</label>
                        <input type="radio" id="male" name="gender" required value="M">
                        <label for="male">男</label>
                        <input type="radio" id="female" name="gender" required value="F">
                        <label for="female">女</label>
                    </p><br>
                    <p>
                        <label for="birthday">生日:</label>
                        <input type="date" id="birthday" name="birthday" required>
                    </p><br>
                    <p>
                        <label for="address" >地址:</label>
                        <input type="text" id="address" name="address" placeholder="請輸入地址">
                    </p><br>
                    <p>
                        <label for="captcha">驗證碼:</label>
                        <input type="text" id="captcha" name="captcha" 
                               required placeholder="請輸入驗證碼">
                        <br>
                        <img src="<%= request.getContextPath()%>/images/register_captcha.jpg" style="vertical-align: middle" id="captchaImg" name="captchaImg" >
                        <a href="javascript:refreshCaptcha()" title="點選圖案即可更新驗證碼">
                            <img src="<%= request.getContextPath()%>/images/refresh.png" alt="點選即可更新驗證碼" style="vertical-align: middle;width:15px;height:15px">
                        </a>
                    </p>
                    <input type="submit" value="確認修改">
                </form>
            </div>
        </div>


        <!--include footer.jsp(聯絡資訊等)-->
        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
