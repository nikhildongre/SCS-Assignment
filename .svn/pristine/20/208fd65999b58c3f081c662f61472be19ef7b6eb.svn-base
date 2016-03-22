package test.com.scs.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import com.scs.controller.FileController;
import com.scs.model.FileLockedByUser;
import com.scs.model.Node;
import com.scs.service.RetriveFileService;
import com.scs.service.impl.FileServiceImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:WebContent/WEB-INF/scs-servlet.xml",
		"file:WebContent/WEB-INF/security-config.xml",
		"file:WebContent/WEB-INF/mongo-config.xml" })
public class FileControllerTest {

	@InjectMocks
	FileController fileController;

	@Mock
	FileServiceImpl fileServiceImpl;

	// @Mock
	// Node file;

	@Mock
	User user;

	@Mock
	List<Node> list;

	@Mock
	ModelMap model = new ModelMap();;
	@Mock
	RetriveFileService retriveFileService;

	private MockMvc mockMvc;

	@Mock
	Principal principle;

	Authentication auth;

	@Mock
	HttpServletRequest req;

	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);

		// Setup Spring test in standalone mode
		this.mockMvc = MockMvcBuilders.standaloneSetup(fileController).build();
		user = (org.springframework.security.core.userdetails.User) loadUserByUsername("ROLE_CAMPAIGN");

		auth = new UsernamePasswordAuthenticationToken(
				(org.springframework.security.core.userdetails.User) user, user);
		SecurityContextHolder.getContext().setAuthentication(auth);
		req = Mockito.mock(HttpServletRequest.class);

		Mockito.when(req.isUserInRole("ROLE_CAMPAIGN")).thenReturn(true);
	}

	// @SuppressWarnings("unchecked")

	@Test
	public void testGetProjectChilds() {
		List<Node> list = new ArrayList<Node>();
		Node node = new Node();

		node.setFile(true);
		node.setFileName("abc");
		node.setParentNodeId("1");

		list.add(node);
		Mockito.when(fileController.getProjectChilds("1")).thenReturn(list);

		List<Node> newList = (List<Node>) fileController.getProjectChilds("1");
		Assert.assertEquals(fileController.getProjectChilds("1").size(), 1);

	}

	@Test
	public void testGetProjectRoot() {
		Node node = new Node();

		node.setFile(true);
		node.setFileName("abc");
		node.setParentNodeId("1");

		Mockito.when(fileController.getProjectRoot("SCS")).thenReturn(node);
		Assert.assertEquals(fileController.getProjectRoot("SCS"), node);
	}

	@Test
	public void testcreateFile() {
		// Principal principal;
		Node file = fileController.createFile("txt", "t1", "abc", principle);
		Mockito.when(fileController.createFile("txt", "t1", "abc", principle))
				.thenReturn(file);
		Assert.assertEquals(
				fileController.createFile("txt", "t1", "abc", principle), file);
	}

	@Test
	public void testrenameFile() {

		Node node = new Node();

		String oldname = "old name", newName = "new name";
		node.setFile(true);
		node.setFileName(oldname);
		node.setParentNodeId("a1");
		node.setId("1");

		Node node1 = new Node();
		node1.setFile(true);
		node1.setFileName(newName);
		node1.setParentNodeId("a1");
		// node1.setId("1");

		Mockito.when(fileController.renameFile("1", newName, principle))
				.thenReturn(node1);
		Assert.assertEquals(fileController.renameFile("1", newName, principle),
				node1);

	}

	@Test(expected=Exception.class)
	public void testDeleteFile() throws Exception {
		ResponseEntity response =Mockito.mock(ResponseEntity.class);
		response = new ResponseEntity<>("Success", HttpStatus.OK);
		

		Mockito.when(fileController.deleteFile("1", principle)).thenReturn((response));

		/*MvcResult result = this.mockMvc
				.perform(
						MockMvcRequestBuilders.get("/deleteFile")
								.param("fileId", "1").principal(principle))
				.andExpect(MockMvcResultMatchers.status().isOk()).andReturn();*/
		
		Mockito.doNothing().when(fileController.deleteFile("1", principle));
		Mockito.doThrow(Exception.class);
	}

	@Test
	public void testLockFile() throws Exception {
		HashMap<String, String> messageMap = new HashMap<String, String>();
		HashMap<String, String> messageMap1 = new HashMap<String, String>();
		messageMap.put("lockedBy", "testuser");
		messageMap.put("successMsg", "true");
		Mockito.when(fileController.lockFile("1", principle)).thenReturn(
				messageMap);
		messageMap1 = fileController.lockFile("1", principle);
		Assert.assertEquals(messageMap1, messageMap);
	}

	@Test
	public void testUnLockFile() throws Exception {
		HashMap<String, String> messageMap = new HashMap<String, String>();
		HashMap<String, String> messageMap1 = new HashMap<String, String>();
		messageMap.put("lockedBy", "");
		messageMap.put("successMsg", "success");
		Mockito.when(fileController.unlockFile("1", principle)).thenReturn(
				messageMap);
		messageMap1 = fileController.unlockFile("1", principle);
		Assert.assertEquals(messageMap1, messageMap);
	}

	@Test
	public void testgetFileContent() throws Exception {
		JSONObject json = new JSONObject();
		json.put("filecontent", "hello persi");
		Mockito.when(fileController.getFileContent("abc", "1")).thenReturn(
				(json));
		JSONObject json1 = fileController.getFileContent("abc", "1");
		Assert.assertEquals(json1, json);
	}

	
	@Test
	public void getAllLockedFilesOfProject(){
		Mockito.when((List<FileLockedByUser>) retriveFileService.getFiles("")).thenReturn(list());
		Assert.assertEquals(fileController.getAllLockedFilesOfProject("").size(),1 );
		
	} 
	
	
	public List<FileLockedByUser> list() {
		List<FileLockedByUser> list=new ArrayList<>();
		FileLockedByUser	fileLockedByUser=new FileLockedByUser("123", "pom.xml", "abhi", true);
		list.add(fileLockedByUser);
		return list;
	}

	
	@Test
	public void unlockSelectedFile(){
		
		Mockito.when((String)fileServiceImpl.unlockSelectedFile("")).thenReturn("success");
		Assert.assertEquals(fileController.unlockSelectedFile(""), "success");
	}
	
	
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {

		boolean enabled = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;

		User user = new org.springframework.security.core.userdetails.User(
				"sourabh", "sourabh", enabled, accountNonExpired,
				credentialsNonExpired, accountNonLocked,
				getAuthorities("ROLE_CAMPAIGN"));
		return user;
	}

	public List<GrantedAuthority> getAuthorities(String role) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		if ("ADMIN".equalsIgnoreCase(role)) {
			authList.add(new SimpleGrantedAuthority("ADMIN"));

		} else {
			authList.add(new SimpleGrantedAuthority("ROLE_CAMPAIGN"));
		}
		System.out.println("**************************** " + authList);
		return authList;
	}

}
