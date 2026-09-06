package Servlets.Filters;

import java.io.IOException;


import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

@WebFilter("/login")
public class validation_filter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		 String email =	request.getParameter("email");
		 String password =	request.getParameter("password");
		 System.out.println("Form validation filter");
		 
		 if (email != null && password != null && password.length() > 6) {
			    chain.doFilter(request, response);
			    return;
			}

			request.setAttribute(
			    "error",
			    "Email and password are required and password should be more than 6"
			);

			request.getRequestDispatcher("login.jsp").forward(request, response);
		 
		 
		
	
	}
	
}