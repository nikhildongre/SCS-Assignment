package test.com.scs.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.core.io.FileSystemResourceLoader;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockServletContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.ConfigurableWebApplicationContext;
import org.springframework.web.context.support.StaticWebApplicationContext;
import org.springframework.web.context.support.XmlWebApplicationContext;

import com.scs.controller.CloneController;
import com.scs.service.RetriveFileService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:WebContent/WEB-INF/scs-servlet.xml",
	"file:WebContent/WEB-INF/security-config.xml","file:WebContent/WEB-INF/mongo-config.xml"})
public class CloneControllerTest {
	
	@InjectMocks
	CloneController cloneController;
	
	private MockMvc mockMvc;
	
	private String url;
	
	@Mock
	private MockHttpServletRequest request;
	
	@Mock
	private MockHttpServletResponse response;
	
	@Mock
	MockServletContext context;
	
	@Mock
	RetriveFileService retriveFileService;
	
	@Mock
	ModelMap model=new ModelMap();
	
	protected static ConfigurableWebApplicationContext newcontext;
	
	
	@Before
	public void setUp() throws Exception {
		 
		MockitoAnnotations.initMocks(this);
		 
		this.mockMvc = MockMvcBuilders.standaloneSetup(cloneController).build();
        url="scsProject";
       
        url="pdf";
        
            //newcontext = new XmlWebApplicationContext();
            //newcontext.setConfigLocations(new String[] { "/WEB-INF/foo-context.xml", "/WEB-INF/bar-context.xml" });
           // newcontext.setServletContext(new MockServletContext("/webapp", new FileSystemResourceLoader()));
            //newcontext.refresh();
           // newcontext.registerShutdownHook();
       
        
	}
	
	
	@Test(expected=Exception.class)
	public void getFileExceptionTest() throws IOException {
		RetriveFileService service=Mockito.mock(RetriveFileService.class);
		request= Mockito.mock(MockHttpServletRequest.class);
	    response=Mockito.mock(MockHttpServletResponse.class);
	    String realPath = "C:\\scs_new\\temp\\";
	    
	    MockServletContext context = new MockServletContext(realPath);//Mockito.mock(MockServletContext.class); 
	    context=Mockito.mock(MockServletContext.class);
	    HttpSession session=Mockito.mock(HttpSession.class);
	    request.setSession(session);
       
	    		
        
	    request = new MockHttpServletRequest(context,"myMethod","MyURL");
	    
	    
		
        System.out.println("a2");;
		Mockito.when(request.getSession().getServletContext().getRealPath("/")).thenReturn(realPath);
		Mockito.when(retriveFileService.getFiles(url, request.getSession().getServletContext().getRealPath("/"))).thenReturn("success");
		System.out.println("b2");
		
		ServletOutputStream mockOutput = Mockito.mock(ServletOutputStream.class);
		Mockito.when(response.getOutputStream()).thenReturn(mockOutput);
		
		cloneController.getFiles(response, request, url, model);
		Mockito.doThrow(new IOException()).when(response.getOutputStream());
		//Mockito.verify(response).setContentType("application/zip");
	  
		
		//Mockito.when(cloneController.getFiles(response, request, url, model)).thenThrow(new FileNotFoundException());
		//Assert.assertEquals(cloneController.getFiles(response, request, url, model), "download");
		
   
    }
	
	
	
	@Test
	public void getFileSuccessTest() throws Exception {
		RetriveFileService service=Mockito.mock(RetriveFileService.class);
		request= Mockito.mock(MockHttpServletRequest.class);
	    response=Mockito.mock(MockHttpServletResponse.class);
	    String realPath = "C:\\scs_new\\";
	    
	    MockServletContext context = new MockServletContext(realPath);//Mockito.mock(MockServletContext.class); 
	    context=Mockito.mock(MockServletContext.class);
	    HttpSession session=Mockito.mock(HttpSession.class);
	    request.setSession(session);
       
	    		
        
	    request = new MockHttpServletRequest(context,"myMethod","MyURL");
		
        System.out.println("a");;
		Mockito.when(request.getSession().getServletContext().getRealPath("/")).thenReturn(realPath);
		Mockito.when(retriveFileService.getFiles(url, request.getSession().getServletContext().getRealPath("/"))).thenReturn("success");
		System.out.println("b");
		
		ServletOutputStream mockOutput = Mockito.mock(ServletOutputStream.class);
		Mockito.when(response.getOutputStream()).thenReturn(mockOutput);
		cloneController.getFiles(response, request, url, model);
		
		Mockito.verify(response).setContentType("application/zip");
		
		//Mockito.verify(os)con//text.;
		//Assert.assertEquals(cloneController.getFiles(response, request, url, model), "download");
    	 
    }
	
	@Test
	public void getFileElsePartTest() throws Exception {
		RetriveFileService service=Mockito.mock(RetriveFileService.class);
		request= Mockito.mock(MockHttpServletRequest.class);
	    response=Mockito.mock(MockHttpServletResponse.class);
	    String realPath = "C:\\scs_new\\";
	    
	    MockServletContext context = new MockServletContext(realPath);//Mockito.mock(MockServletContext.class); 
	    context=Mockito.mock(MockServletContext.class);
	    HttpSession session=Mockito.mock(HttpSession.class);
	    request.setSession(session);
       
	    		
        
	    request = new MockHttpServletRequest(context,"myMethod","MyURL");
		
        //System.out.println("a");;
		Mockito.when(request.getSession().getServletContext().getRealPath("/")).thenReturn(realPath);
		Mockito.when(retriveFileService.getFiles(url, request.getSession().getServletContext().getRealPath("/"))).thenReturn("error");
		//System.out.println("b");
		Assert.assertEquals(cloneController.getFiles(response, request, url, model), "download");
    	 
    }
	
	@Test(expected=IOException.class)
	public void getFileIoExceptionTest() throws IOException {
		RetriveFileService service=Mockito.mock(RetriveFileService.class);
		request= Mockito.mock(MockHttpServletRequest.class);
	    response=Mockito.mock(MockHttpServletResponse.class);
	    String realPath = "C:\\scs_new\\";
	    
	    MockServletContext context = new MockServletContext(realPath);//Mockito.mock(MockServletContext.class); 
	    context=Mockito.mock(MockServletContext.class);
	    HttpSession session=Mockito.mock(HttpSession.class);
	    request.setSession(session);
              
	    request = new MockHttpServletRequest(context,"myMethod","MyURL");
		
        System.out.println("a1");;
		Mockito.when(request.getSession().getServletContext().getRealPath("/")).thenReturn(realPath);
		Mockito.when(retriveFileService.getFiles(url, request.getSession().getServletContext().getRealPath("/"))).thenReturn("success");
		
		Mockito.doThrow(new IOException()).when(response.getOutputStream());
		
		Assert.assertEquals(cloneController.getFiles(response, request, url, model),"download");
    }

}
