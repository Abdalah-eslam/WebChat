package Models;


public class Conversation {

	private long id ;
	private String name ; 
	private String discraption ; 
	private long created_by ;

	
	
	
	public Conversation(long id, String name, String discraption, long created_by) {
		super();
		this.id = id;
		this.name = name;
		this.discraption = discraption;
		this.created_by = created_by;
	}
	public Conversation() {
		super();
	}
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDiscraption() {
		return discraption;
	}
	public void setDiscraption(String discraption) {
		this.discraption = discraption;
	}
	public long getCreated_by() {
		return created_by;
	}
	public void setCreated_by(long created_by) {
		this.created_by = created_by;
	}

}