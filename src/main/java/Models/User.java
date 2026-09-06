package Models;

import java.time.LocalDateTime;

public class User {
	public Long getID() {
		return ID;
	}

	public void setID(Long iD) {
		ID = iD;
	}
	private Long ID ;
	private String Username ;
	private String  email ;
	private String  Password;
	private String Created_At ;	
	 
	
	public User() {
		
	}
	
	public User(Long ID,String username, String email, String password, String created_At) {
		this.ID = ID ;
		Username = username;
		this.email = email;
		Password = password;
		Created_At = created_At;
	}
	public String getUsername() {
		return Username;
	}
	public void setUsername(String username) {
		Username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getCreated_At() {
		return Created_At;
	}
	public void setCreated_At(String created_At) {
		Created_At = created_At;
	}
	

	
	
	
}