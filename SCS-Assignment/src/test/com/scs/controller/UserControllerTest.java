package test.com.scs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;

import com.scs.controller.UserController;
import com.scs.model.ProjectsLinkedToUser;
import com.scs.model.UserProjects;
import com.scs.model.UsersLinkedToProject;
import com.scs.service.MailService;
import com.scs.service.impl.FileServiceImpl;
import com.scs.service.impl.UserServiceDetails;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:WebContent/WEB-INF/scs-servlet.xml",
	"file:WebContent/WEB-INF/security-config.xml","file:WebContent/WEB-INF/mongo-config.xml"})
public class UserControllerTest {
	
	@Mock
	UserServiceDetails userServiceDetails;
	
	@Mock
	FileServiceImpl fileServiceImpl;
	
	@Mock
	MailService mailService;
	
	@InjectMocks
	UserController userController;
	
	private MockMvc mockMvc;
	
	@Mock
	User user;
	
	@Mock
	ModelMap model=new ModelMap();
	
	@Mock
	SecurityContextHolder securityContextHolder;
	
	Authentication auth;
	
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		 
        // Setup Spring test in standalone mode
        this.mockMvc = MockMvcBuilders.standaloneSetup(userController).build();
        user=(org.springframework.security.core.userdetails.User)loadUserByUsername("ADMIN"); 
      
        auth = new UsernamePasswordAuthenticationToken((org.springframework.security.core.userdetails.User) user,user);
        SecurityContextHolder.getContext().setAuthentication(auth);
        Mockito.mock(UserServiceDetails.class);
               
	}
	
	@Test
	public void testGetUserDetails(){
		Assert.assertEquals("userDetails", userController.getUserDetails(model));
	}
	
	@Test
	public void testGetUserProfile(){
		Assert.assertEquals("userProfile", userController.userProfile(model));
	}
	
	
	
	@Test
	public void getgetAllProjectNames(){
			
		Mockito.when((List<ProjectsLinkedToUser>)userServiceDetails.getAllProjectNames()).thenReturn(getAllProjectNames());
		
		Assert.assertEquals(userController.getAllProjectNames().size(), 2);
        
	}
	
	@Test
	public void getAllUsersLinkedToProject(){
		String ProjectName=null;
		Mockito.when((List<UsersLinkedToProject>)userServiceDetails.getAllUsersLinkedToProject("")).thenReturn(getAllUsersLinkedToProject("abc"));
		Assert.assertEquals(userController.getAllUsersLinkedToProject("").size(), 2);
        
	}
	
	@Test
	public void getAllProjectNamesLinkedToUser(){
		Mockito.when(userServiceDetails.getAllProjectNamesLinkedToUser(auth.getName())).thenReturn(getAllProjectNames());
		Assert.assertEquals(2, userController.getAllProjectNamesLinkedToUser(auth).size());
	}
	
	@Test
	public void activateUser(){
		String userName="admin";
		String projectName="SCS";
		
		Map<String , String> response = new HashMap<String , String>();
		response.put("success" , "Y");
		//response.put("fail" , "N");
		
		Mockito.when(userServiceDetails.activateUser(userName , projectName)).thenReturn(response);
		Assert.assertEquals(1, userController.activateUser(userName, projectName).size());
		
	}
	
	@Test
	public void deActivateUser(){
		String userName="admin";
		String projectName="SCS";
		
		Map<String , String> response = new HashMap<String , String>();
		response.put("success" , "Y");
		//response.put("fail" , "N");
		
		Mockito.when(userServiceDetails.deActivateUser(userName , projectName)).thenReturn(response);
		Assert.assertEquals(1, userController.deActivateUser(userName, projectName).size());
		
	}
	
	@Test
	public void saveUserTest(){
		MockHttpServletRequest request=Mockito.mock(MockHttpServletRequest.class);
		HttpServletResponse response=Mockito.mock(HttpServletResponse.class);
		
		Mockito.when(request.getParameter("userName")).thenReturn("prk");
		Mockito.when(request.getParameter("userRole")).thenReturn("pa");
		
		Mockito.when(userServiceDetails.getUserDetail("userName")).thenReturn(getUser());
		
		Assert.assertEquals(userController.saveUser(model, request, response, auth), "admin");
		
		Mockito.when(request.getParameter("rootFolderName")).thenReturn("/pdf");
		UserProjects projects=Mockito.mock(UserProjects.class);
		projects.setPath("/src/com");
		projects.setProjectName("pdf");
		projects.setId("1.0");
		projects.setUsersLinkedToProject(null);
		String rootFolderName=null;
		Mockito.when(userServiceDetails.getProjectDetailsByProjectName(rootFolderName)).thenReturn(projects);
		Assert.assertEquals(userController.saveUser(model, request, response, auth), "admin");
		
		UserProjects userProjects=null;
		userServiceDetails=Mockito.mock(UserServiceDetails.class); 
		Mockito.when(userServiceDetails.getProjectDetailsByProjectName("rootFolderName")).thenReturn(userProjects);
		Assert.assertEquals(userController.saveUser(model, request, response, auth), "admin");
		
		String[] projectUrl=new String[]{"pdf","src"};
		Mockito.when(request.getParameterValues("projectUrl")).thenReturn(projectUrl);	
		Mockito.when(request.getParameter("userRole")).thenReturn("pa1");
		Assert.assertEquals(userController.saveUser(model, request, response, auth), "admin");
		
		Mockito.when(userServiceDetails.getUserDetail("userName")).thenReturn(null);
		Assert.assertEquals(userController.saveUser(model, request, response, auth), "admin");
		
		
		
	}
	
	public List<ProjectsLinkedToUser> getAllProjectNames() {
		List<ProjectsLinkedToUser> projectList = new ArrayList<ProjectsLinkedToUser>();
		//List<UserProjects> userProjects = userProjectDao.findAll();
		
			ProjectsLinkedToUser projectDetail = new ProjectsLinkedToUser();
			projectDetail.setServerUrl("/scs/");
			projectDetail.setProject("SCS");
			projectList.add(projectDetail);
			
			ProjectsLinkedToUser projectDetail1 = new ProjectsLinkedToUser();
			projectDetail1.setServerUrl("/Pizza/");
			projectDetail1.setProject("Pizza");
			projectList.add(projectDetail1);
		
		return projectList;
	} 

	public List<UsersLinkedToProject> getAllUsersLinkedToProject(String projectName) {
		List<UsersLinkedToProject> linkedUser=new ArrayList<>();
		UsersLinkedToProject list=new UsersLinkedToProject();
		list.setActive(true);
		list.setUserName("sourabh");
		linkedUser.add(list);
		list.setActive(false);
		list.setUserName("prashant");
		linkedUser.add(list);
		
		return linkedUser;
	}
	
	/**
	 * Method : loadUserByUsername
	 * This method helps to create dummy user that required to check LoginController class.
	 * @throws Exception
	 */
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		
		boolean enabled = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		
		User user = new org.springframework.security.core.userdetails.User("ADMIN", "welcome@123", enabled,accountNonExpired, credentialsNonExpired, accountNonLocked,getAuthorities("ADMIN"));
		return user;
	}
	
	public List<GrantedAuthority> getAuthorities(String role) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		if ("ADMIN".equalsIgnoreCase(role)) {
			authList.add(new SimpleGrantedAuthority("ADMIN"));

		}
		//System.out.println("**************************** "+authList);
		return authList;
	}
	
	public com.scs.model.User getUser(){
		com.scs.model.User user=new com.scs.model.User();
		user.setActive(true);
		user.setCreatedBy("admin");
		user.setEmail("abc@persistent.com");
		user.setUsername("prk");
		
		return user;
	}
	
	/*@Test
	public void AddUser(){
		
		MockHttpServletRequest request=Mockito.mock(MockHttpServletRequest.class);
		MockHttpServletResponse response=Mockito.mock(MockHttpServletResponse.class);
		
		com.scs.model.User users=new com.scs.model.User();
		users.setUsername("abc");
		users.setModifiedBy("xyz");
		
				
		String projectName=null;
		
		List<UsersLinkedToProject> linkedUser=new ArrayList<>();
		UsersLinkedToProject list=new UsersLinkedToProject();
		list.setActive(true);
		list.setUserName("sourabh");
		linkedUser.add(list);
		
		
		String userName=null;
		String userProject=null ;
		UserProjects userProjects =new UserProjects();
		Mockito.when(request.getParameter("userName")).thenReturn("Admin");
		Mockito.when(request.getParameter("userRole")).thenReturn("Admin");
		UserProjects projects=new UserProjects();
		projects.setPath("/abc");
		projects.setProjectName("scsProjects");
		
		Mockito.when(userServiceDetails.getProjectDetailsByProjectName(projectName)).thenReturn(projects);
		
		List<UsersLinkedToProject> usersLinkedToProjectList = new ArrayList<UsersLinkedToProject>();
		
		
		userProjects.setPath("/pbc");
		userProjects.setProjectName("scsProject1");
		
		ArrayList<UsersLinkedToProject> mockArrayList=Mockito.mock(ArrayList.class);
		userProjects.getUsersLinkedToProject().add(list);
		//Mockito.when(userProjects.getUsersLinkedToProject().add(list)).thenReturn(usersLinkedToProjectList)
		Mockito.when(userServiceDetails.getUserDetail(userName)).thenReturn((com.scs.model.User)users);
		
		Assert.assertSame("admin", userController.saveUser(model, request, response, auth));
	}*/
	
}
