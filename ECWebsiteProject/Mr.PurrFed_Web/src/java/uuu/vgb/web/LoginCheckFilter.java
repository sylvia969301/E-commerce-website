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
import javax.servlet.http.HttpSession;
import uuu.vgb.entity.Customer;

@WebFilter(filterName = "LoginCheckFilter", urlPatterns = {"/member/*"})
public class LoginCheckFilter implements Filter {

    private FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //只有JSP有內建session 故filter要自己宣告建立
        HttpSession session = ((HttpServletRequest) request).getSession();
        Object obj = session.getAttribute("member");
        if (obj instanceof Customer) {
            //交棒給後面的servlet/filter
            chain.doFilter(request, response);
        } else {
            HttpServletRequest httpRequest = (HttpServletRequest)request;
            String queryString = httpRequest.getQueryString();
           if(queryString==null || queryString.length()==0){
                session.setAttribute("previous_uri", httpRequest.getRequestURI());
            }else{
                session.setAttribute("previous_uri", httpRequest.getRequestURI() + '?' + queryString);
            }
            ((HttpServletResponse)response).sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }
    }

    @Override
    public void destroy() {
    }

}
