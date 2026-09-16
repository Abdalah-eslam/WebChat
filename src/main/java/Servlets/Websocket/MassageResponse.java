package Servlets.Websocket;

public class MassageResponse {

   
	private String content;
    private Long senderId;
    private Long conversationId;
    private String createdAt;
    private String senderUsername;
    
    
    public MassageResponse(String content, Long senderId, Long conversationId, String createdAt, String userName) {
		super();
		this.content = content;
		this.senderId = senderId;
		this.conversationId = conversationId;
		this.createdAt = createdAt;
		this.senderUsername = userName;
	}
	
	public String getSenderUsername() {
		return senderUsername;
	}

	public void setSenderUsername(String userName) {
		this.senderUsername = userName;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Long getSenderId() {
		return senderId;
	}
	public void setSenderId(Long senderId) {
		this.senderId = senderId;
	}
	public Long getConversationId() {
		return conversationId;
	}
	public void setConversationId(Long conversationId) {
		this.conversationId = conversationId;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

    // constructor
    // getters
    // setters
}