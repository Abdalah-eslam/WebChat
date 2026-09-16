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
import Services.Auth.Auth_Service;


/**
 * Servlet implementation class login_servlet
 */
@WebServlet("/login")
public class login_servlet extends HttpServlet {
	

	private static final long serialVersionUID = 1L;
	 private Auth_Service authService;
       

    public login_servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    public void init() throws ServletException {
    	this.authService = new Auth_Service();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email").toString();
	    String password = request.getParameter("password");

	    Userdto currentUser =
	            authService.login(email, password);

	    if (currentUser != null) {

	        Cookie cookie =
	                new Cookie("JWT", currentUser.getToken());

	        cookie.setHttpOnly(true);
	        cookie.setPath("/");

	        response.addCookie(cookie);

	        response.sendRedirect(
	                request.getContextPath() + "/Home_servlet"
	        );

	    } else {

	        request.setAttribute(
	                "error",
	                "Login failed. Please try again."
	        );

	        RequestDispatcher reqDis =
	                request.getRequestDispatcher("login.jsp");

	        reqDis.forward(request, response);
	    }
	}

}
