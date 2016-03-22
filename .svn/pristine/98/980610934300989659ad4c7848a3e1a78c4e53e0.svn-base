package com.scs.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.scs.dao.UserDAO;
import com.scs.dao.UserProjectDao;
import com.scs.model.ProjectsLinkedToUser;
import com.scs.model.UserProjects;
import com.scs.model.UserRole;
import com.scs.model.UsersLinkedToProject;

/**
 * This Service is used to serve to user related query Authors : Nikhil
 */

@Service(value = "userServiceDetails")
public class UserServiceDetails implements UserDetailsService {

	@Id
	String id;
	String name;
	String password;
	String email;
	boolean isActive;
	List<UserRole> role;
	String createdBy;
	Date createdDate;
	String modifiedBy;
	Date modifiedDate;
	@Resource
	private UserDAO userRepositoryDao;
	@Resource
	private UserProjectDao userProjectDao;
	 
	@Autowired
	public MongoTemplate mongoTemplate;
	private final Logger logger = LoggerFactory.getLogger(getClass());

	private org.springframework.security.core.userdetails.User userdetails;

	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		boolean enabled = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		com.scs.model.User user = getUserDetail(username);

		userdetails = new User(user.getUsername(), user.getPassword(), enabled,
				accountNonExpired, credentialsNonExpired, accountNonLocked,
				getAuthorities(user.getRole()));
		return userdetails;
	}

	public List<GrantedAuthority> getAuthorities(String role) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		if ("ADMIN".equalsIgnoreCase(role)) {
			authList.add(new SimpleGrantedAuthority("ADMIN"));

		} else {
			authList.add(new SimpleGrantedAuthority("ROLE_CAMPAIGN"));
		}
		System.out.println(authList);
		return authList;
	}

	public com.scs.model.User getUserDetail(String username) {
		com.scs.model.User user = userRepositoryDao.findByUsername(username);
		return user;
	}
	
	public com.scs.model.User save(com.scs.model.User user) {
		com.scs.model.User scsUser = userRepositoryDao.save(user);
		return user;
	}
	/*get all project names for Registration form*/
	
	public List<ProjectsLinkedToUser> getAllProjectNames() {
		List<ProjectsLinkedToUser> projectList = new ArrayList<ProjectsLinkedToUser>();
		List<UserProjects> userProjects = userProjectDao.findAll();
		for(UserProjects userProject : userProjects){
			ProjectsLinkedToUser projectDetail = new ProjectsLinkedToUser();
			projectDetail.setServerUrl(userProject.getPath());
			projectDetail.setProject(userProject.getProjectName());
			projectList.add(projectDetail);
		}
		return projectList;
	}
	
	/* get list of users authorized for a Project */
	public List<UsersLinkedToProject> getAllUsersLinkedToProject(String projectName) {
		UserProjects project = userProjectDao.findByProjectName(projectName);
		return project.getUsersLinkedToProject();
	}
	
	
	/* get list of project authorized for a user */
	public List<ProjectsLinkedToUser> getAllProjectNamesLinkedToUser(String userName) {
		com.scs.model.User userProjects = userRepositoryDao.findByUsername(userName);
		List<ProjectsLinkedToUser> activeUser = new ArrayList<ProjectsLinkedToUser>();
		for(ProjectsLinkedToUser user : userProjects.getProjectsLinkedToUser()){
			if(user.isActive()){
				activeUser.add(user);
			}
		}
		return activeUser;
	}
	
	/* get project details from scs_project with project Name*/
	public  UserProjects getProjectDetailsByProjectName(String projectName) {
		UserProjects userProjects = userProjectDao.findByProjectName(projectName);
		return userProjects;
	}
	
	public  UserProjects updateProjectDetailsByProjectName(String projectName , UsersLinkedToProject usersLinkedToProject) {
		UserProjects userProjects = userProjectDao.findByProjectName(projectName);
		userProjects.getUsersLinkedToProject().add(usersLinkedToProject);
		userProjectDao.save(userProjects);
		return userProjects;
	}
	
	public void saveUserDetails(com.scs.model.User user, UserProjects userProject) {

		try {
			userRepositoryDao.save(user);
			if(userProject != null){
				userProjectDao.save(userProject);
			}
			  
		} catch (Exception e) {
			logger.info("error while saveUserDetails : "+e);
		}
		
	}
	
	public  Map<String , String> activateUser(String userName, String projectName) {
		UserProjects userProjects = getProjectDetailsByProjectName(projectName);
		Map<String , String> response = new HashMap<String , String>();
		for(UsersLinkedToProject users : userProjects.getUsersLinkedToProject()){
			if(users.getUserName().equalsIgnoreCase(userName)){
				users.setActive(true);
			}
		}
		
		com.scs.model.User userAllProjects = userRepositoryDao.findByUsername(userName);
		List<ProjectsLinkedToUser> allProjects = userAllProjects.getProjectsLinkedToUser();
		for(ProjectsLinkedToUser project : allProjects){
			if(project.getProject().equalsIgnoreCase(projectName)){
				project.setActive(true);
			}
		}
		userProjectDao.save(userProjects);
		userRepositoryDao.save(userAllProjects);
		response.put("success" , "Y");
		return response;
	}
	
	public Map<String , String> deActivateUser(String userName, String projectName) {
		UserProjects userProjects = getProjectDetailsByProjectName(projectName);
		Map<String , String> response = new HashMap<String , String>();
		for(UsersLinkedToProject users : userProjects.getUsersLinkedToProject()){
			if(users.getUserName().equalsIgnoreCase(userName)){
				users.setActive(false);
			}
		}
		com.scs.model.User userAllProjects = userRepositoryDao.findByUsername(userName);
		List<ProjectsLinkedToUser> allProjects = userAllProjects.getProjectsLinkedToUser();
		for(ProjectsLinkedToUser project : allProjects){
			if(project.getProject().equalsIgnoreCase(projectName)){
				project.setActive(false);
			}
		}
		userProjectDao.save(userProjects);
		userRepositoryDao.save(userAllProjects);
		response.put("success" , "Y");
		return response;
	}
	
}
