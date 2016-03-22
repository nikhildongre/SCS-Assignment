package test.com.scs.controller;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

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
import org.springframework.mock.web.MockHttpServletRequest;
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
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.scs.controller.LoginController;
import com.scs.service.impl.FileServiceImpl;
import com.scs.service.impl.UserServiceDetails;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:WebContent/WEB-INF/scs-servlet.xml",
	"file:WebContent/WEB-INF/security-config.xml","file:WebContent/WEB-INF/mongo-config.xml"})
public class LoginControllerTest {

		//Mock required classes as below
	   
	    @Mock
	    UserServiceDetails userServiceDetails;
	    
	  	@InjectMocks
		LoginController loginController;
		
	  	Exception ex;
	  	
		@Mock
		User user;
		
		
		@Mock
		ModelMap model=new ModelMap();;
	
		private MockMvc mockMvc;
		
		@Mock
		SecurityContextHolder securityContextHolder;
		
		Authentication auth;
		
		@Mock
		FileServiceImpl fileServiceImpl;
		
	
	/*//Set Class, Method, Variable, attributes required variables before Test methods call
		@Configuration
		public class SetupTestConfig {

		@Bean
		public Principal createMockPrincipal()  {
		    Principal principal = Mockito.mock(Principal.class);
		    Mockito.when(principal.getName()).thenReturn("ADMIN");  
		    return principal;
		}
		}*/
		
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		 
        // Setup Spring test in standalone mode
        this.mockMvc = MockMvcBuilders.standaloneSetup(loginController).build();
        user=(org.springframework.security.core.userdetails.User)loadUserByUsername("ADMIN"); 
        auth = new UsernamePasswordAuthenticationToken ((org.springframework.security.core.userdetails.User) user,user);
        SecurityContextHolder.getContext().setAuthentication(auth);
 
              
	}

	

	
	
	/**
	 * Method : testLogin
	 * This Method used to check login screen working properly and return expected view or not	
	 * @throws Exception
	 */
	@Test
	@ExceptionHandler(Exception.class)
    public void testLogin() throws Exception {
		
		//This one way to call url methods. For this type testing required different name for mapping URL and return view name
		
		/*MvcResult result=this.mockMvc.perform(MockMvcRequestBuilders.get("/logon").principal(auth)).
    			andExpect(MockMvcResultMatchers.status().isOk()).
    	andExpect(MockMvcResultMatchers.forwardedUrl("login")).andReturn();
    	
    	 Assert.assertNotNull(result.getModelAndView());*/
	     
		Assert.assertEquals(loginController.login(model), "login");
    	 
    }
	
	/**
	 * Method : testChange
	 * This Method used to check change password link working properly or not and returned expected view of change password screen	
	 * @throws Exception
	 */
	@Test
    public void testChange() throws Exception {
		
		MvcResult result=this.mockMvc.perform(MockMvcRequestBuilders.get("/change")).
    			andExpect(MockMvcResultMatchers.status().isOk()).
    	andExpect(MockMvcResultMatchers.forwardedUrl("changepassword")).andReturn();
    	
    	 Assert.assertNotNull(result.getModelAndView());
	     //user=(org.springframework.security.core.userdetails.User)loadUserByUsername("admin");  
    	 
    }
	
	
	/**
	 * Method : testAccessDenied
	 * This Method used to check unauthorized  user nevigated to appropriate view	
	 * @throws Exception
	 */
	@Test
    public void testAccessDenied() throws Exception {
		
		MvcResult result=this.mockMvc.perform(MockMvcRequestBuilders.get("/accessdenied")).
    			andExpect(MockMvcResultMatchers.status().isOk()).
    	andExpect(MockMvcResultMatchers.forwardedUrl("denied")).andReturn();
    	
    	 Assert.assertNotNull(result.getModelAndView());
	     //user=(org.springframework.security.core.userdetails.User)loadUserByUsername("admin");  
    	 
    }

	
	/**
	 * Method : testPassowrd
	 * This Method used to check the user is new user or old user. If new user then it will be redirected to change password screen else redirected to welcome screen.	
	 * @throws Exception
	 */
	@Test
	//@ExceptionHandler(Exception.class)
	public void testPassowrd() throws Exception {
		
		com.scs.model.User newUser=new com.scs.model.User();
		newUser.setUsername("amdin");
		Mockito.when(userServiceDetails.getUserDetail(user.getUsername())).thenReturn(newUser);
		Mockito.when(userServiceDetails.save(newUser)).thenReturn(newUser);
		
    	MvcResult result=this.mockMvc.perform(MockMvcRequestBuilders.post("/changepassword").param("confirmPassword", "abc123")
    			.param("newPassword", "abc123").principal(auth)).
    	andExpect(MockMvcResultMatchers.forwardedUrl("welcome")).andExpect(MockMvcResultMatchers.model().attribute("error", "New password and current password cannot be same"))
    			.andReturn();
    	
    	assertEquals("welcome", result.getModelAndView().getViewName());
    	
    	result=this.mockMvc.perform(MockMvcRequestBuilders.post("/changepassword").param("confirmPassword", "welcome@123")
    			.param("newPassword", "welcome@123").principal(auth)).
    	andExpect(MockMvcResultMatchers.forwardedUrl("welcome")).andExpect(MockMvcResultMatchers.model().attribute("error", "New password and current password cannot be same"))
    			.andReturn();
    	
    	assertEquals("welcome", result.getModelAndView().getViewName());
    	
      }
	
	
	/**
	 * Method : testWelcome
	 * After successful login user redirected to welcome screen (Home page)
	 * @throws Exception
	 */
	@Test
	@ExceptionHandler(Exception.class)
	public void testWelcome() throws Exception {
		
		MockHttpServletRequest myrequest = Mockito.mock(MockHttpServletRequest.class);
		myrequest.addUserRole("ADMIN");
		JSONObject json = Mockito.mock(JSONObject.class);
		 json.put("versionid1", "v1");
	     json.put("id1version", "v2");
	     json.put("isSuccess", true);
	     
		fileServiceImpl=Mockito.mock(FileServiceImpl.class);
		Mockito.when(fileServiceImpl.getContentsForCompare("pom.xml","2.4","1.5", "sourabh")).thenReturn(json);
		
		//Handle true senarioes
		Mockito.when(myrequest.isUserInRole("ADMIN")).thenReturn(true);
		assertEquals(loginController.welcome(model, myrequest),"admin");
		
		//Handle false senarioes with default password
		Mockito.when(myrequest.isUserInRole("ADMIN")).thenReturn(false);
    	assertEquals(loginController.welcome(model, myrequest),"changepassword");
		
		//Handle false senarioes with other password
		user=(org.springframework.security.core.userdetails.User)loadUserByUsername1("ADMIN"); 
	    auth = new UsernamePasswordAuthenticationToken ((org.springframework.security.core.userdetails.User) user,user);
	    SecurityContextHolder.getContext().setAuthentication(auth);
		Mockito.when(myrequest.isUserInRole("ADMIN")).thenReturn(false);
    	assertEquals(loginController.welcome(model, myrequest),"welcome");
  	
    	
		
    	
    	
    	
    	
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
		System.out.println("**************************** "+authList);
		return authList;
	}
	
	public UserDetails loadUserByUsername1(String username)
			throws UsernameNotFoundException {
		
		boolean enabled = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		
		User user = new org.springframework.security.core.userdetails.User("ADMIN", "welcome@1234", enabled,accountNonExpired, credentialsNonExpired, accountNonLocked,getAuthorities("ADMIN"));
		return user;
	}
	
	@Test
	public void cloneProjectTest(){
		Assert.assertEquals(loginController.cloneProject(model),"cloneProject");
	}
	
	@Test
	public void handleAllExceptionTest(){
		Assert.assertEquals(loginController.handleAllException(model, ex), "error");
	}
	
	@Test
	public void defaultPageTest(){
		Assert.assertEquals(loginController.defaultPage(model), "redirect:/");
	}
	
	

}
