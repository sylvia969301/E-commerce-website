  $(document).ready(init);
        var loginForm;
        function init() {
            $("#cartBtn").click("openCartNav", openCartNavHandler);
            $(".cartExit").click("closeCartNav", closeCartNavHandler);
        }

        function openCartNavHandler() {
            $(".cartNav").animate({right: '0px'}); 
//            $.ajax({
//                url: "<%= request.getContextPath()%>/cart_bar.jsp",
//                method: 'POST'
//            }).done(addCartBarHandler);
        }        
       
        function closeCartNavHandler() {
          
            $(".cartNav").animate({right: '-460px'});

        }





