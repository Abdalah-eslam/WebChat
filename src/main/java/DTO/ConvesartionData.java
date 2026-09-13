package DTO;

public class ConvesartionData {
	
	 private long  id ;
	 private String name;
	 private String description;
	 private int created_by;
	 private int usercount;
	 private boolean isPublic;
	 private String created_at;
	 
	 
	


	 public String getCreated_at() {
		return created_at;
	}


	 public void setCreated_at(String created_at) {
		 this.created_at = created_at;
	 }


	 public ConvesartionData(long id, String name, String discraption, int created_by, int usercount,
			boolean isPublic) {
		super();
		this.id = id;
		this.name = name;
		this.description = discraption;
		this.created_by = created_by;
		this.usercount = usercount;
		this.isPublic = isPublic;
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
	 public String getDescription() {
		 return description;
	 }
	 public void setDescription(String discraption) {
		 this.description = discraption;
	 }
	 public int getCreated_by() {
		 return created_by;
	 }
	 public void setCreated_by(int created_by) {
		 this.created_by = created_by;
	 }


	 public int getUsercount() {
		 return usercount;
	 }


	 public void setUsercount(int usercount) {
		 this.usercount = usercount;
	 }


	 public boolean isPublic() {
		 return isPublic;
	 }


	 public void setPublic(boolean isPublic) {
		 this.isPublic = isPublic;
	 }
	
}