package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DTO.ConvesartionData;
import Models.Conversation;
import utils.DBConnection;

public class conversation {
	// DONE
	public static String CountConversation = """
		    SELECT COUNT(*) AS conversation_count
		    FROM conversations
		    """;
	
	public static String conversationDetail =  """
		    SELECT
	        c.id,
	        c.name,
	        c.description,
	        c.created_at,
	        COUNT(cu.user_id) AS user_count
	    FROM conversations c
	    LEFT JOIN conversation_user cu
	        ON c.id = cu.conversation_id
	    GROUP BY
	        c.id,
	        c.name,
	        c.description,
	        c.created_at
	    ORDER BY c.created_at DESC
	    """;
			
//			"""
//		    SELECT id, name, description, created_at
//		    FROM conversation
//		    ORDER BY created_at DESC
//		    """;
	
	public static String allconversationNameForUser= """
		    SELECT
	        c.id,
	        c.name,
	    FROM conversations c
	    JOIN conversation_user cu
	        ON c.id = cu.conversation_id
	    WHERE cu.user_id = ?
	    ORDER BY c.created_at DESC
	    """;
	
	public static String addUserForConversation = """
		    INSERT INTO conversation_user
	        (conversation_id, user_id)
	    VALUES
	        (?, ?)
	    ON DUPLICATE KEY UPDATE
	        conversation_id = conversation_id
	    """;
	
	public static String getmassagesForConversation= """
		    SELECT
	        id,
	        content,
	        created_at,
	        sender_id,
	        conversation_id
	    FROM message
	    WHERE conversation_id = ?
	    ORDER BY created_at ASC
	    """;
	
	public static String AddmassageToconversation = """
		    INSERT INTO message
	        (content, created_at, sender_id, conversation_id)
	    VALUES
	        (?, ?, ?, ?)
	    """;
	
	public static String getmassagesForConversationWithSenderNameString = """
		    SELECT
	        m.id,
	        m.content,
	        m.created_at,
	        m.sender_id,
	        m.conversation_id,
	        u.username
	    FROM message m
	    JOIN user u
	        ON m.sender_id = u.id
	    WHERE m.conversation_id = ?
	    ORDER BY m.created_at ASC
	    """;
	
	
	
	public int conversationCount () {
		try (Connection connection = DBConnection.getConnection()){
            Statement statement = connection.createStatement();
            
           ResultSet result = statement.executeQuery(CountConversation);
           int Count = 0 ;
           if (result.next()) {
        	     Count = result.getInt("conversation_count");
        	}
           return Count;

       } catch (SQLException e) {
           e.printStackTrace();
           return 0;
       }
	}
	
	
	public List<ConvesartionData> getConversationData () {
		try (Connection connection = DBConnection.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(conversationDetail);
			
			ResultSet result = statement.executeQuery();
			
			
			List<ConvesartionData> convesartionsData = new ArrayList<ConvesartionData>();
			
			while (result.next()) {
				
				ConvesartionData C = new ConvesartionData();
				
				C.setId(result.getLong("ids"));
				C.setName(result.getString("name"));
				C.setDiscraption(result.getString("discraption"));
				C.setCreated_at("created_at");
				C.setUsercount(result.getInt("user_count"));
				convesartionsData.add(C);
				
			}
			return convesartionsData;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	public boolean addUserToConversation (int conversationId , int userID) {
		
		try (Connection connection = DBConnection.getConnection()){
            PreparedStatement statement = connection.prepareStatement(addUserForConversation);
            
            
            statement.setLong(1, conversationId);
            statement.setLong(2, userID);
            
           int AddRow= statement.executeUpdate();
           
           return AddRow >0;
            

       } catch (SQLException e) {
           e.printStackTrace();
           return false;
       }
		
		
		
	}
	
	
}