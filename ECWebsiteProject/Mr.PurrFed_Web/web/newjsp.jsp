
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--include global.jsp(mata等主要設定+外部js,css)-->
        <jsp:include page="/WEB-INF/subviews/global.jsp"/>
        <style>
            .item{
                border:1px solid silver;
                background:pink;
                width:100px;
                height:100px;
                display: inline-block;
            }
            .inner{
                margin: auto;
                background: orange;
                margin-left: 0px;
            }
            .outer{
                margin: auto;
                background: #eee;
                overflow: hidden;
                display: inline-block;  
            }
            .direct{
                margin: auto;
            }
            .dirctLeft,.dirctRight{
                margin-top: -100px;
           
            }
        </style>
        <script>
            var outer;
            var inner;
            var direct;
            var itemNum = 11;
            var itemWidth = 210;
            var pageSize = 4;
            var pageNum = Math.ceil(itemNum / pageSize);
            var counter = 0;
            $(document).ready(init);
            function init() {
                inner = $(".inner");
                outer = $(".outer");
                direct = $(".direct");
                for (var i = 1; i <= itemNum; i++) {
                    inner.append("<div class='item'>Item" + i + "</div>");
                }
                inner.width(100 * itemNum);
                outer.width(100 * pageSize);
                direct.width(100 * pageSize + 36 * 2);

                $(".directImg").click(directHandler);
            }
            function directHandler() {
                var direct = Number($(this).attr("direct"));
                counter += direct;
                if (-pageNum < counter && counter <= 0) {
                    var marginLeft = pageSize * counter * itemWidth;
                    $(".inner").animate({marginLeft: marginLeft + "px"}, 200);
                }
                if(counter==-pageNum) counter=-pageNum+1;
                if(counter==1) counter=0;
                console.log(counter+" "+-pageNum);
            }
        </script>
    </head>
    <body>
        <div class="direct">
            <img src="<%= request.getContextPath()%>/images/left_arrow.png" class="directImg dirctLeft" direct="-1">

            <div class="outer">
                <div class="inner"></div>
            </div>
            <img src="<%= request.getContextPath()%>/images/right_arrow.png" class="directImg dirctRight" direct="1">

        </div>
    </body>
</html>
