package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import DTO.Userdto;
import Models.User;
import Services.Auth.Auth_Service;

/**
 * Servlet implementation class Register_Servlet
 */
@WebServlet("/register")
public class register_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public register_servlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private Auth_Service authService;

    @Override
    public void init() throws ServletException {
		this.authService = new Auth_Service();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username =request.getParameter("username");
		String email =request.getParameter("email");
		String password =request.getParameter("password");
		
		User newuser = new User();
		
		newuser.setEmail(email.trim());
		newuser.setPassword(password);
		newuser.setUsername(username.trim());
		Userdto createduser= authService.register(newuser);
		
		
		
		 if(createduser !=null )
		 {
			 Cookie cookie = new Cookie("JWT",createduser.getToken());
			 cookie.setHttpOnly(true);
			 response.addCookie(cookie);
			
		
				 
			 response.sendRedirect("Home_servlet");
			
	
			 
		 }
		 
		 else {
			 request.setAttribute("error","Registration failed. Please try again.");
			 RequestDispatcher reqDis= request.getRequestDispatcher("register.jsp");
				reqDis.forward(request, response);
			
		 }
	}

}
