package Services.Conversation;

import java.util.List;

import DTO.ConvesartionData;

public interface IConversation {
	
	public int getCount();
	public List<ConvesartionData> getConvesartionData ();
	public void addUserforconversation(Long conversationId , Long userId);
	public ConvesartionData getConversationdataByid(Long ConversationId);
	
	
}