package com.scs.model;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "scs_project")
public class UserProjects {

	@Id
	String id;
	String projectName;
	String path;
	List<UsersLinkedToProject> usersLinkedToProject;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public List<UsersLinkedToProject> getUsersLinkedToProject() {
		return usersLinkedToProject;
	}
	public void setUsersLinkedToProject(
			List<UsersLinkedToProject> usersLinkedToProject) {
		this.usersLinkedToProject = usersLinkedToProject;
	}
	
	
}
