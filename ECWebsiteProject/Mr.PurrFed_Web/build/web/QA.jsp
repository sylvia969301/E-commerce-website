
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
        <style>


        </style>
    </head>
    <body>
        <!--include header.jsp(navBar等主要介面)-->
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div style="margin-top:70px;min-height: 600px;letter-spacing: 2px">
            <p style="text-align: center;font-size: 20px;font-weight: 600;color: gray">常見Q&A</p>
            <div style="margin: 0px 200px;padding: 0px 200px">
                <a href="javascript:extend1()" class="extend1" style="height: 20px;width: 100%;">
                    <p style="font-size: 16px;font-weight: 500;color: black;background:#efdbd4;width: 100%">1. 請問你們有實體店面嗎？</p>
                </a> 
                <div class="extend1-1" style="width: 100%;height: 50px;background:linen" hidden="true">
                    <p>目前以官網上銷售為主，合作店家資訊可以參考這裡喔！</p>
                </div>
                <br>

                <a href="javascript:extend2()" class="extend2" style="height: 20px;width: 100%;">
                    <p style="font-size: 16px;font-weight: 500;color: black;background:#efdbd4;width: 100%">2.下單後多久會出貨呢？</p>
                </a> 
                <div class="extend2-1" style="width: 100%;height: 100px;background:linen" hidden="true">
                    <p>成功下單後會收到訂單確認信，信中會有您的訂單明細及訂單編號。
                        <br>
                        下單後三日內好味小姐即會為您寄送商品，
                        <br>
                        物流公司二到三日內會將商品送達門市或宅配地點。
                        <br>
                        如遇週末或連續假日則會順延，急需或需要指定時間到貨的朋友，要早點下訂喔～
                    </p>
                </div>
                <br>

                <a href="javascript:extend3()" class="extend3" style="height: 20px;width: 100%;">
                    <p style="font-size: 16px;font-weight: 500;color: black;background:#efdbd4;width: 100%">3.我在國外可以買嗎？</p>
                </a> 
                <div class="extend3-1" style="width: 100%;height: 100px;background:linen" hidden="true">
                    <p>我們目前供港澳配送服務，運費99元台幣。
                        <br>
                        購買前請先閱讀港澳訂購須知
                        <br>
                        香港的朋友也可以到我們授權販售的七和寵物購買喔！
                        <br>
                        其他國家由於限制肉製品入境，無法通過海關，暫時無法寄送。
                    </p>
                </div>

                <br>
                <a href="javascript:extend4()" class="extend3" style="height: 20px;width: 100%;">
                    <p style="font-size: 16px;font-weight: 500;color: black;background:#efdbd4;width: 100%">4.我下錯單了／想取消訂單，怎麼辦？</p>
                </a> 
                <div class="extend4-1" style="width: 100%;height: 80px;background:linen" hidden="true">
                    <p>
                        如果您想要更改或取消訂單，都可以立即在訂單通訊內留言告知我們。
                        <br>
                        若您想要加購其他商品，可以直接重新下單。
                        <br>
                        並在新訂單中備註『 我已經重新下單，請幫我取消上一筆訂單 』
                    </p>
                </div>
                <br>
                <a href="javascript:extend5()" class="extend3" style="height: 20px;width: 100%;">
                    <p style="font-size: 16px;font-weight: 500;color: black;background:#efdbd4;width: 100%">5.腎貓可以吃嗎？</p>
                </a> 
                <div class="extend5-1" style="width: 100%;height: 100px;background:linen" hidden="true">
                    <p>腎貓可以吃喔，用來騙水也很棒！
                        <br>
                        好味小姐的全部商品磷含量都屬正常比例，且單次攝取量很低。
                        <br>
                        每次都只吃一點點，所以實際吃到的磷非常少。
                        <br>
                        只要注意不要讓貓咪一口氣，把整個包裝內的產品都吃完就可以了！
                    </p>
                </div>
                <br>
                <a href="javascript:extend6()" class="extend3" style="height: 20px;width: 100%;">
                    <p style="font-size: 16px;font-weight: 500;color: black;background:#efdbd4;width: 100%">6.狗狗可以吃嗎？</p>
                </a> 
                <div class="extend6-1" style="width: 100%;height: 60px;background:linen" hidden="true">
                    <p>
                        當然可以，好味小姐的全部商品都是使用天然食材製成！
                        <br>
                        無調味、無添加、無防腐劑，狗狗也很適合吃喔！
                    </p>
                </div>
                <br>
                <a href="javascript:extend7()" class="extend3" style="height: 20px;width: 100%;">
                    <p style="font-size: 16px;font-weight: 500;color: black;background:#efdbd4;width: 100%">7.人可以吃嗎？</p>
                </a> 
                <div class="extend7-1" style="width: 100%;height: 60px;background:linen" hidden="true">
                    <p>
                        可以，好味小姐的全部商品都是使用人食等級食材製成！
                        <br>
                        只是應該不是那麼美味ＸＤＤ
                    </p>
                </div>
                <br>
            </div>
        </div>

        <!--include footer.jsp(聯絡資訊等)-->
        <jsp:include page="/WEB-INF/subviews/footer.jsp"/>
        <script>
            function extend1() {
                $(".extend1-1").animate({
                    height: 'toggle'
                });
            }
            function extend2() {
                $(".extend2-1").animate({
                    height: 'toggle'
                });
            }
            function extend3() {
                $(".extend3-1").animate({
                    height: 'toggle'
                });
            }
            function extend4() {
                $(".extend4-1").animate({
                    height: 'toggle'
                });
            }
            function extend5() {
                $(".extend5-1").animate({
                    height: 'toggle'
                });
            }
            function extend6() {
                $(".extend6-1").animate({
                    height: 'toggle'
                });
            }
            function extend7() {
                $(".extend7-1").animate({
                    height: 'toggle'
                });
            }

        </script>
    </body>
</html>
