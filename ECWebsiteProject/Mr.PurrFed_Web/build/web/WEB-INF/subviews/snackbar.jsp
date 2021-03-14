
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="snackbar">已成功加入購物車!</div>
<script>
    function showSnackbox() {
        var q = parseInt($("#quantity").val());
        if (q >= 1 || q < parseInt($("#qunatity").attr('max'))) {
            var x = document.getElementById("snackbar");
            x.className = "show";
            setTimeout(function () {
                x.className = x.className.replace("show", "");
            }, 3000);
            $("#quantityError").text("");
        }
    }
</script>
