package com.scs.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.types.BSONTimestamp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scs.model.ProjectsLinkedToUser;
import com.scs.model.User;
import com.scs.model.UserProjects;
import com.scs.model.UsersLinkedToProject;
import com.scs.service.MailService;
import com.scs.service.impl.FileServiceImpl;
import com.scs.service.impl.UserServiceDetails;

@Controller
public class UserController {

	
	
	@Autowired
	UserServiceDetails userServiceDetails;
	
	@Autowired
	FileServiceImpl fileServiceImpl;
	
	@Autowired
	MailService mailService;
	
	
	@RequestMapping(value = "/userDetails", method = RequestMethod.GET)
	public String getUserDetails(ModelMap model) {
		return "userDetails";
	}
	
	@RequestMapping(value = "/userProfile", method = RequestMethod.GET)
	public String userProfile(ModelMap model) {
		return "userProfile";
	}


	@RequestMapping(value = "/getAllProjectNames" ,method = RequestMethod.GET , produces = "application/json")
	@ResponseBody
	public List<ProjectsLinkedToUser> getAllProjectNames() {
		List<ProjectsLinkedToUser> projectList = null;
		projectList = userServiceDetails.getAllProjectNames();
		return projectList;
	}
	
	@RequestMapping(value = "/getAllProjectNamesLinkedToUser" ,method = RequestMethod.GET , produces = "application/json")
	@ResponseBody
	public List<ProjectsLinkedToUser> getAllProjectNamesLinkedToUser(Principal principal) {
		List<ProjectsLinkedToUser> projectList = null;
		//TODO : get userName from session / spring security
		projectList = userServiceDetails.getAllProjectNamesLinkedToUser(principal.getName());
		return projectList;
	}

	@RequestMapping(value = "/getAllUsersLinkedToProject" ,method = RequestMethod.GET , produces = "application/json")
	@ResponseBody
	public List<UsersLinkedToProject> getAllUsersLinkedToProject(@RequestParam("projectName") String projectName) {
		List<UsersLinkedToProject> userList = null;
		userList = userServiceDetails.getAllUsersLinkedToProject(projectName);
		return userList;
	}
	
	 @RequestMapping(value = "/AddUser", method = RequestMethod.POST)
		public String saveUser(ModelMap model,HttpServletRequest request, HttpServletResponse response,Principal principal) {
		
		 
		 String userName =  request.getParameter("userName");
		 User existingUser = userServiceDetails.getUserDetail(userName);
		 if(existingUser == null){
			 String userRole = request.getParameter("userRole");
			 	String createdBy = principal.getName();
				if(userRole.equalsIgnoreCase("pa")){
					//check if the project is already exist or not
					String rootFolderName =  request.getParameter("rootFolderName");
					UserProjects userProjects = userServiceDetails.getProjectDetailsByProjectName(rootFolderName);
					if(userProjects == null){
						//make an entry in scs_project : as it would be new project with "pa" as the first user.
						UserProjects userProject = setUserProjectsDetails(request, response); 
						//make an entry to scs_user : update the project url list for that user.
						User user = setUserDetails(request, response,createdBy);
						userServiceDetails.saveUserDetails(user,userProject);
						//make an entry in scs_filestructure : as it would be root file of the new project.
						createRootFileDocument(request, response,createdBy);
						mailService.sendMail(user.getUsername(), user.getEmail(), user.getPassword());
						model.addAttribute("addUserResultMsg", userName+" user created successfully.");
					}else{
						model.addAttribute("addUserResultMsg", "project '"+ rootFolderName +"' already exist. Please try with some other user name");
					}
				
				}else{
					
					//make an entry in scs_project : update the user list(add this user to that list)
					UserProjects userProject = setUserProjectsDetails(request, response); 
					//make an entry to scs_user : update the project url list for that user.
					User user = setUserDetails(request, response,createdBy);
					
					userServiceDetails.saveUserDetails(user,userProject);
					mailService.sendMail(user.getUsername(), user.getEmail(), user.getPassword());
					model.addAttribute("addUserResultMsg", userName+" user created successfully.");
				}	
		 }else{
			 model.addAttribute("addUserResultMsg", "user '"+ userName +"' already exist. Please try with some other user name");
		 }
			return "admin";
		} 

	 private User setUserDetails(HttpServletRequest request, HttpServletResponse response,String createdBy){
		 
		 	User user = new User();
			user.setUsername(request.getParameter("userName"));
			user.setPassword("welcome@123"); //Default Password
			user.setEmail(request.getParameter("email"));
			user.setActive(true);
			user.setCreatedBy(createdBy);  
			user.setCreatedDate(new BSONTimestamp( ));
			List<ProjectsLinkedToUser> projectsLinkedToUsers=new ArrayList<ProjectsLinkedToUser>();
			
			String userRole = request.getParameter("userRole");
			if(userRole.equalsIgnoreCase("pa")){
				ProjectsLinkedToUser projectsLinkedToUser = new ProjectsLinkedToUser();
				String rootFolderName =  request.getParameter("rootFolderName");
				projectsLinkedToUser.setProject(rootFolderName);
				projectsLinkedToUser.setServerUrl(rootFolderName);
				projectsLinkedToUser.setActive(true);
				projectsLinkedToUsers.add(projectsLinkedToUser);
			}else{
				String[] projectNames =  request.getParameterValues("projectUrl");
				for(String projectName : projectNames){
					ProjectsLinkedToUser projectsLinkedToUser = new ProjectsLinkedToUser();
					projectsLinkedToUser.setProject(projectName);
					projectsLinkedToUser.setServerUrl(projectName);
					projectsLinkedToUser.setActive(true);
					projectsLinkedToUsers.add(projectsLinkedToUser);
				}
			}
			user.setProjectsLinkedToUser(projectsLinkedToUsers);
		    return user;
	 }
	 
	 private UserProjects setUserProjectsDetails(HttpServletRequest request, HttpServletResponse response){
		 
		 String userRole = request.getParameter("userRole");
		 UsersLinkedToProject usersLinkedToProject = new UsersLinkedToProject();
		 usersLinkedToProject.setUserName(request.getParameter("userName"));
		 usersLinkedToProject.setActive(true);
		 UserProjects userProjects =  null;
		 if(userRole.equalsIgnoreCase("pa")){
			    String rootFolderName =  request.getParameter("rootFolderName");
			 	List<UsersLinkedToProject> usersLinkedToProjectList = new ArrayList<UsersLinkedToProject>();
			 	usersLinkedToProjectList.add(usersLinkedToProject);
			 	userProjects = new UserProjects();
			 	userProjects.setPath(rootFolderName);
			 	userProjects.setProjectName(rootFolderName);
			 	userProjects.setUsersLinkedToProject(usersLinkedToProjectList);
			 	return userProjects;
			}else{
				String[] projectNames =  request.getParameterValues("projectUrl");
				for(String projectName : projectNames){
				 userProjects = userServiceDetails.updateProjectDetailsByProjectName(projectName,usersLinkedToProject);
				}
				return null;
			}
	
		 
	 }
	 
	 private void createRootFileDocument(HttpServletRequest request, HttpServletResponse response,String createdBy){
		
		 String rootFolderName =  request.getParameter("rootFolderName");
		 fileServiceImpl.createRoot(rootFolderName , createdBy); 
	 }
	 
	 @RequestMapping(value = "/activateUser" ,method = RequestMethod.GET , produces = "application/json")
		@ResponseBody
		public Map<String , String> activateUser(@RequestParam("userName") String userName , @RequestParam("projectName") String projectName) {
		 Map<String , String> response = userServiceDetails.activateUser(userName , projectName);
			return response;
		}
	 
	 @RequestMapping(value = "/deActivateUser" ,method = RequestMethod.GET , produces = "application/json")
		@ResponseBody
		public Map<String , String> deActivateUser(@RequestParam("userName") String userName , @RequestParam("projectName") String projectName) {
		 Map<String , String> response = userServiceDetails.deActivateUser(userName , projectName);
			return response;
		}
	
}
