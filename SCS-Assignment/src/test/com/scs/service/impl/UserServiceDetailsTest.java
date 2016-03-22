package test.com.scs.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bson.types.BSONTimestamp;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;

import com.scs.dao.FileDAO;
import com.scs.dao.SequenceDao;
import com.scs.dao.UserDAO;
import com.scs.dao.UserProjectDao;
import com.scs.model.FileDocument;
import com.scs.model.Node;
import com.scs.model.ProjectsLinkedToUser;
import com.scs.model.UserProjects;
import com.scs.model.UsersLinkedToProject;
import com.scs.service.impl.FileServiceImpl;
import com.scs.service.impl.UserServiceDetails;
import com.scs.utility.JsonUtility;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:WebContent/WEB-INF/scs-servlet.xml",
	"file:WebContent/WEB-INF/security-config.xml","file:WebContent/WEB-INF/mongo-config.xml"})
public class UserServiceDetailsTest {

	@Mock
    UserServiceDetails userServiceDetails;
	
	@Mock
	User user;
	
	@Mock
	com.scs.model.User daouser;
	/*@Mock
	FileDocumentVersion version; */
	
	@Mock
	UserDAO userRepositoryDao;
	
	@Mock
	HashMap<String, String> dummymap;
	
	@Mock
	ModelMap model=new ModelMap();
	
	@Mock
	 FileDocument file ;
	
	@Mock
	JsonUtility utility;

	private MockMvc mockMvc;
	

	@Mock
    SequenceDao sequenceDao;
	
	@Mock
	Node rootNode;
	
	@Mock
	UserProjectDao userProjectDao;
	
	@InjectMocks
	UserServiceDetails userservicedertails;
	
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		 
        // Setup Spring test in standalone mode
        this.mockMvc = MockMvcBuilders.standaloneSetup(UserServiceDetails.class).build();
	}
	
	public com.scs.model.User getUser()
	{
		  com.scs.model.User user = new com.scs.model.User();
		  user.setId("1");
		  user.setUsername("akash");
		  user.setPassword("password");
		  user.setActive(true);
		  user.setRole("admin");
		  user.setCreatedBy("admin");
		  user.setModifiedBy("admin");
		  user.setCreatedDate(new BSONTimestamp());
		  user.setModifiedDate(new BSONTimestamp());
		  
		  List<ProjectsLinkedToUser> list = new ArrayList<ProjectsLinkedToUser>();
		  ProjectsLinkedToUser project = new ProjectsLinkedToUser();
		  project.setActive(true);
		  project.setProject("scs");
		  project.setServerUrl("/serverUrl");
		  list.add(project);
		
		  user.setProjectsLinkedToUser(list);
		return user;
		
	}
	@Test
	public void testgetUserDetail()
	{
		com.scs.model.User user = getUser();
		Mockito.when(userRepositoryDao.findByUsername("akash")).thenReturn(user);
		Assert.assertEquals(user,userservicedertails.getUserDetail("akash"));
	}
	
	@Test
	public void testgetAllProjectNames()
	{
		com.scs.model.User user = getUser();
		List<UserProjects> list = new ArrayList<UserProjects>();
		UserProjects project = new UserProjects();
		project.setId("2");
		project.setPath("scs");
		project.setProjectName("scsproject");
		list.add(project);
		Mockito.when(userProjectDao.findAll()).thenReturn(list);
		
		List<ProjectsLinkedToUser> projectList = new ArrayList<ProjectsLinkedToUser>();
		
		ProjectsLinkedToUser projectDetail = new ProjectsLinkedToUser();
		projectDetail.setServerUrl(project.getPath());
		projectDetail.setProject(project.getProjectName());
		projectList.add(projectDetail);
		
		Assert.assertEquals(projectList.get(0).getServerUrl(),userservicedertails.getAllProjectNames().get(0).getServerUrl());
		
	
	}
	
	
	@Test
	public void testgetAllUsersLinkedToProject()
	{
		UserProjects project = new UserProjects();
		project.setId("2");
		project.setPath("scs");
		project.setProjectName("scsproject");
		
		List<UsersLinkedToProject> linkeduser = new ArrayList<UsersLinkedToProject>();
		UsersLinkedToProject user = new UsersLinkedToProject();
		user.setUserName("akash");
		user.setActive(true);
		linkeduser.add(user);
		project.setUsersLinkedToProject(linkeduser);
		
		Mockito.when(userProjectDao.findByProjectName("scsproject")).thenReturn(project);
		Assert.assertEquals(linkeduser,userservicedertails.getAllUsersLinkedToProject("scsproject"));
	}
	
	@Test
	public void testgetAllProjectNamesLinkedToUser()
	{
		com.scs.model.User user = getUser();
		
		List<ProjectsLinkedToUser> projectList = new ArrayList<ProjectsLinkedToUser>();
		ProjectsLinkedToUser projectDetail = new ProjectsLinkedToUser();
		UserProjects project = new UserProjects();
		project.setId("2");
		project.setPath("scs");
		project.setProjectName("scsproject");
		projectDetail.setServerUrl(project.getPath());
		projectDetail.setProject(project.getProjectName());
		projectDetail.setActive(true);
		projectList.add(projectDetail);
		user.setProjectsLinkedToUser(projectList);
		user.setActive(true);
		Mockito.when(userRepositoryDao.findByUsername("akash")).thenReturn(user);
		Mockito.when(daouser.getProjectsLinkedToUser()).thenReturn(projectList);
		Assert.assertEquals(projectList,userservicedertails.getAllProjectNamesLinkedToUser("akash"));
	}
	
	@Test
	public void testSave()
	{
		com.scs.model.User tempdaouser = getUser();
		Mockito.when(userRepositoryDao.save(tempdaouser)).thenReturn(tempdaouser);
		Assert.assertEquals(tempdaouser,userservicedertails.save(tempdaouser));
		
	}
	
	
	@Test
	public void testgetAuthorities()
	{
		List<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		auth.add(new SimpleGrantedAuthority("ADMIN"));
		Assert.assertEquals(auth,userservicedertails.getAuthorities("admin"));
		List<GrantedAuthority> auth1 = new ArrayList<GrantedAuthority>();
		auth1.add(new SimpleGrantedAuthority("ROLE_CAMPAIGN"));
		Assert.assertEquals(auth1,userservicedertails.getAuthorities("ROLE_CAMPAIGN"));
	}
	
	@Test
	public void testloadUserByUsername()
	{
		com.scs.model.User tempdaouser = getUser();
		org.springframework.security.core.userdetails.User userdetails = null;
		List<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		auth.add(new SimpleGrantedAuthority("ADMIN"));
		userdetails = new User(tempdaouser.getUsername(), tempdaouser.getPassword(), true,true, true, true,auth);
		Mockito.when(userservicedertails.getUserDetail("akash")).thenReturn(tempdaouser);
		Assert.assertEquals(userdetails, userservicedertails.loadUserByUsername("akash"));
	}
	
	@Test
	public void testActivateUser()
	{
		UserProjects project = new UserProjects();
		project.setId("2");
		project.setPath("scsproject");
		project.setProjectName("scsproject");
		List<UsersLinkedToProject> linkeduser = new ArrayList<UsersLinkedToProject>();
		UsersLinkedToProject user = new UsersLinkedToProject();
		user.setUserName("akash");
		linkeduser.add(user);
		project.setUsersLinkedToProject(linkeduser);
		Mockito.when(userservicedertails.getProjectDetailsByProjectName("scsproject")).thenReturn(project);
		
		com.scs.model.User tempdaouser = getUser();
		Mockito.when(userRepositoryDao.findByUsername("akash")).thenReturn(tempdaouser);
		List<ProjectsLinkedToUser> projectList = new ArrayList<ProjectsLinkedToUser>();
		ProjectsLinkedToUser projectDetail = new ProjectsLinkedToUser();
		projectDetail.setServerUrl(project.getPath());
		projectDetail.setProject(project.getProjectName());
		projectDetail.setActive(true);
		projectList.add(projectDetail);
		tempdaouser.setProjectsLinkedToUser(projectList);
		
		Map<String , String> response = new HashMap<String , String>();
		response.put("success" , "Y");
		Assert.assertEquals(response, userservicedertails.activateUser("akash", "scsproject"));
		
	}
	
	@Test
	public void testDeActivateUser()
	{
		UserProjects project = new UserProjects();
		project.setId("2");
		project.setPath("scsproject");
		project.setProjectName("scsproject");
		List<UsersLinkedToProject> linkeduser = new ArrayList<UsersLinkedToProject>();
		UsersLinkedToProject user = new UsersLinkedToProject();
		user.setUserName("akash");
		linkeduser.add(user);
		project.setUsersLinkedToProject(linkeduser);
		Mockito.when(userservicedertails.getProjectDetailsByProjectName("scsproject")).thenReturn(project);
		
		com.scs.model.User tempdaouser = getUser();
		Mockito.when(userRepositoryDao.findByUsername("akash")).thenReturn(tempdaouser);
		List<ProjectsLinkedToUser> projectList = new ArrayList<ProjectsLinkedToUser>();
		ProjectsLinkedToUser projectDetail = new ProjectsLinkedToUser();
		projectDetail.setServerUrl(project.getPath());
		projectDetail.setProject(project.getProjectName());
		projectDetail.setActive(true);
		projectList.add(projectDetail);
		tempdaouser.setProjectsLinkedToUser(projectList);
		
		Map<String , String> response = new HashMap<String , String>();
		response.put("success" , "Y");
		Assert.assertEquals(response, userservicedertails.deActivateUser("akash", "scsproject"));
		
	}
	
	@Test
	public void testupdateProjectDetailsByProjectName()
	{
		UserProjects project = new UserProjects();
		project.setId("2");
		project.setPath("scsproject");
		project.setProjectName("scsproject");
		List<UsersLinkedToProject> linkeduser = new ArrayList<UsersLinkedToProject>();
		UsersLinkedToProject user = new UsersLinkedToProject();
		user.setUserName("akash");
		linkeduser.add(user);
		
		UsersLinkedToProject user1 = new UsersLinkedToProject();
		user.setUserName("abhijeet");
		linkeduser.add(user1);
		
		project.setUsersLinkedToProject(linkeduser);
		Mockito.when(userservicedertails.getProjectDetailsByProjectName("scsproject")).thenReturn(project);
		Assert.assertEquals(project,userservicedertails.updateProjectDetailsByProjectName("scsproject",user1));
	}
}
