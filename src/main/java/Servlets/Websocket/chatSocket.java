package Servlets.Websocket;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Map;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import Models.Massage;
import Services.massage.Imassage;
import Services.massage.massage;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint(
	    value = "/ws",
	    configurator = Handshake.class
	)
public class chatSocket {
	
	private static final ConnectionManager connectionManager =
            new ConnectionManager();

	@OnOpen
	public void onOpen(Session session, EndpointConfig config) {

	    HttpSession httpSession =
	            (HttpSession) config.getUserProperties()
	                    .get(HttpSession.class.getName());
	    
	    Long chatId = Long.parseLong(
	            session.getRequestParameterMap()
	                    .get("chatId")
	                    .get(0)
	    );

	    Integer userId =
	            (Integer) httpSession.getAttribute("id");
	    
	    String username = (String) httpSession.getAttribute("username") ;
	    
	    session.getUserProperties().put("chatId", chatId);
	    session.getUserProperties().put("userId", userId);
	    session.getUserProperties().put("username", username);

	    connectionManager.addConnection(chatId, (long) userId, session);
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {

	    Long chatId =
	        (Long) session.getUserProperties().get("chatId");

	    Integer userId =
	        (Integer) session.getUserProperties().get("userId");
	    
	   String username = (String) session.getUserProperties().get("username");

	    Massage massage = new Massage();

	    massage.setContent(message);
	    massage.setSenderId(userId.longValue());
	    massage.setConversationId(chatId);

	    Imassage massageservice = new massage();

	    boolean saved =
	        massageservice.addMassage(massage);

	  MassageResponse massageResponse = new MassageResponse(message, (long)userId, chatId, LocalDateTime.now().toString() ,username);
	  
	  
	  ObjectMapper mapper = new ObjectMapper();

	  String json = null;
	try {
		json = mapper.writeValueAsString(massageResponse);
	} catch (JsonProcessingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  
	  
	        System.out.println("Message saved successfully.");
	        
	        Map<Long, Session> chatConnections =
	                connectionManager.getChatConnections(chatId);

	        if (chatConnections != null) {
	        	
	        	for (Session userSession : chatConnections.values()) {

	                try {
	                    userSession
	                        .getBasicRemote()
	                        .sendText(json);

	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    
	}
    
    
    @OnClose
    public void onClose(Session session) {

        Long chatId =
                (Long) session.getUserProperties().get("chatId");

        Integer userId =
                (Integer) session.getUserProperties().get("userId");

        connectionManager.deleteConnection(
                chatId,
                userId.longValue()
        );

        System.out.println("WebSocket closed");
    }
}