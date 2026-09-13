package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import DTO.ConvesartionData;
import Services.Conversation.Conversation_service;

/**
 * Servlet implementation class create_Coversation
 */
@WebServlet("/create_Conversation")
public class create_Conversation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Conversation_service conversation_service ;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public create_Conversation() {
        super();
        conversation_service = new Conversation_service();
        // TODO Auto-generated constructor stub
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
	ConvesartionData data =new  ConvesartionData();
	
	
	
	data.setName(request.getParameter("name"));
	data.setDescription(request.getParameter("description"));
	data.setPublic(true);
	data.setCreated_by((int)request.getSession().getAttribute("id"));
		boolean iscreated= conversation_service.createConversation(data);
		
		if (iscreated) {
			conversation_service.addUserforconversation(data.getId(),(long)data.getCreated_by());
			request.getRequestDispatcher("chat.jsp").forward(request, response);
			
			return;
		}
		
		response.sendRedirect("home.jsp");
		
		
	}

}
