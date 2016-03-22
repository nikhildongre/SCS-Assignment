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
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.scs.controller.RollbackController;
import com.scs.service.impl.FileServiceImpl;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:WebContent/WEB-INF/scs-servlet.xml",
	"file:WebContent/WEB-INF/security-config.xml","file:WebContent/WEB-INF/mongo-config.xml"})
public class RollabackControllertest {

	
	@InjectMocks
	RollbackController  RollabackController1;
	
	@Mock
	FileServiceImpl fileServiceImpl;
	
	
private	MockMvc mocMvc;
	
	@Before
	public void setUp() throws Exception {

		MockitoAnnotations.initMocks(this);
		this.mocMvc = MockMvcBuilders.standaloneSetup(RollabackController1).build();
	
	}

	@Test
	public void getVersion() {
		Mockito.when( (String)RollabackController1.getVersions(""))
		.thenReturn( "/scr/dao/hello");
		assertEquals(RollabackController1.getVersions(""), "/scr/dao/hello");	
	}

	
	@Test
	public void rollbackToAVersion() {
		Mockito.when( (JSONObject)RollabackController1.rollbackToAVersion("",""))
		.thenReturn( createjson());
		assertEquals(RollabackController1.rollbackToAVersion("", "").get("name"),"pom.xml");	
	}
	

	JSONObject createjson() {
		 JSONObject json=new JSONObject();
		 json.put("name", "pom.xml");
		 json.put( "path", "scsProject/");
		 json.put("parentNodeId", "56d83d8248bbf5bccc7c412e");
		 json.put( "children", false);
		 json.put(  "isLocked", false);
		 json.put( "lockedBy", "");
		 json.put("isFile", true);
		 json.put( "isRootFolder", false);
		 json.put("currentVersion" , "1.0");
		 json.put( "extension", "xml");
		 json.put("isDeleted", true);
		 json.put("deletedBy" , "abhijeet");
		 json.put("createdDate", "2016-03-08T11:54:45.569Z");
		 JSONObject js=new JSONObject();
		 js.put("versionNo" , "1.0");
		 js.put( "revisionNo" ,1);
		 js.put( "comments" ,"first version");
		 js.put("modifiedBy" , "Admin");
		 json.put( "versions", js);
		 return json;
	}

	 
	
	     
	 
	 	

}
