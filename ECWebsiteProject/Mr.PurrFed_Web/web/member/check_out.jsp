<%@page import="uuu.vgb.entity.ShippingType"%>
<%@page import="uuu.vgb.entity.Order"%>
<%@page import="uuu.vgb.entity.PaymentType"%>
<%@page import="uuu.vgb.entity.Cart"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="uuu.vgb.entity.VIP"%>
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.CartItem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Customer member = (Customer) session.getAttribute("member");
    Cart cart = (Cart) session.getAttribute("cart");
    if (member != null && cart != null) {
        cart.setMember(member);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
        <script>
            /*JSON 兩層
             var paymentTypeArray=[
             {name:"ATM",ordinal:0,description:"ATN付款",fee:0,
             shippingTypeArray:[
             {name:"HOME",ordinal:0,description:"宅配到府",fee:0}
             ]}];*/
            function goShopping() {
                location.href = "<%= request.getContextPath()%>/products_list.jsp";
            }
            //付款方式做更改時觸發
            function changeHandler(pTypeSelecter, shippingVal) {
                console.log($(pTypeSelecter).val());
                var xhr = $.ajax({
                    url: "getShippingType.jsp?pType=" + $(pTypeSelecter).val()
                }).done(changeDoneHandler);
                if (shippingVal) {
                    xhr.shippingVal = shippingVal;
                }
            }
            function changeDoneHandler(result, status, xhr) {
                console.log(result);
                $("#shippingType").html(result);
                if (xhr.shippingVal) {
                    $("#shippingType").val(xhr.shippingVal);
                }
                getFee();
            }
            //當選擇了付款方式或貨運方式時，會計算出包含手續費的總金額
            function getFee() {
                var amount = parseFloat($("#amount").text());
                var pTypeValue = $("#paymentType option:selected").text();
                var pIndex = pTypeValue.indexOf(",");
                var pFee = 0;
                if ($("#paymentType").val().length > 0 && pIndex > 0) {
                    pFee = parseFloat(pTypeValue.substring(pIndex + 1, pTypeValue.length - 1));
                }
                var shTypeValue = $("#shippingType option:selected").text();
                var shIndex = shTypeValue.indexOf(",");
                var shFee = 0;
                if ($("#shippingType").val().length > 0 && shIndex > 0) {
                    shFee = parseFloat(shTypeValue.substring(shIndex + 1, shTypeValue.length - 1));
                }
                console.log(pFee, shFee);
                $("#amountWithFee").text(amount + pFee + shFee);
            }
            function copyData() {
                console.log($("#name").val());
                $("#receiverName").val($("#name").val());
                $("#receiverEmail").val($("#email").val());
                $("#receiverPhone").val($("#phone").val());
                $("#receiverAddress").val($("#address").val());
            }
            <% if (request.getParameter("paymentType") != null) { //當CheckOutSerlet發生錯誤回到此畫面時，要帶回paymentType,shippingType的值%>
            $(function () {
                $("#paymentType").val('${param.paymentType}');
                changeHandler(document.getElementById("paymentType"), '${param.shippingType}');

            });
            <% }%>
        </script>

    </head>
    <body>
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>

        <div calss="article"style="margin-top: 70px;min-height: 400px">
            <%--<p style="letter-spacing: 3px; margin-top:70px;font-size: 18px;background:#efdbd4;padding: 5px;text-align: center ">${sessionScope.member.name}的購物車</p>--%>
            <% if (cart != null && cart.getSize() > 0) {%>
            <form id="cartForm" action="check_out.do" method="GET" id="check_out_form" >
                <table style="width: 100%;min-height: 500px;text-align: center;top: 70px">
                    <caption style="text-align: center;font-weight: 400;font-size: 20px;color: gray;">訂單結帳</caption>
                    <thead>
                        <tr style="background:#efdbd4; ">
                            <th>商品照片</th>
                            <th style="text-align: center">商品名稱</th> 
                            <th>定價</th>
                            <th>折扣</th>
                            <th>售價</th>
                            <th>數量</th>
                            <th>刪除</th>  
                        </tr> 
                    </thead>

                    <tbody>

                        <% for (CartItem item : cart.getCartItemSet()) {
                            Product p = item.getProduct();
                        %>
                        <tr style="">
                            <td> <a href="javascript:getProduct('<%=p.getId()%>')"><img src="<%= p.getPhotoURL()%>"style="width:50px; height:50px;margin: 0px;" onerror="getDefaultImage(this)" id="photoURL<%= p.getId()%>" ></a></td>
                            <td><%= p.getName()%></td>
                            <td><%= p instanceof Outlet ? ((Outlet) p).getListPrice() : p.getUnitPrice()%>元</td>
                                <td><%= p instanceof Outlet ? ((Outlet) p).getDiscountString()
                                    : (cart.getMember() instanceof VIP ? ((VIP) cart.getMember()).getDiscountString() : "")%></td>

                            <td><%=p.getUnitPrice()%>元</td>
                            <td><input type="number" value="<%= cart.getQuantity(item)%>" 
                                       name="quantity_<%= p.getId()%>"></td>
                            <td><input type="checkbox" name="delete_<%= p.getId()%>" ></td>
                        </tr>

                        <%}%>
                    </tbody>
                    <tfoot >
                        <tr style="background:#f5f4f2">
                            <td colspan="5"></td>
                            <td colspan="2" style="text-align: center;font-weight: bold">共<%= cart.getSize()%>項,<%=cart.getTotalQuantity()%>件</td>
                        </tr>
                        <%if (cart.getMember() instanceof VIP) {%>
                        <tr style="background:#f5f4f2">
                            <td colspan="5" style="text-align: right">原始金額 :</td>
                            <td colspan="2"><%= cart.getTotalAmount()%>元</td>
                        </tr>
                        <tr style="background:#f5f4f2">
                            <td colspan="5" style="text-align: right">VIP折扣 :</td>
                            <td colspan="2"><%= cart.getMember() instanceof VIP ? (100 - ((VIP) cart.getMember()).getDiscount()) + "折" : "無"%></td>
                        </tr>
                        <%}%>
                        <tr style="background:#f5f4f2">
                            <td colspan="5" style="text-align: right">結帳金額 :</td>
                            <td colspan="2"><span id="amount"><%= Math.round(cart.getVIPTotalAmount())%></span>元</td>
                        </tr>

                        <tr style="border-top: 1px solid #fff;left: 60px;background: #efdbd4">
                            <td colspan="7" >
                                <span style="width: 50%;float: left;padding-top: 20px">
                                    <label style="font-size: 16px">付款方式：</label>
                                    <select name="paymentType" id="paymentType" required style="width: 15em" onchange="changeHandler(this)">
                                        <option value="">請選擇...</option>
                                        <% for (PaymentType pType : PaymentType.values()) {%>
                                        <option value="<%= pType.name()%>"><%=pType%></option>
                                        <%}%>
                                    </select>
                                </span>
                                <span style="width: 50%;float: left;padding-top: 20px">
                                    <label style="font-size: 16px">貨運方式：</label>
                                    <select id="shippingType" name="shippingType"  required style="width: 15em"
                                            onchange="getFee();
                                                    changeAddrInput();">
                                        <option value="">請選擇...</option>

                                    </select>
                                </span>
                            </td>
                        </tr>

                        <tr style="color: #aa0719;font-weight: bold;background: #efdbd4">
                            <td colspan="5" style="text-align: right ;font-size: 16px"> 總金額(含手續費) : </td>
                            <td colspan="2" style="font-size: 16px"><span id="amountWithFee"><%= Math.round(cart.getVIPTotalAmount())%></span>元</td>
                        </tr>

                        <tr style="background:#efdbd4;border-top: 1px solid white;padding-bottom: 10px">
                            <td colspan="7" style="width: 100%;padding-top:20px">
                                <fieldset style="width: 50%;float: left;border:0px;font-size: 16px;">
                                    <legend>訂貨人 :</legend>
                                    <label style="font-weight: normal;padding-bottom:5px">姓名 :  </label><input type="text" id="name" value="${sessionScope.member.name}"><br>
                                    <label style="font-weight: normal;padding-bottom:5px">信箱 : </label><input type="text" id="email" value="${sessionScope.member.email}"><br>
                                    <label style="font-weight: normal;padding-bottom:5px">手機 : </label><input type="text" id="phone" value="${sessionScope.member.phone}"><br>
                                    <label style="font-weight: normal">地址 :  </label><input type="text" id="address" value="${sessionScope.member.address}"><br>
                                </fieldset>

                                <fieldset style="width: 50%;float: left;font-size: 16px;">
                                    <legend>收件人 : <input type="button"onclick="copyData()" value="與訂貨人資料相同" style="border: 0;background:lemonchiffon;color:gray;line-height: 18px;font-size: 12px;padding: 0px 8px;font-weight: 400"></legend>
                                    <label style="font-weight: normal;padding-bottom:5px ">姓名 :  </label><input type="text" id="receiverName" value="${param.receiverName}" name="receiverName" required><br>
                                    <label style="font-weight: normal;padding-bottom:5px">信箱 :  </label><input type="text" id="receiverEmail" value="${param.receiverEmail}" name="receiverEmail" required><br>
                                    <label style="font-weight: normal;padding-bottom:5px">手機 :  </label><input type="text" id="receiverPhone" value="${param.receiverPhone}" name="receiverPhone" required><br>
                                    <label style="font-weight: normal;">地址 :  </label><input type="text" id="receiverAddress" value="${param.receiverAddress}" name="receiverAddress" required><br>
                                    <datalist id="storelist">
                                        <option value="台北市復興北路99號1樓">復北門市</option>
                                        <option value="台北市信義區忠孝東路五段68號">信義門市</option>
                                    </datalist>
                                </fieldset>

                            </td>
                        </tr>

                        <tr style="background: #efdbd4">
                            <td colspan="5" style="text-align: right;padding-top: 10px">
                                <a href="javascript:goShopping()"><input type="button" value="回賣場購物"
                                                                         style="border: 0;background: #fff;color: gray;line-height: 25px;font-size: 14px;padding: 2px 8px;letter-spacing: 2px;"></a>
                            </td>
                            <td colspan="4" style="padding-top: 10px">
                                <button type="submit" name="submit" 
                                        style="border: 0;background:  #fff;color:gray;line-height: 25px;font-size: 14px;padding: 2px 8px;letter-spacing: 2px;margin-right: 20px;">
                                    修改訂單
                                </button>
                                <input type="submit" name="submit" value="確定結帳"
                                       style="border: 0;background: #fff;color:gray;line-height: 25px;font-size: 14px;padding: 2px 8px;letter-spacing: 2px;">
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </form>
            <!-------------------------------Ezship------------------------------------>
            <script>
                var ezshipBtn = "<input type='button' id='ezship' value='選擇門市' style='width:75px;margin-left:2px' onclick='goEzShip()'>";
                function changeAddrInput() {
                    var pTypeValue = $("#paymentType").val();
                    var shTypeValue = $("#shippingType").val();
                    $("#receiverAddress").attr("readonly", false);
                    $("#receiverAddress").val("");
                    $("#receiverAddress").attr("autocomplete", "off");
                    $("#receiverAddress").attr("list", "");
                    $("#ezship").remove();
                    $("#receiverAddress").css("width", parseInt($("#receiverPhone").css("width")));
                    if (shTypeValue == "<%= ShippingType.STORE.name()%>") {
                        $("#receiverAddress").attr("readonly", true);
                        $("#receiverAddress").css("width", parseInt($("#receiverPhone").css("width")) - 77);
                        $(ezshipBtn).insertAfter($("#receiverAddress"));
                        $("#receiverAddress").attr("placeholder", "請點選右鍵選擇便利店門市");
                        $("#receiverAddress").val('${param.receiverAddress}');
                    } else if (shTypeValue == "<%= ShippingType.HOME.name()%>") {
                        $("#receiverAddress").attr("autocomplete", "on");
                        $("#receiverAddress").attr("placeholder", "請輸入送貨地址");
                    }
                }

                function goEzShip() {
                    $("#receiverName").val($("#receiverName").val().trim());
                    $("#receiverEmail").val($("#receiverEmail").val().trim());
                    $("#receiverPhone").val($("#receiverPhone").val().trim());
                    $("#receiverAddress").val($("#receiverAddress").val().trim());
                    var protocol = "<%=request.getProtocol().toLowerCase().substring(0, request.getProtocol().indexOf("/"))%>";
                    var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";
                    var url = protocol + "://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ez_shop_callback.jsp";
                    $("#rtURL").val(url);
                    $("#webPara").val($("#cartForm").serialize());
                    // alert(url);
                    // alert($("#webPara").val());
                    // alert($("#ezForm").serialize());
                    $("#ezForm").submit();
                }
            </script>
            <form method="post" name="simulation_from" action="http://map.ezship.com.tw/ezship_map_web.jsp" id="ezForm">
                <input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->
                <input type="hidden" name="processID" value="VGB201804230000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->
                <input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->
                <input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->           
                <input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->
                <input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中cartForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->
            </form>

            <%}else{%>
            <p>尚未有購物車清單，返回<a href="<%= request.getContextPath()%>/products_list.jsp">商品頁</a>進行購物!</p>
            <%}%>
        </div>
        <!--include footer.jsp(聯絡資訊等)-->
        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
    </body>
</html>
