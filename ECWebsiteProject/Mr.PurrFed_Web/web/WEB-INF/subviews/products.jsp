<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/subviews/header.jsp"/>
<link href="<%= request.getContextPath()%>/fancybox/jquery.fancybox.css" rel="stylesheet" type="text/css"/>
<script src="<%= request.getContextPath()%>/fancybox/jquery.fancybox.js"></script>
<%
    Object obj = session.getAttribute("member");
    Customer member = null;
    if (obj instanceof Customer) {
        member = (Customer) obj;
    }
%>

<style>
    .direct{
        margin:0px 220px;        
        max-height: 280px;
        overflow: hidden;
        width: 100%;
        display: inline-table;
    }
    .directImg{
        padding: 10px;

    }
    .directImg:hover{
        background: rgba(255,255,255,0.7);
    }
    .product_outer{
        margin: auto;
        overflow: hidden;
        display: inline-block;  
        max-height: 280px;

    }
    .product_inner{
        margin: auto;

        max-height: 280px;

    }
    .directLeft{
        margin-top: -350px;
        margin-right: 0px;

    }
    .directRight{
        margin-top: -350px;
        margin-left: 0px;

    }
    .item{
        width:200px;
        height:180px;
        display: inline-table;
        margin-left:20px;
        margin-bottom: 20px;

    }
    .item a{
        font-size: 16px;
        color:gray;
        padding:5px;
        text-align:center
    }

    .item p{
        color:darkred;
        font-size:14px;
        text-align:center
    }
    .product_content_frozen a:hover,.item a:hover{
        background: none;
    }
</style>

<!--主頁照片-->
<section  class="homepage_pic">

    <div style="margin-left: 10px;padding: 5px;float: left; background: lightyellow;opacity: 0.8;font-size: 18px">
        您好,<%= member != null ? member.getName() : ""%>歡迎光臨!
    </div>
</section>
<!--產品圖(冷凍+常溫)--> 
<%--呼叫商業邏輯ProductService 並將category是frozen及normal的商品陣列存放進變數中--%>
<%
    ProductService service = new ProductService();
    List<Product> frozen = service.searchProductsByCategory("frozen");
    List<Product> normal = service.searchProductsByCategory("normal");
    if (frozen != null && frozen.size() > 0) {
%>
<script>
    var product_inner;
    var product_outer;
    var direct;
    var itemNum = <%= normal != null ? normal.size() : 0%>;
    var itemWidth = 200;
    var pageSize = 6;
    var marginL = 20;
    var pageNum = Math.ceil(itemNum / pageSize);
    var counter = 0;

    $(init);
    function init() {
        var product_inner = $(".product_inner");
        var product_outer = $(".product_outer");
        var direct = $(".direct");
    <%for (Product p : normal) {%>
        var htmlStr = "<div class='item'>" +
                "<a href='product.jsp?productId=<%= p.getId()%>'><img src='<%= p.getPhotoURL()%>' style='width:180px; height: 170px;margin:auto;display:block'></a>" +
                "<p style=''><a style='color:grey'href='product.jsp?productId=<%= p.getId()%>'><%= p.getName()%></a></p>" +
                "<p style=''>優惠價:<%= p instanceof Outlet ? ((Outlet) p).getDiscountString() + ',' : ""%> <%= p.getUnitPrice()%>元</p>" +
                "</div>";
        product_inner.append(htmlStr);
    <%}%>
        product_inner.width(itemWidth * itemNum + 80);
        product_outer.width((itemWidth + marginL) * pageSize + marginL);
        direct.width(itemWidth * pageSize + 120 * 2 + marginL * (itemNum + 1));

        $(".directImg").click(directHandler);
    }

    function directHandler() {
//        alert("click");
        var direct = Number($(this).attr("direct"));
        counter += direct;
        if (-pageNum < counter && counter <= 0) {
            var marginLeft = pageSize * counter * (itemWidth + marginL);
            $(".product_inner").animate({marginLeft: marginLeft + "px"}, 200);
        }
        if (counter == -pageNum)
            counter = -pageNum + 1;
        if (counter == 1)
            counter = 0;
        console.log(counter + " " + -pageNum);
    }

    function goshoppingF() {
        location.href = "products_list.jsp?category=frozen";
    }
    function goshoppingN() {
        location.href = "products_list.jsp?category=normal";
    }
</script>
<%-- 利用for迴圈將category:frozen商品陣列讀出來--%>
<section class="product">



    <p style="padding-top: 20px;margin-left: 20px;font-size: 25px">冷凍鮮食 <a href="products_list.jsp?category=frozen" style="font-size: 16px;color:lightslategray ">查看更多>></a></p>
    <div  class="product_content_frozen" style="margin-left:265px;padding-bottom: 30px ">

        <% for (Product p : frozen) {%>
        <li style="display: inline-table;text-align: center;padding-left: 20px;width: 200px">
            <a href="product.jsp?productId=<%= p.getId()%>"><img src="<%= p.getPhotoURL()%>"style="width:180px; height: 170px;"></a>
            <a href="product.jsp?productId=<%= p.getId()%>"><p style="color:gray;font-size: 16px ;margin-top: 10px"><%= p.getName()%></p></a>
            <p style="color:darkred;font-size: 14px; ">優惠價:<%= p instanceof Outlet ? ((Outlet) p).getDiscountString() + "," : ""%>
                <%= p.getUnitPrice()%>元</p>
        </li>
        <%}%>

        <%}%>
    </div>
    <hr>
    <p style="margin-left: 20px;font-size: 25px">常溫鮮食  <a href="products_list.jsp?category=normal" style="font-size: 16px;color:lightslategray ">查看更多>></a></p>
    <div class="direct" style="padding-bottom: 30px">        
        <img src="<%= request.getContextPath()%>/images/left_arrow.png" class="directImg directLeft" direct="1"  >
        <div class="product_outer" style="">            
            <div class="product_inner" >
            </div>            
        </div>
        <img src="<%= request.getContextPath()%>/images/right_arrow.png" class="directImg directRight" direct="-1">
    </div>
</section>
<!--廣告宣傳圖-->
<section class="picture_ad">

</section> 
