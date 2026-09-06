package DTO;

public class ConvesartionData {
	
	 private long  id ;
	 private String name;
	 private String discrapton;
	 private String created_at;
	 
	 
	 public ConvesartionData() {
			super();
		}
	 
	 
	 public ConvesartionData(long id, String name, String discrapton, String created_at) {
		super();
		this.id = id;
		this.name = name;
		this.discrapton = discrapton;
		this.created_at = created_at;
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
	 public String getDiscrapton() {
		 return discrapton;
	 }
	 public void setDiscrapton(String discrapton) {
		 this.discrapton = discrapton;
	 }
	 public String getCreated_at() {
		 return created_at;
	 }
	 public void setCreated_at(String created_at) {
		 this.created_at = created_at;
	 }
	
}