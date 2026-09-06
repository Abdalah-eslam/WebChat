package DTO;

public class Userdto {
  

   private long id ;
    private String  username;
    private String role;
    private String Token;
    
    
    

    public Userdto(long id, String username, String role, String token) {
		super();
		this.id = id;
		this.username = username;
		this.role = role;
		Token = token;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

    public Userdto() {
    }

    public String getrole() {
        return role;
    }

    public void setrole(String role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getToken() {
        return Token;
    }

    public void setToken(String token) {
        Token = token;
    }
}
