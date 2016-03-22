package com.scs.model;

import org.springframework.data.annotation.Id;

/**
 * This Pojo contains the roles of user 
 * Authors : Sumit
 */
public class UserRole {

	@Id
	private String id;
		
	public UserRole() {
		super();
	}
	
	public UserRole(String id) {
		super();
		this.setId(id);
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	

}
