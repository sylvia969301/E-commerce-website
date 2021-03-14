
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
        <link href="<%= request.getContextPath()%>/fancybox/jquery.fancybox.css" rel="stylesheet" type="text/css"/>
        <script src="<%= request.getContextPath()%>/fancybox/jquery.fancybox.js"></script>
        <style>
            body{
/*                background: wheat;*/
            }
        </style>
        <script>
            function getDefaultImage(thisImg) {
                //alert(thisImg);
                thisImg.src = "";
            }
            function getProduct(pid) {
                /*同步GET請求
                 location.href='product.jsp?productId='+pid;*/

//                //非同步GET請求:利用jquery中的ajax<%--ajax若不給請求方式 預設為GET--%>
                $.ajax({
                    url: 'product.jsp?ajax=true&productId=' + pid,
                    method: 'GET'
                }).done(getProductDoneHandler);
            }
            function getProductDoneHandler(result) {
              
                $("#productDetail").html(result);
                $.fancybox.open({
                    src: '#productDetail',
                    type: 'inline'
                });
            }
        </script>
    </head>
    <body>
        <h3>產品清單</h3>
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div calss="article" style="margin: 10px 150px ">
            <%//當form是POST請求且欄位中有中文,須設定CharacterEncoding
                request.setCharacterEncoding("UTF-8");

                //取得request中的產品類別:category
                ProductService service = new ProductService();
                String category = request.getParameter("category");
                String[] catArray = request.getParameterValues("cat");
                List<Product> list;

                //取得request中form的輸入資料:search
                String search = request.getParameter("search");
                if (category != null) {
                    list = service.searchProductsByCategory(category, catArray);
                } else {
                    if (search == null) {
                        search = "";
                        list = service.searchProducts(search);
                    } else {
                        list = service.searchProducts(search);
                    }
                }
            %>
            <form  style="text-align: center;padding: 10px" method="GET">
                <input type="search" name="search" style="min-width: 25em;width:50%;margin-top: 10px;box-shadow: none" placeholder="請輸入商品名稱">
                <input type="submit" value="查詢" style="border:none;background: lightgray;color: black;padding: 5px 10px">
            </form>
            <%
                if (list != null && list.size() > 0) {
            %>
            <ul style="text-align: center;color:#646565;text-decoration: none">
                <%for (Product p : list) {%>
                <li style="display: inline-table; width:200px ; min-height: 20vh">
                    <a href="javascript:getProduct('<%=p.getId()%>')"><img src="<%= p.getPhotoURL()%>"style="width:180px; height: 180px;margin: 0px;" onerror="getDefaultImage(this)" id="photoURL<%= p.getId()%>" ></a>
                    <!--取得product id 利用id讀取商品的頁面-->
                    <a href="javascript:getProduct('<%=p.getId()%>')"><h4 style="color:#6c6c6c;text-decoration: none;font-size: 16px;font-weight:400"><%= p.getName()%></h4></a>
                    <p style="font-size: 14px;color: darkred">優惠價 : <%= p instanceof Outlet ? ((Outlet) p).getDiscountString() + ", " : ""%><%=p.getUnitPrice()%>元</p>
                   
                </li>
                <% } %>
            </ul>
            <%  } else {%>
            <div style="min-height: 400px">
                <p style="margin-top: auto;text-align: center;font-size: 20px;background-color: lightcoral;
                   color: white">查無產品!</p>
            </div>
            <% }%>
        </div>
        <div style="width:60%;height: 600px" id="productDetail"></div>
        <!--include footer.jsp(聯絡資訊等)-->
        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
