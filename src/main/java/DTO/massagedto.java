package DTO;


public class massagedto {
	private long id ;
	private String content;
	private String created_at ;
	private long senderId ;
	private String sender_username ;
	
	

	public massagedto(long id, String content, String created_at, long senderId, String sender_username) {
		super();
		this.id = id;
		this.content = content;
		this.created_at = created_at;
		this.senderId = senderId;
		this.sender_username = sender_username;
	}



	public massagedto () {
		
	}
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	public String getSender_username() {
		return sender_username;
	}



	public void setSender_username(String sender_username) {
		this.sender_username = sender_username;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public long getSenderId() {
		return senderId;
	}
	public void setSenderId(long senderId) {
		this.senderId = senderId;
	}
	
}