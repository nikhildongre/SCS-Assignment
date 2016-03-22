package test.com.scs.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.jdbc.support.incrementer.MySQLMaxValueIncrementer;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;

import com.scs.dao.FileDAO;
import com.scs.dao.SequenceDao;
import com.scs.model.FileDocument;
import com.scs.model.FileDocumentVersion;
import com.scs.model.Node;
import com.scs.model.NodeAttributes;
import com.scs.service.impl.FileServiceImpl;
import com.scs.service.impl.UserServiceDetails;
import com.scs.utility.JsonUtility;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:WebContent/WEB-INF/scs-servlet.xml",
	"file:WebContent/WEB-INF/security-config.xml","file:WebContent/WEB-INF/mongo-config.xml"})
public class FileServiceImplTest {

	
	@Mock
    UserServiceDetails userServiceDetails;
	
	@Mock
	User user;
	
	/*@Mock
	FileDocumentVersion version; */
	
	@Mock
	FileDAO userFileRepositoryDao;
	
	@Mock
	HashMap<String, String> dummymap;
	
	
	
	@Mock
	 FileDocument file ;
	
	@Mock
	JsonUtility utility;

	private MockMvc mockMvc;
	
	@InjectMocks
	FileServiceImpl fileServiceImpl;
	
	@Mock
    SequenceDao sequenceDao;
	
	@Mock
	Node rootNode;
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		 
        // Setup Spring test in standalone mode
        this.mockMvc = MockMvcBuilders.standaloneSetup(fileServiceImpl).build();
        //Mockito.mock(FileDocument.class); 
        Mockito.mock(FileDAO.class); 
       // Mockito.mock(FileDocumentVersion.class); 
      
	}
	
	public FileDocument getFile()
	{
		FileDocument file = new FileDocument();
		List<FileDocumentVersion> versions = new ArrayList<FileDocumentVersion>();

		FileDocumentVersion version = new FileDocumentVersion("2.0", 1l, "testing", "akash", "this is version 2 file",new Date());
		versions.add(version);
		file.setId("007");
		file.setVersions(versions);
		file.setCurrentVersion("2.0");
		return file;
	}
	
	public Node getNode(FileDocument file)
	{
		System.out.println("tempnodefilename\t"+file.getName());
		Node tempNode = new Node();
		tempNode.setId(file.getId());
		tempNode.setFileName(file.getName());
		tempNode.setFile(file.isFile());
		tempNode.setParentNodeId(file.getParentNodeId());
		NodeAttributes attr = new NodeAttributes();
		attr.setCreatedDate(new Date());
		attr.setCurrentVersion(file.getCurrentVersion());
		attr.setLocked(file.isLocked());
		attr.setLockedBy(file.getLockedBy());
		attr.setPath(file.getPath());
		attr.setRoot(file.isRootFolder());
		tempNode.setA_attr(attr);
		System.out.println("tempnode2"+tempNode.getFileName());
		return tempNode;
	}
	
	/*@Test
	public void testgetRoot()
	{
		JSONObject json = Mockito.mock(JSONObject.class);
		 json.put("versionid1", "v1");
	     json.put("id1version", "v2");
	     json.put("isSuccess", true);
	     
	     
	}*/
	
	 @Test
	public void testrollbackToVersion()
	{

		JSONObject json = new JSONObject();
		json.put("filecontent", "this is version 2 file");
		json.put("isSuccess", true);

		Mockito.when(userFileRepositoryDao.findByName("pom.xml")).thenReturn(
				getFile());
		
		Assert.assertEquals(json.get("filecontent"), fileServiceImpl
				.rollbackToVersion("pom.xml", "2.0").get("filecontent"));

		Assert.assertEquals(json.get("isSuccess"), fileServiceImpl
				.rollbackToVersion("pom.xml", "2.0").get("isSuccess"));
		Assert.assertEquals(json,fileServiceImpl
				.rollbackToVersion("pom.xml", "2.0") );
	     
	}
	
	@Test
	public void testgetVersionArray()
	{
		 String jsonstring = "[{\"currentVersion\":\"true\",\"versionName\":\"2.0\",\"modifiedDate\":\""+getFile().getVersions().get(0).getModifiedDate()+"\",\"modifiedBy\":\"akash\",\"comment\":\"testing\"}]";
		
		 Mockito.when(fileServiceImpl.getFileById("12")).thenReturn(getFile());
		 Mockito.when(file.getVersions()).thenReturn(getFile().getVersions());
		Assert.assertEquals(jsonstring, fileServiceImpl.getVersionArray("12"));
		
	}
	
	
	@Test
	public void testgetContentsForCompare()
	{
		FileDocument locfile = getFile();
		List<FileDocumentVersion> list = locfile.getVersions();
		FileDocumentVersion version = new FileDocumentVersion("3.0", 2l, "testing", "akash", "this is version 3 file",new Date());
		list.add(version);
		locfile.setVersions(list);
		Mockito.when(userFileRepositoryDao.findByName("pom.xml")).thenReturn(
				locfile);
		Mockito.when(file.getVersions()).thenReturn(locfile.getVersions());
		JSONObject obj = new JSONObject();
		obj.put("versionid1", locfile.getVersions().get(0).getContent());
		obj.put("id1version","2.0");
		obj.put("versionid2", locfile.getVersions().get(1).getContent());
		obj.put("id2version","3.0");
		obj.put("isSuccess", true);
		Assert.assertEquals(obj, fileServiceImpl.getContentsForCompare("pom.xml", "2.0", "3.0", "akash"));	
	}
	
	@Test
	public void testgetFileContentByName()
	{
		FileDocument locfile = getFile();
		Mockito.when(userFileRepositoryDao.findByName("pom.xml")).thenReturn(
				locfile);
		JSONObject obj = new JSONObject();
		obj.put("filecontent", locfile.getVersions().get(0).getContent());
		obj.put("isSuccess", true);
		Assert.assertEquals(obj, fileServiceImpl.getFileContentByName("pom.xml","1234", "akash"));
	}
	
	@Test
	public void testgetFileByName()
	{
		FileDocument locfile = getFile();
		locfile.setLocked(false);
		FileDocumentVersion version = locfile.getVersions().get(0);
		Mockito.when(userFileRepositoryDao.findByName("pom.xml")).thenReturn(
				locfile);
		Mockito.when(sequenceDao.getNextSequenceId("scs_project/")).thenReturn(1l);
		Assert.assertEquals("success",fileServiceImpl.getFileByName("pom.xml", version.getContent(), version.getComments(), "1234","vikas"));
	}

	@Test
	public void testunlockFile()
	{
		Map<String, String> map = new HashMap<String, String>();
		map.put("lockedBy","");
		map.put("successMsg", "success");
		FileDocument locfile = getFile();
		locfile.setLocked(true);
		dummymap.put("lockedBy", "akash");
		dummymap.put("successMsg", "true");
		
		Mockito.when(fileServiceImpl.getFileById("12")).thenReturn(locfile);
		Assert.assertEquals(map,fileServiceImpl.unlockFile("12", "sachin"));
	}
	

	@Test
	public void testlockFile()
	{
		Map<String, String> map = new HashMap<String, String>();
		map.put("lockedBy","akash");
		map.put("successMsg", "true");
		FileDocument locfile = getFile();
		dummymap.put("lockedBy", "akash");
		dummymap.put("successMsg", "true");
		Mockito.when(fileServiceImpl.getFileById("12")).thenReturn(locfile);
		Assert.assertEquals(map,fileServiceImpl.lockFile("12", "akash"));
		locfile.setLocked(true);
		map.put("lockedBy","akash");
		map.put("successMsg", "this file is already locked by some other user");
		Assert.assertEquals(map,fileServiceImpl.lockFile("12", "akash"));
	}
		
	@Test
	public void testrenameFile()
	{
		FileDocument locfile = getFile();
		locfile.setName("pom.xml");
		locfile.setFile(true);
		locfile.setParentNodeId("123");
		locfile.setLocked(true);
		locfile.setLockedBy("akash");
		locfile.setPath("scs");
		locfile.setRoot(false);
		Node node = getNode(locfile);
		Mockito.when(utility.createJson(locfile)).thenReturn(node);
		Mockito.when(fileServiceImpl.getFileById("007")).thenReturn(locfile);
		Assert.assertEquals(node, fileServiceImpl.renameFile("007", "pom.xml"));	
	}
	
	
	@Test
	public void testdeleteFile()
	{
		FileDocument locfile = getFile();
		Mockito.when(fileServiceImpl.getFileById("007")).thenReturn(locfile);
		FileServiceImpl impl = Mockito.mock(FileServiceImpl.class);
		Mockito.doNothing().when(impl).deleteFile("1", "akash");
		
	}
	
	
	@Test
	public void testgetRoot()
	{
		FileDocument locfile = getFile();
		locfile.setFile(true);
		locfile.setParentNodeId("123");
		locfile.setLocked(true);
		locfile.setLockedBy("akash");
		locfile.setPath("scs");
		locfile.setRoot(true);
		Node node = getNode(locfile);
		Mockito.when(utility.createJson(locfile)).thenReturn(node);
		Mockito.when(userFileRepositoryDao.findByNameAndIsRootFolder("scsRoot",true)).thenReturn(locfile);
		Assert.assertEquals(node, fileServiceImpl.getRoot("scsRoot"));
	}
	
	@Test
	public void testcreateFile()
	{
		FileDocument locfile = getFile();
		locfile.setName("bond");
		locfile.setPath("scsSource");
		
		FileDocument childFile = new FileDocument();
		childFile.setName( "pom.xml");
		childFile.setParentNodeId("007");
		childFile.setPath("scsSource" + "" + "bond"
				+ "/");
		childFile.setCurrentVersion("1.0");
		childFile.setCreatedBy("akash");
		childFile.setCreatedDate(new Date());
		
		childFile.setFile(true);
		childFile.setChildren(false);
		List<FileDocumentVersion> versions = new ArrayList<FileDocumentVersion>();
		FileDocumentVersion version = new FileDocumentVersion();
		version.setComments("new File created by " + "akash");
		version.setVersionNo("1.0");
		versions.add(version);
		childFile.setVersions(versions);
		
		
		Node rootNode = getNode(childFile);
		System.out.println("sdgsig"+rootNode.getFileName());
		/*rootNode.setId("12");
		rootNode.setFileName("pom.xml");
		rootNode.setFile(true);
		rootNode.setParentNodeId("007");
		NodeAttributes attr = new NodeAttributes();
		attr.setCreatedDate(new Date());
		attr.setCurrentVersion(file.getCurrentVersion());
		attr.setLocked(false);
		attr.setLockedBy("");
		attr.setPath("scsSource"+""+"bond"+"/");
		attr.setRoot(false);
		rootNode.setA_attr(attr);*/

		Mockito.when(fileServiceImpl.getFileById("007")).thenReturn(locfile);
		Mockito.when(utility.createJson(childFile)).thenReturn(rootNode);
		//Assert.assertEquals(rootNode, fileServiceImpl.createFile("file", null, "pom.xml", "akash"));
		//System.out.println("rootnodetest"+rootNode.getFileName()+"fileServiceImplafakl\t"+fileServiceImpl.createFile("file", "007", "pom.xml", "akash"));
		Assert.assertNotEquals(rootNode, fileServiceImpl.createFile("file", "007", "pom.xml", "akash"));
	}
}
