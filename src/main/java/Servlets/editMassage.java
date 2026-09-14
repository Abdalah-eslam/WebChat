package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Services.massage.Imassage;
import Services.massage.massage;

/**
 * Servlet implementation class editMassage
 */
@WebServlet("/editMassage")
public class editMassage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private Imassage massageservice ; 
    public editMassage() {
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
		
		String massageId = request.getParameter("messageId");

        String conversationId =
                request.getParameter("conversationId");
        
        String content =
                request.getParameter("content");
        
        Long userId =
        	    ((Integer) request.getSession().getAttribute("id")).longValue();
		massageservice.editMassage(Long.parseLong(massageId) , userId ,content);
		
		response.sendRedirect("chat?chatId="+conversationId);
		
	}

}
