
<%@page import="uuu.demo.service.MailService"%>
<%@page import="uuu.vgb.entity.VIP"%>
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.CartItem"%>
<%@page import="uuu.vgb.entity.Cart"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link href="<%= request.getContextPath()%>/fancybox/jquery.fancybox.css" rel="stylesheet" type="text/css"/>
<script src="<%= request.getContextPath()%>/fancybox/jquery.fancybox.js"></script>

<!--完整navBar -->

<script>
    function loginFancy() {
        $.ajax({
            url: '<%= request.getContextPath()%>/login.jsp?ajax=true',
            method: 'GET'
        }).done(getLoginFancyDoneHandler);
    }
    function getLoginFancyDoneHandler(result) {
        $("#loginDetail").html(result);
        $.fancybox.open({
            src: '#loginDetail',
            type: 'inline'
        });
    }
    function registerFancy() {
        $.ajax({
            url: '<%= request.getContextPath()%>/register.jsp?ajax=true',
            method: 'GET'
        }).done(getRegisterFancyDoneHandler);
    }
    function getRegisterFancyDoneHandler(result) {
        $("#registerDetail").html(result);
        $.fancybox.open({
            src: '#registerDetail',
            type: 'inline'
        });
    }
    function sendMailFancy() {
        $.ajax({
            url:'<%= request.getContextPath()%>/feedback.jsp?ajax=true',
            method:'GET'
        }).done(getFeedbackFancyDone);
    }
    function getFeedbackFancyDone(result){
        $("#feedbackDetail").html(result);
        $.fancybox.open({
            src:'#feedbackDetail',
            type:'inline'
        });
    }

</script>
<header  class="header">
    <style>

    </style>
    <%
        Object obj = session.getAttribute("member");
        Customer member = null;
        if (obj instanceof Customer) {
            member = (Customer) obj;
        }
        Cart cart = (Cart) session.getAttribute("cart");


    %>
    <div id="navBar">
        <!--Logo-->
        <a href="<%= request.getContextPath()%>"><div id ="logoContainer">
                <img  id="logo_pic" src="<%=request.getContextPath()%>/images/logo.png" alt="logo">
            </div></a>
        <!--左menu:商品選項-->
        <nav  id="leftNav" >
            <div>
                <ul>
                    <li class="dropdown"><a href="<%=request.getContextPath()%>/products_list.jsp?category=frozen&cat=normal&cat=seasoning">鮮食好物</a>
                        <div class="dropdown-content">
                            <a id="frozen" href="<%=request.getContextPath()%>/products_list.jsp?category=frozen"  >冷凍鮮食</a>
                            <a id="normal" href="<%=request.getContextPath()%>/products_list.jsp?category=normal">常溫鮮食</a>
                            <a id="seasoning" href="<%=request.getContextPath()%>/products_list.jsp?category=seasoning">鮮食調味料</a>
                        </div>

                    </li>    
                    <script>

                    </script>

                    <li class="dropdown">
                        <a href="<%=request.getContextPath()%>/products_list.jsp?category=recipe&cat=soap&cat=toys" class="">貓選用品</a>
                        <div class="dropdown-content">
                            <a href="<%=request.getContextPath()%>/products_list.jsp?category=recipe ">好味食譜書</a>
                            <a href="<%=request.getContextPath()%>/products_list.jsp?category=soap">無香料貓皂</a>
                            <a href="<%=request.getContextPath()%>/products_list.jsp?category=toys">貓選玩具</a>
                        </div>
                    </li>
                    <li><a href="<%= request.getContextPath()%>/products_list.jsp?search= ">所有商品</a></li>
                    <li><a href="<%= request.getContextPath()%>/QA.jsp">常見Q&A</a></li>
                </ul>
            </div>
        </nav>
        <!--右menu:icons群-->

        <nav id="rightNav" >
            <div>
                <ul >
                    <% if (member == null) {%>
                    <li id="loginBtn" class="dropdown"><a href="javascript:loginFancy()"><img src="<%=request.getContextPath()%>/images/member.png" alt="會員登入" style="vertical-align: middle;width:20px;height:20px"/></a>
                        <div class="dropdown-content">
                            <a href="javascript:loginFancy()" >會員登入</a>
                            <a href="javascript:registerFancy()">會員註冊</a>
                        </div>
                    </li>
                    <li id="contactBtn"><a href="javascript:sendMailFancy()"><img src="<%=request.getContextPath()%>/images/mail.png" alt="聯絡我們" style="vertical-align: middle;width:17px;height:20px"/></a></li>
                    <li id="searchBtn"><a href="<%= request.getContextPath()%>/products_list.jsp"> <img src="<%=request.getContextPath()%>/images/search.png" alt="關鍵字查詢商品" style="vertical-align: middle;width:18px;height:18px"/></a></li>
                    <li id="homeBtn"><a href="<%= request.getContextPath()%>"><img src="<%=request.getContextPath()%>/images/home.png" alt="首頁" style="vertical-align: middle;width:20px;height:20px"/></a></li>

                    <li id="cartBtn">
                        <a href="<%= request.getContextPath()%>/member/cart.jsp">
                            <img src="<%=request.getContextPath()%>/images/shopping_cart.png" alt="購物車" style="vertical-align: middle;width:18px;height:20px"/>
                            <%--購物車數量 非同步ajax--%>
                            <span id="cartSize">${not empty sessionScope.cart?"(":""}
                                ${not empty sessionScope.cart? sessionScope.cart.size :""}
                                ${not empty sessionScope.cart?")":""}
                            </span>
                        </a>
                    </li>
                    <% } else {%>
                    <li id="loginBtn" class="dropdown"><a href=""><img src="<%=request.getContextPath()%>/images/member.png" alt="會員登入" style="vertical-align: middle;width:20px;height:20px"/></a>
                        <div class="dropdown-content">
                            <a href="<%=request.getContextPath()%>/member/orders_history.jsp">訂單查詢</a>
                            <a href="<%=request.getContextPath()%>/member/update.jsp">修改會員</a>
                            <a href="<%=request.getContextPath()%>/logout.do">會員登出</a>
                        </div>
                    </li>
                    <li id="contactBtn"><a href="javascript:sendMailFancy()"><img src="<%=request.getContextPath()%>/images/mail.png" alt="聯絡我們" style="vertical-align: middle;width:17px;height:20px"/></a></li>
                    <li id="searchBtn"><a href="<%= request.getContextPath()%>/products_list.jsp"> <img src="<%=request.getContextPath()%>/images/search.png" alt="關鍵字查詢商品" style="vertical-align: middle;width:18px;height:18px"/></a></li>
                    <li id="homeBtn"><a href="<%= request.getContextPath()%>"><img src="<%=request.getContextPath()%>/images/home.png" alt="首頁" style="vertical-align: middle;width:20px;height:20px"/></a></li>


                    <li id="cartBtn">
                        <a href="javascript:openCartNavHandler()">
                            <img src="<%=request.getContextPath()%>/images/shopping_cart.png" alt="購物車" style="vertical-align: middle;width:18px;height:20px"/>

                            <%--購物車數量 非同步ajax--%>
                            <span id="cartSize" >${not empty sessionScope.cart?"(":""}
                                ${not empty sessionScope.cart? sessionScope.cart.size :""}
                                ${not empty sessionScope.cart?")":""}
                            </span>
                        </a>
                    </li>
                    <div class="cartNav">

                    </div>

                    <% }%>
                </ul>
            </div>
        </nav>
    </div>
    <!-----------------------FEEDBACK畫面fancyBox---------------------->
    <div  id="feedbackDetail" hidden="true"></div>
    <!-----------------------登入畫面fancyBox---------------------->
    <div  id="loginDetail" hidden="true"></div>
    <!-----------------------註冊畫面fancyBox---------------------->
    <div  id="registerDetail" hidden="true"></div>
    <script>

        function openCartNavHandler() {
            $(".cartNav").animate({right: '0px'});
            $.ajax({
                url: "<%= request.getContextPath()%>/cart_bar.jsp",
                method: 'POST'
            }).done(addCartBarHandler);
        }
        function addCartBarHandler(result) {
            console.log("購物車");
            $(".cartNav").html(result);
        }
        function closeCartNavHandler() {

            $(".cartNav").animate({right: '-360px'});

        }

        function sendMail() {

        }
    </script>

</header>
