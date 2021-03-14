
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.Outlet"%>
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
        <style>
            #products_description{
                margin:auto;
                padding: 20px 50px;
                font-size: 18px;


            }
            #products_description img{
                padding: 20px 50px;
                display: inline-table;
                max-height: 200px;
                max-width: 80%;

            }
        </style>
    </head>
    <body>
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <%
            }
            String productId = request.getParameter("productId");
            Product p = null;
            if (productId != null && productId.matches("\\d+")) {
                ProductService service = new ProductService();
                p = service.getProductById(Integer.parseInt(productId));
            }
        %>
        <div class="article" style="width: 100%;display: block;min-height: 1000px;margin:60px 0px">
            <%
                if (p != null) {
            %>
            <div style="width: 20%;display: inline-table;float: left;padding-left: 80px;">
                <img src="<%= p.getPhotoURL()%>" style="width:250px;float:left">
            </div>

            <div style="width:45%;display: inline-table;padding-left: 50px;float: left;">
                <p style="font-size: 24px;font-weight: 600;"><%= p.getName()%></p>
                <% if (p instanceof Outlet) {%>
                <p style="text-decoration: line-through">
                    定價:<%= ((Outlet) p).getListPrice()%>元
                </p>
                <%}%>

                <p style="font-weight: bold;color:darkred;font-size: 16px">
                    優惠價:<%= p instanceof Outlet ? ((Outlet) p).getDiscountString() + "," : ""%> 
                    <%=p.getUnitPrice()%>元
                </p>

                <form id="orderForm" action="<%= request.getContextPath()%>/add_cart.do" method="POST">
                    <label style="padding-bottom: 10px;font-size: 16px" for="quantity">數量:</label>
                    <input type="number" value="1" name="quantity" id="quantity" max="<%= p.getStock()%>" required >
                    <!--Hidden Input 偷偷將商品編號包在request中傳到後端-->
                    <input type="hidden" name="productId" value="<%= p.getId()%>">
                    <!--購物車圖不是button 故自己扣javascript的submit-->
                    <a href="javascript:addCart()" >
                        <div onclick="showSnackbox()"class="product_cart"style="height: 40px;width: 220px;background:#efdbd4;padding: 2px 5px">
                            <p style="margin-left:60px;margin-top:5px;color: black;font-size: 16px;display: inline-table;">加入購物車</p>
                            <img style=" height: 20px;width: 20px;text-align: center;display: inline-table"
                                 src ="images/cart.png" >
                        </div>
                    </a>
                    <br>
                    <span id="quantityError" style="color: darksalmon;font-size: 16px;background-color: lightgoldenrodyellow"></span>
                </form>
            </div>
            <jsp:include page="/WEB-INF/subviews/snackbar.jsp"/>
            <div style="clear:both;margin: auto">
                <br>
                <hr>
                <div style="margin:auto;padding: 20px 50px;font-size: 18px"><%= p.getDescription()%></div>
            </div>
        </div>

        <%} else {%>
        <p>查無商品</p>
        <%}%>
    </div>
    <% if (!isAjax) { %>
    <!--include footer.jsp(聯絡資訊等)-->
    <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
</body>
</html>
<%}%>
<script>
    function validateForm() {
        var q = parseInt($("#quantity").val());
        if (q < 1 || q > parseInt($("#qunatity").attr('max'))) {
            $("#quantityError").html("購買數量必須位在1~" + $("#quantity").attr('max') + "個之間");
            return false;
        }
        return true;
    }

    function addCart() {

        if (validateForm()) {
            $.ajax({
                url: $("#orderForm").attr("action"),
                method: 'POST',
                data: $("#orderForm").serialize()
            }).done(addCartDoneHandler);
        }
    }
    function addCartDoneHandler(result) {
        $("#cartSize").text(result);
    }
    $("input[type=number]").keypress(function (event) {
        event.preventDefault();
    });

</script>
