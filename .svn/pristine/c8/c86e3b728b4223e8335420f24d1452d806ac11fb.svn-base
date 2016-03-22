package test.com.scs.controller;

import static org.junit.Assert.*;

import org.json.simple.JSONObject;
import org.junit.Before;
import org.junit.Test;


import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.scs.controller.CompareController;
import com.scs.controller.UserController;
import com.scs.service.impl.FileServiceImpl;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:WebContent/WEB-INF/scs-servlet.xml",
	"file:WebContent/WEB-INF/security-config.xml","file:WebContent/WEB-INF/mongo-config.xml"})
public class CompareControllerTest {

	@Mock
	FileServiceImpl fileServiceImpl;
	
	private MockMvc mockMvc;

	
	@InjectMocks
	CompareController compareController;
	
	@Before
	public void setUp() throws Exception {
		
		MockitoAnnotations.initMocks(this);
		 
        // Setup Spring test in standalone mode
        this.mockMvc = MockMvcBuilders.standaloneSetup(compareController).build();
	}
	
	@Test
    public void testComapreVersions() throws Exception {
		/*MvcResult result=this.mockMvc.perform(MockMvcRequestBuilders.post("/compare")).
    			andExpect(MockMvcResultMatchers.status().isOk()).andReturn();*/
		JSONObject json=new JSONObject();
		json.put("versionid2",null);
		json.put("versionid1","fgvkbghjbjh");
		json.put("id1version","1.1");
		json.put("id2version","1");
		json.put("isSuccess",true);
		
		
		Mockito.when( (JSONObject)fileServiceImpl.getContentsForCompare("","","",""))
		.thenReturn( json);
		
		JSONObject json1=new JSONObject();
		json1=compareController.compareVersions("","","","");
		
		assertEquals(json1.get("versionid1"), "fgvkbghjbjh");
		
		
	}

	

}
