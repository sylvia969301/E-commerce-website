package uuu.vgb.web;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(filterName = "ConvertToIPAddressFilter", urlPatterns = {"/*"})
public class ConvertToIPAddressFilter implements Filter {

    private FilterConfig filterConfig = null;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //判斷請求是否使用server的ip，若不是為了讓[EZShip]服務能運作，則redirect到server ip的url，這段檢查轉址的程式可以用Filter來完成
        HttpServletRequest httpReq = (HttpServletRequest) request;
        StringBuffer url = httpReq.getRequestURL();
//        System.out.println("url = " + url);
        String ipAddress = java.net.InetAddress.getLocalHost().getHostAddress();
        String hostName = java.net.InetAddress.getLocalHost().getHostName().toLowerCase();
//        System.out.println("hostName = " + hostName);
        if (url.indexOf("//localhost") > 0 || url.indexOf("//" + hostName) > 0) {
            String location;
            if (url.indexOf("//localhost") > 0) {
                location = url.toString().replace("//localhost", "//" + ipAddress);
            } else {
                location = url.toString().replace("//" + hostName, "//" + ipAddress);
            }
            ((HttpServletResponse) response).sendRedirect(location);
            return;
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}
