package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JWT;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import DTO.ConvesartionData;
import Services.Conversation.Conversation_service;
import io.jsonwebtoken.Claims;

/**
 * Servlet implementation class Home_servlet
 */
@WebServlet("/Home_servlet")
public class Home_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   private Conversation_service conversationService ;
    public Home_servlet() {
        super();
        
        conversationService = new Conversation_service();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int Count =conversationService.getCount();
		
		System.out.println("Count is --->"+Count);
		
		List<ConvesartionData> convesartionDatas = conversationService.getConvesartionData();
		
		System.out.println("ConversationData is --->"+convesartionDatas.get(0).getName());

		String token = null;

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {

		    for (Cookie cookie : cookies) {

		        if ("JWT".equals(cookie.getName())) {
		            token = cookie.getValue();
		            break;
		        }
		    }
		}
				
	Claims cliams =	JWT.validateToken(token);
		request.getSession().setAttribute("username", cliams.getSubject());
		request.getSession().setAttribute("id", cliams.get("id"));
		request.setAttribute("Counter", Count);
		request.setAttribute("ConversationData", convesartionDatas);
		request.getRequestDispatcher("home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
