/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.vgb.web;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter(filterName = "CharsetFilter", urlPatterns = {"*.view", "*.do", "*.jsp"})
public class CharsetFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //設定request編碼方式(UTF-8)
        request.setCharacterEncoding("UTF-8");
        //鎖住request編碼方式
        request.getParameterNames();
        //設定response編碼方式(UTF-8)
        response.setCharacterEncoding("UTF-8");
        //鎖定response編碼方式
        response.getWriter();
        //交棒給後面的filter/servlet
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }

}
