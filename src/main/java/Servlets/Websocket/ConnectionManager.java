package Servlets.Websocket;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import jakarta.websocket.Session;

public class ConnectionManager {
	
	private final ConcurrentHashMap<Long, ConcurrentHashMap<Long, Session>> connections = new ConcurrentHashMap<>();
	
	
	public void addConnection(long chatId , long userId , Session session) {
		
					connections
							.computeIfAbsent(chatId, key -> new ConcurrentHashMap<>())
							.put(userId, session);
	}
	
	public void deleteConnection(long chatId , long userId) {
		
		Map<Long, Session> chatConnections = connections.get(chatId);

	    if (chatConnections != null) {
	        chatConnections.remove(userId);
	    }
	}
	
	public Map<Long, Session> getChatConnections(long chatId) {
		
	return	connections.get(chatId);
		
	}

}