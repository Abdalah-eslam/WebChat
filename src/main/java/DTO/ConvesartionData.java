package DTO;

public class ConvesartionData {
	
	 private long  id ;
	 private String name;
	 private String discraption;
	 private String created_at;
	 private int usercount;
	 
	 
	 public ConvesartionData(long id, String name, String discraption, String created_at, int usercount) {
		super();
		this.id = id;
		this.name = name;
		this.discraption = discraption;
		this.created_at = created_at;
		this.usercount = usercount;
	}


	 public ConvesartionData() {
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
	 public String getCreated_at() {
		 return created_at;
	 }
	 public void setCreated_at(String created_at) {
		 this.created_at = created_at;
	 }


	 public int getUsercount() {
		 return usercount;
	 }


	 public void setUsercount(int usercount) {
		 this.usercount = usercount;
	 }
	
}