package com.scs.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scs.dao.FileDAO;
import com.scs.dao.SequenceDao;
import com.scs.model.FileDocument;
import com.scs.model.FileDocumentVersion;
import com.scs.model.FileLockedByUser;
import com.scs.model.Node;
import com.scs.service.FileService;
import com.scs.utility.JsonUtility;

@Service(value = "FileServiceImpl")
public class FileServiceImpl implements FileService {

	@Resource
	private FileDAO userFileRepositoryDao;
	
	@Autowired
	private SequenceDao sequenceDao;

	@Autowired
	JsonUtility jsonUtility;

	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	HashMap< String, String> messageMap=new HashMap<String, String>();

	public List<Node> getChildFilesById(String id) {
		List<FileDocument> files = userFileRepositoryDao.findByParentNodeId(id);
		return jsonUtility.createJsonForChildNodes(files);
	}

	public Node getRoot(String projectName) {
		FileDocument file = userFileRepositoryDao.findByNameAndIsRootFolder(
				projectName, true);
		return jsonUtility.createJson(file);

	}

	public Node createFile(String fileType, String parentId, String fileName,
			String userName) {
		FileDocument parentFile = getFileById(parentId);
		FileDocument childFile = null;
		if (parentFile != null) {
			childFile = new FileDocument();
			childFile.setName(fileName);
			childFile.setParentNodeId(parentId);
			childFile.setPath(parentFile.getPath() + "" + parentFile.getName()
					+ "/");
			childFile.setCurrentVersion("1.0");
			childFile.setCreatedBy(userName);
			childFile.setCreatedDate(new Date());
			
			childFile.setFile(fileType.equalsIgnoreCase("file") ? true : false);
			childFile.setChildren(false);
			List<FileDocumentVersion> versions = new ArrayList<FileDocumentVersion>();
			FileDocumentVersion version = new FileDocumentVersion();
			version.setComments("new File created by " + userName);
			version.setVersionNo("1.0");
			versions.add(version);
			childFile.setVersions(versions);
			userFileRepositoryDao.save(childFile);
		}
		return jsonUtility.createJson(childFile);
	}

	public void createRoot(String fileName, String userName) {
		FileDocument rootFile = null;
		rootFile = new FileDocument();
		rootFile.setName(fileName);
		rootFile.setPath(fileName + "/");
		rootFile.setCurrentVersion("1.0");
		rootFile.setFile(false);
		rootFile.setChildren(true);
		rootFile.setRoot(true);
		rootFile.setCurrentVersion("1.0");
		rootFile.setCreatedBy(userName);
		rootFile.setCreatedDate(new Date());
		List<FileDocumentVersion> versions = new ArrayList<FileDocumentVersion>();
		FileDocumentVersion version = new FileDocumentVersion();
		version.setComments("Root Folder for New Project");
		version.setVersionNo("1.0");
		versions.add(version);
		rootFile.setVersions(versions);
		userFileRepositoryDao.save(rootFile);
	}

	public void deleteFile(String fileId, String deletedBy) {
		FileDocument file = getFileById(fileId);
		if (file != null) {
			file.setDeleted(true);
			file.setDeletedBy(deletedBy);
			userFileRepositoryDao.save(file);
		}
	}

	public Node renameFile(String fileId, String fileName) {
		FileDocument file = getFileById(fileId);
		if (file != null) {
			file.setName(fileName);
			userFileRepositoryDao.save(file);
		}
		return jsonUtility.createJson(file);
	}

	public FileDocument getFileById(String id) {
		FileDocument parentFile = userFileRepositoryDao.findOne(id);
		return parentFile;
	}


	public HashMap<String, String> lockFile(String fileId, String currentUser) {
		FileDocument file = getFileById(fileId);
		if (file != null) {
			if (!file.isLocked()) {
				file.setLocked(true);
				file.setLockedBy(currentUser);
				userFileRepositoryDao.save(file);
				messageMap.put("lockedBy", currentUser);
				messageMap.put("successMsg", "true");
			} else{
				messageMap.put("lockedBy", file.getLockedBy());
				messageMap.put("successMsg", "this file is already locked by some other user");
			}
			
		}
		 return messageMap;
	}

	public HashMap<String, String> unlockFile(String fileId, String currentUser) {
		FileDocument file = getFileById(fileId);
		if (file != null) {
			if (file.isLocked()) {
				file.setLocked(false);
				file.setLockedBy("");
				userFileRepositoryDao.save(file);
				messageMap.put("lockedBy", "");
				messageMap.put("successMsg", "success");
			} 
		}
		 return messageMap;
	}
	
	public String unlockSelectedFile(String fileId) {
		FileDocument file = getFileById(fileId);
		if (file != null) {
			if (file.isLocked()) {
				file.setLocked(false);
				file.setLockedBy("");
				userFileRepositoryDao.save(file);
				return "Success";
			} 
		}
		 return "Fail";
	}
	
	
	public String getFileByName(String fileName, String fileContent,
			String fileComment, String parentId, String userName) {
		logger.info("getFileByName() start");

		String msg;
		try {

			FileDocument fileDocumentfromdb = userFileRepositoryDao
					.findByName(fileName);
			
			String latestVersionNo = fileDocumentfromdb.getVersions().get(0)
					.getVersionNo();
			if(!fileDocumentfromdb.isLocked()){
			//String latestVersionNo = fileDocumentfromdb.getCurrentVersion();
			logger.debug("latestVersionNo======" + latestVersionNo);
			System.out.println(" latestVersionNo======" + latestVersionNo);
			double lNewVersionId = Double.parseDouble(latestVersionNo) + 0.1;
			double rNewVersionId = Math.round(lNewVersionId*100.0)/100.0;
			System.out.println("tt rNewVersionId==="+rNewVersionId);
			String newVersionId = String.valueOf(rNewVersionId);

			String content = fileDocumentfromdb.getVersions().get(0)
					.getContent();
			fileDocumentfromdb.setCurrentVersion(newVersionId);
			FileDocumentVersion fileversionToCommit = new FileDocumentVersion();
			List commitVersionList = new ArrayList();

			fileDocumentfromdb.setLockedBy(userName);
			fileversionToCommit.setVersionNo(newVersionId);
			fileversionToCommit.setRevisionNo(sequenceDao
					.getNextSequenceId("scs_project/"));
			fileversionToCommit.setComments(fileComment);
			fileversionToCommit.setModifiedDate(new Date());
			fileversionToCommit.setModifiedBy(userName);
			fileversionToCommit.setContent(fileContent);

			commitVersionList.add(fileversionToCommit);

			commitVersionList.addAll((List) fileDocumentfromdb.getVersions());

			logger.debug("commitVersionList==" + commitVersionList.size());

			JSONObject json = new JSONObject();
			json.put("filecontent", content);

			logger.debug("file json from db=" + json);

			fileDocumentfromdb.setVersions(commitVersionList);

			userFileRepositoryDao.save(fileDocumentfromdb);
			msg = "success";

			logger.info("file commited.....");
		}else {
			msg="file got locked by"+ fileDocumentfromdb.getLockedBy();
		}
			} catch (Exception e) {
			// TODO Auto-generated catch block
			msg = "failed";
			logger.error(e.getMessage());
		}
		logger.info("getFileByName() end");
		return msg;
	}

	public JSONObject getFileContentByName(String fileName, String parentId,
			String userName) {
		logger.info(" getFileContentByName() start");
		JSONObject json = new JSONObject();
		try {
			logger.debug("in sertvice getFileContentByName() ---------fileName=="
							+ fileName);
			FileDocument fileDocumentfromdb = userFileRepositoryDao
					.findByName(fileName);
			/*String content = fileDocumentfromdb.getVersions().get(0)
					.getContent();*/
			String currentVersionId = fileDocumentfromdb.getCurrentVersion();
			List<FileDocumentVersion> versionsList = fileDocumentfromdb.getVersions();
			logger.debug("file versions List=" + versionsList);
                
			for (FileDocumentVersion version : versionsList) {
				if (currentVersionId != null
						&& currentVersionId.equals(version.getVersionNo())) {
					json.put("filecontent", version.getContent());
					break;
				}
			}
			
			json.put("isSuccess", true);

			logger.debug(" json fetched from db=" + json);

		} catch (Exception e) {
			System.out.println(e.getMessage());
			logger.error(e.getMessage());
			json.put("filecontent",
					"There is some internal error.Please try after some time.");
			json.put("isSuccess", false);

		}
		logger.info(" getFileContentByName() end");
		return json;
	}
	public JSONObject getContentsForCompare(String fileName, String versionid1,String versionid2,
			String userName) {
		logger.info("service  getContentsForCompare() start");
		System.out.println(" getContentsForCompare() start");
		JSONObject json = new JSONObject();
		try {
			logger.debug("in sertvice getFileContentByName() ---------fileName=="
							+ fileName);
			FileDocument fileDocumentfromdb = userFileRepositoryDao
					.findByName(fileName);
			
			/*String content = fileDocumentfromdb.getVersions().get(0)
					.getContent();*/
			List<FileDocumentVersion> versionsList = fileDocumentfromdb.getVersions();
			logger.debug("file versions List=" + versionsList);
			System.out.println("file versions List=" + versionsList);  
			for(FileDocumentVersion version:versionsList)
			{
				boolean findVer1=false;
				boolean findVer2=false;
				if(findVer1 && findVer2)
				{
					break;
				}
				else if(versionid1!=null &&  versionid1.equals(version.getVersionNo()))
					{
				     json.put("versionid1", version.getContent());
				     json.put("id1version", versionid1);
				     findVer1=true;
					}
				else if(versionid2!=null &&  versionid2.equals(version.getVersionNo()))
				   {
					 json.put("versionid2", version.getContent());
					 json.put("id2version", versionid2);
					 findVer2=true;
				   }
			}
			 
			json.put("isSuccess", true);
			logger.debug(" json fetched from db=" + json);
			System.out.println("service json fetched from db=" + json);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			logger.error(e.getMessage());
			json.put("filecontent",
					"There is some internal error.Please try after some time.");
			json.put("isSuccess", false);

		}
		logger.info(" getContentsForCompare() end");
		return json;
	}
	
	public String getVersionArray(String id)
	{
		int i=0;
		String jsonString="[";
		FileDocument file = getFileById(id);
		List<FileDocumentVersion> versions=file.getVersions();
		List<String> listString = new ArrayList<String>();
		for(FileDocumentVersion ver : versions)
		{
			if(i!=0)
			{
				jsonString+=",";
			}
			if(ver.getVersionNo().equals(file.getCurrentVersion()))
			{
				jsonString+="{\"currentVersion\":\"true\",";
			}
			else
			{
				jsonString+="{\"currentVersion\":\"false\",";
			}
			jsonString+="\"versionName\":\""+ver.getVersionNo()+"\",\"modifiedDate\":\""+ver.getModifiedDate()+"\",\"modifiedBy\":\""+ver.getModifiedBy()+"\",\"comment\":\""+ver.getComments()+"\"}";
			i++;
		}
		jsonString+="]";
		return jsonString;
	}
	
	

	public JSONObject rollbackToVersion(String fileName,String versionNo){
		
		// save current version
		// send json
		JSONObject json = new JSONObject();
		logger.info("rollbackToVersion() start");
		logger.debug("in service rollbackToVersion() ---------fileName=="
				+ fileName);
		FileDocument file = userFileRepositoryDao.findByName(fileName);
		if (file != null) {
			file.setCurrentVersion(versionNo);
			userFileRepositoryDao.save(file);

			List<FileDocumentVersion> verionsList = file.getVersions();

			for (FileDocumentVersion version : verionsList) {
				if (versionNo != null
						&& versionNo.equals(version.getVersionNo())) {
					json.put("filecontent", version.getContent());
					break;
				}
			}
		}
		json.put("isSuccess", true);
       System.out.println(" service json=="+json);
		return json;
	}
	
}
