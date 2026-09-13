package Models;


public class Massage {
	private long id ;
	private String content;
	private long conversationId ;
	private long senderId ;
	
	
	public Massage() {
		super();
	}



	public Massage(long id, String content, long conversationId, long senderId) {
		super();
		this.id = id;
		this.content = content;
		this.conversationId = conversationId;
		this.senderId = senderId;
	}
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getConversationId() {
		return conversationId;
	}
	public void setConversationId(long conversationId) {
		this.conversationId = conversationId;
	}
	public long getSenderId() {
		return senderId;
	}
	public void setSenderId(long senderId) {
		this.senderId = senderId;
	}
	
}