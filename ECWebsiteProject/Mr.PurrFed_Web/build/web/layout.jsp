
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Ms.Purr-fed</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/myPage.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script
            src="https://code.jquery.com/jquery-1.12.4.js"
            integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU="
        crossorigin="anonymous"></script>
        <script src="js/myPage.js" type="text/javascript"></script>
    </head>
    <body>

        <header  class="level1">

            <!--完整navBar -->
            <div id="navBar">
                <!--Logo-->
                <div id ="logoContainer">
                    <img  id="pic" src="images/logo.png" alt="logo">
                </div>
                <!--左menu:商品選項-->
                <nav  id="leftNav" >
                    <div>
                        <ul >
                            <li><a href="#冷凍鮮食">冷凍鮮食</a></li>
                            <li class="dropdown">
                                <a href="#" class="">鮮食好物</a>
                                <div class="dropdown-content">
                                    <a href="#">好味食譜書</a>
                                    <a href="#">鮮食調味料</a>
                                    <a href="#">好味貓補丁</a>
                                    <a href="#">好味消化餅</a>
                                    <a href="#">好味貓補丁</a>
                                    <a href="#">貓選油品</a>
                                    <a href="#">無香料貓皂</a>
                                    <a href="#">好抓抓星球</a>
                                </div>
                            </li>
                            <li><a href="#超值組合">超值組合</a></li>
                            <li><a href="#所有商品">所有商品</a></li>
                            <li><a href="#常見Q&A">常見Q&A</a></li>
                        </ul>
                    </div>

                </nav>
                <!--右menu:icons群-->
                <nav id="rightNav" >
                    <div>
                        <ul >
                            <li><a href="#聯絡我們"><img src="images/mail.png" alt="聯絡我們" style="vertical-align: middle;width:17px;height:20px"/></a></li>
                            <li><a href="#關鍵字查詢商品"> <img src="images/search.png" alt="關鍵字查詢商品" style="vertical-align: middle;width:18px;height:18px"/></a></li>
                            <li><a href=""><img src="images/home.png" alt="會員登入" style="vertical-align: middle;width:20px;height:20px"/></a></li>
                            <li><a href="register.html"><img src="images/member.png" alt="會員註冊" style="vertical-align: middle;width:20px;height:20px"/></a></li>
                            <li id="cartBtn"><a href="#購物車"><img src="images/shopping_cart.png" alt="購物車" style="vertical-align: middle;width:18px;height:20px"/></a></li>
                        </ul>
                    </div>
                </nav>
            </div>

        </header>
        <!--會員登入視窗-->
        <div id="loginForm" >
            <div id="loginContent">
                <form ><input type="button" value="X" id="close"><br>
                    <label for="email">信箱:</label>
                    <input type="text" name="email" id="email" placeholder="請輸入會員信箱" required >
                    <br>
                    <label for="password">密碼:</label>
                    <input type="password" name="password" id="password" placeholder="請輸入密碼" required >
                    <br>
                    <label for="captcha">驗證碼:</label>
                    <input type="text" name="captcha" id="captcha" placeholder="請輸入驗證碼，不分大小寫" >
                    <br>
                    <img  src="images/captcha.jpg" alt="驗證碼" style="vertical-align: middle" id="captchaImg">
                    <a href="javascript:refreshCaptcha()" title="點選圖案即可更新驗證碼">
                        <img src="images/refresh.png" alt="點選即可更新驗證碼" style="vertical-align: middle;width:15px;height:15px"></a>
                    <br>
                    <input type="submit" value="登入">
                </form>
            </div>
        </div> 

        <section class="content level1">

            <!--             購物車視窗 
                        <div class="cartNav">
                            <span class="glyphicon glyphicon-menu-right cartExit"></span>
                        </div>-->
            <section  class=" first level2">
                <img src="images/homePage03.jpg" alt=""/>

            </section>

            <section class="level2 product">second
                <figure  class="second1  level3">second1<h2>冷凍鮮食</h2></figure>
                <figure class="second2  level3">second2<h2>鮮食好物</h2></figure>
            </section>

            <section class="level2 pictureAd">third
                <div class="third level3">third<h2>picture here</h2></div>
            </section> 

            <section class="level2 customerComment">forth
                <div  class="forth level3">forth<h2>OUR HAPPY CUSTOMERS 顧客回饋</h2></div>
            </section>
        </section>
        <!--Footer-->
        <footer  class="footer level1">footer<p>聯絡我們</p>
            <p>版權所有&copy;</p>
        </footer>

    </body>
</html>
