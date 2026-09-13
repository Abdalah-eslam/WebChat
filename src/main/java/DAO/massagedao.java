package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import DTO.massagedto;
import Models.Massage;
import utils.DBConnection;

public class massagedao {
	
	String getMassageForConversation =
			""" 
			SELECT m.id, m.conversation_id, m.sender_id, u.username AS sender_username, m.content, m.created_at 
			FROM messages m JOIN users u 
			ON m.sender_id = u.id
			 WHERE m.conversation_id = ? ORDER BY m.created_at ASC
						""";
	
	String addMassage = 
			 """
		    INSERT INTO messages (content, sender_id, conversation_id)
		    VALUES (?, ?, ?)
		    """;
	
	String deleteMassageForUser =
			 """
		    DELETE FROM messages
		    WHERE id = ?
		      AND sender_id = ?
		    """;
	
	String updateMassageForUser = """
		    UPDATE messages
		    SET content = ?
		    WHERE id = ?
		      AND sender_id = ?
		    """;
	
	
	
	

	

	public ArrayList<massagedto> getAllmassage (String ConversationID ) {
		 try (Connection connection = DBConnection.getConnection()){
			 PreparedStatement ps = connection.prepareStatement(getMassageForConversation);
			 ps.setString(1, ConversationID);
			 ResultSet rs = ps.executeQuery();
			 ArrayList<massagedto> massages = new ArrayList<>();

		while (rs.next()) {
			massagedto massage = new massagedto();
			massage.setContent(rs.getString("content"));
			massage.setId(rs.getLong("id"));
			massage.setSender_username(rs.getString("sender_username"));
			massage.setSenderId(rs.getLong("sender_id"));
			massage.setCreated_at(rs.getString("created_at"));
			massages.add(massage);
		}
		return massages ;

		 }
		
		
		catch (Exception e) {
			e.printStackTrace();
			return null ;
		}
	
};

		public boolean addMassage (Massage massage  ) {
			 try (Connection connection = DBConnection.getConnection()){
				 PreparedStatement ps = connection.prepareStatement(addMassage);
				 ps.setString(1, massage.getContent());
				 ps.setLong(2, massage.getSenderId());
				 ps.setLong(3,massage.getConversationId());
				 boolean rs = ps.execute();
				 
				 return rs ;
			 }
			 	
			
			catch (Exception e) {
				e.printStackTrace();
				return false ;
			}
		
		}

		public boolean deletemassage(Long massageId, Long userId) {
			 try (Connection connection = DBConnection.getConnection();
			         PreparedStatement ps =
			             connection.prepareStatement(deleteMassageForUser)) {

			        ps.setLong(1, massageId);
			        ps.setLong(2, userId);

			        int rows = ps.executeUpdate();

			        return rows > 0;

			    } catch (Exception e) {
			        e.printStackTrace();
			        return false;
			    }
			
			
			
		}
		
		public boolean editMassage (Long massageId , Long userId , String content) {
			 try (Connection connection = DBConnection.getConnection();
			         PreparedStatement ps =
			             connection.prepareStatement(updateMassageForUser)) {

			        ps.setString(1, content);
			        ps.setLong(2, massageId);
			        ps.setLong(3, userId);
			        

			        int rows = ps.executeUpdate();

			        return rows > 0;

			    } catch (Exception e) {
			        e.printStackTrace();
			        return false;
			    }
		}
	
	
	
	
	
}