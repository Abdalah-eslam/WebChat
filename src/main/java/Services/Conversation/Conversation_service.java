package Services.Conversation;

import java.util.List;

import DAO.conversation;
import DTO.ConvesartionData;

public class Conversation_service implements IConversation {
	
	private conversation conversation;
	
	public Conversation_service () {
		conversation = new conversation();
	}

	@Override
	public int getCount() {
		int Count =  conversation.conversationCount();
		
		return Count;
		
		
	}

	@Override
	public List<ConvesartionData> getConvesartionData() {
		
		
		List<ConvesartionData> convesartionDatas = conversation.getConversationData();
		return convesartionDatas;
		
		
	}
	
	public boolean createConversation(ConvesartionData data) {
	boolean isCreated=conversation.createConversation(data);
	return isCreated;
				}
				
				
				
}