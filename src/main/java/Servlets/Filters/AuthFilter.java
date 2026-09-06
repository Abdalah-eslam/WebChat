package Servlets.Filters;

import java.io.IOException;
import java.net.http.HttpRequest;

import io.jsonwebtoken.Claims;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JWT;
@WebFilter(urlPatterns = {
		"/login.jsp",
		"/register.jsp"
})
public class AuthFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
		
		 String uri = req.getRequestURI();

	        System.out.println("Auth Filter: " + uri);

	       
	        if (uri.endsWith("/login.jsp")
	                || uri.endsWith("/register.jsp")
	                || uri.endsWith("/LoginServlet")
	                || uri.endsWith("/RegisterServlet")) {

	            chain.doFilter(request, response);
	            return;
	        }

	        // Get JWT from Cookie
	        Cookie[] cookies = req.getCookies();

	        String jwt = null;

	        if (cookies != null) {

	            for (Cookie cookie : cookies) {

	                if ("JWT".equals(cookie.getName())) {
	                    jwt = cookie.getValue();
	                    break;
	                }
	            }
	        }

	        // No JWT
	        if (jwt == null) {
	            res.sendRedirect("login.jsp");
	            return;
	        }

	        // Validate JWT
	        try {

	            Claims claims = JWT.validateToken(jwt);

	            System.out.println("JWT is valid");

	            req.getSession().setAttribute("JWT", jwt);

	            chain.doFilter(request, response);
	            return;

	        } catch (Exception e) {

	            // JWT invalid / expired
	            res.sendRedirect("login.jsp");
	            return;
	        }
	    }		    
		
	}
