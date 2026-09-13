package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JWT;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import DAO.conversation;
import DTO.ConvesartionData;
import DTO.massagedto;
import Services.Conversation.Conversation_service;
import Services.massage.Imassage;
import Services.massage.massage;
import io.jsonwebtoken.Claims;

@WebServlet("/chat")
public class chat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private Conversation_service conversation_service ;
	private Imassage massageservice ; 
    public chat() {
        super();
        this.massageservice = new massage();
        conversation_service = new Conversation_service();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			 String conversationID= request.getParameter("chatId");
			 String username=(String) request.getSession().getAttribute("username");
			int userid=(int)request.getSession().getAttribute("id");
			
			conversation_service.addUserforconversation(Long.parseLong(conversationID),(long)userid);
		
			ArrayList<massagedto> massages= massageservice.getMassagebyCoversation(conversationID);
			ConvesartionData convesartionData = conversation_service.getConversationdataByid(Long.parseLong(conversationID));
			
	
			 
			
			
			request.setAttribute("ConversationData", convesartionData);
			request.setAttribute("massages", massages);
			System.out.println("chatid---->"+conversationID+"username--->"+username+"userId--->"+userid+"from conversation data its name is "+convesartionData.getName());
		    request.getRequestDispatcher("chat.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 
	}

}
