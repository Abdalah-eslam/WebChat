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
			
	
	public static String createConversation =  """
		    INSERT INTO conversations
		    (name, description, created_by , isPublic)
		    VALUES (?, ? , ? , ?)
		    """;
	
	public static String addUserForConversation = """
		    INSERT INTO conversation_user
	        (conversation_id, user_id)
	    VALUES
	        (?, ?)
	    ON DUPLICATE KEY UPDATE
	        conversation_id = conversation_id
	    """;
	
	public static String getConverastionDatabyid ="""
			
			SELECT c.name, c.created_By, c.isPublic, c.created_at, COUNT(cu.user_id) AS usercount 
			FROM conversations c
			 LEFT JOIN conversation_user cu ON c.id = cu.conversation_id 
			WHERE c.id = ? GROUP BY 
			c.id, c.name, c.created_By, c.isPublic, c.created_at """;
	
	public boolean createConversation (ConvesartionData data) {
		
		try (Connection connection = DBConnection.getConnection()){
            PreparedStatement statement = connection.prepareStatement(createConversation);
            
            statement.setString(1, data.getName());
            statement.setString(2, data.getDescription());
            statement.setInt(3, data.getCreated_by());
            statement.setBoolean(4, data.isPublic());
            
           int rows = statement.executeUpdate();
           if (rows > 0 ) {
        	   return true;
           }
           return false;

       } catch (SQLException e) {
           e.printStackTrace();
           return false;
       }
	}
	
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
				System.out.println("UserCounter for Conversation"+result.getString("name")+"count is "+result.getInt("user_count"));
				C.setId(result.getLong("id"));
				C.setName(result.getString("name"));
				C.setDescription(result.getString("description"));
				C.setCreated_at(result.getString("created_at"));
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
	
	public boolean addUserToConversation (Long conversationId , Long userId) {
		
		try (Connection connection = DBConnection.getConnection()){
            PreparedStatement statement = connection.prepareStatement(addUserForConversation);
            
            
            statement.setLong(1, conversationId);
            statement.setLong(2, userId);
            
           int AddRow= statement.executeUpdate();
           
           return AddRow >0;
            

       } catch (SQLException e) {
           e.printStackTrace();
           return false;
       }
		
		
		
	};
	
	
public ConvesartionData getConversationdataByid(Long ConversationId) {
		
		try (Connection connection = DBConnection.getConnection()){
            PreparedStatement statement = connection.prepareStatement(getConverastionDatabyid);
            
            
            statement.setLong(1, ConversationId);
            
            ResultSet rs = statement.executeQuery();
            
            ConvesartionData conversationData =new ConvesartionData();
          while (rs.next()) {
		
            conversationData.setName(rs.getString("name"));
            conversationData.setCreated_by(rs.getInt("created_By"));
            conversationData.setPublic(rs.getBoolean("isPublic"));
            conversationData.setCreated_at(rs.getString("created_at"));
            conversationData.setUsercount(rs.getInt("usercount"));
          }
            return conversationData;
          
		
	}
		catch (Exception e) {
			e.printStackTrace();
	           return null;
		}
		
			
		
}
}