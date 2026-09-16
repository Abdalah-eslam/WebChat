package Servlets.Filters;

import java.io.IOException;

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

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse res =
                (HttpServletResponse) response;

        String uri = req.getRequestURI();

        System.out.println("Request URI: " + uri);

        // Public pages / endpoints
        if (uri.endsWith("/login.jsp")
                || uri.endsWith("/register.jsp")
                || uri.endsWith("/login")
                || uri.endsWith("/register")) {

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

        System.out.println("JWT from cookie: " + jwt);

        // No JWT
        if (jwt == null || jwt.isEmpty()) {

            res.sendRedirect(
                    req.getContextPath() + "/login.jsp"
            );

            return;
        }

        // Validate JWT
        try {

            Claims claims =
                    JWT.validateToken(jwt);

            if (claims == null) {

                res.sendRedirect(
                        req.getContextPath() + "/login.jsp"
                );

                return;
            }

            System.out.println("JWT is valid");

            chain.doFilter(request, response);

        } catch (Exception e) {

            System.out.println(
                    "JWT validation failed: "
                    + e.getMessage()
            );

            res.sendRedirect(
                    req.getContextPath() + "/login.jsp"
            );
        }
    }
}