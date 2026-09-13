package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Models.Massage;
import Services.massage.Imassage;
import Services.massage.massage;

/**
 * Servlet implementation class Sendmassage
 */
@WebServlet("/Sendmassage")
public class Sendmassage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private Imassage massageservice ; 

    public Sendmassage() {
        super();
        this.massageservice = new massage();
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
		
		Massage massage = new Massage();
		Integer id = (Integer) request.getSession().getAttribute("id");
		massage.setSenderId(id.longValue());
		massage.setContent(request.getParameter("content"));
		massage.setConversationId(Long.parseLong((String)request.getSession().getAttribute("chatId")));
		
		massageservice.addMassage(massage);
		
		response.sendRedirect("chat.jsp");
		
		
		
	}

}
