package com.scs.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scs.model.FileLockedByUser;
import com.scs.model.Node;
import com.scs.model.UsersLinkedToProject;
import com.scs.service.RetriveFileService;
import com.scs.service.impl.FileServiceImpl;

@Controller
public class FileController {

	@Autowired
	FileServiceImpl fileServiceImpl;
	
	@Autowired
	RetriveFileService retriveFileService;

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping(value = "/getProjectRoot", method = RequestMethod.GET)
	@ResponseBody
	public Node getProjectRoot(@RequestParam("projectName") String projectName) {
		Node file = fileServiceImpl.getRoot(projectName); // root
		return file;
	}

	@RequestMapping(value = "/getProjectChilds", method = RequestMethod.GET)
	@ResponseBody
	public List<Node> getProjectChilds(@RequestParam("id") String parentNodeId) {
		List<Node> files = fileServiceImpl.getChildFilesById(parentNodeId); // root

		return files;
	}

	@RequestMapping(value = "/createFile", method = RequestMethod.GET)
	@ResponseBody
	public Node createFile(@RequestParam("type") String fileType,
			@RequestParam("id") String parentId,
			@RequestParam("text") String fileName, Principal principal) {
		Node file = fileServiceImpl.createFile(fileType, parentId, fileName,
				principal.getName());
		return file;
	}

	@RequestMapping(value = "/deleteFile", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> deleteFile(@RequestParam("id") String fileId,
			Principal principal) {
		try {
			fileServiceImpl.deleteFile(fileId, principal.getName());
			return new ResponseEntity<>("Success", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(),
					HttpStatus.EXPECTATION_FAILED);
		}

	}

	@RequestMapping(value = "/renameFile", method = RequestMethod.GET)
	@ResponseBody
	public Node renameFile(@RequestParam("id") String fileId,
			@RequestParam("text") String fileName, Principal principal) {
		Node file = fileServiceImpl.renameFile(fileId, fileName);
		return file;
	}

	@RequestMapping(value = "/lockFile", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, String> lockFile(@RequestParam("id") String fileId,
			Principal principal) {
		System.out.println("in lockFile------");
		return fileServiceImpl.lockFile(fileId, principal.getName());

	}

	@RequestMapping(value = "/unlockFile", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, String> unlockFile(
			@RequestParam("id") String fileId, Principal principal) {
		return fileServiceImpl.unlockFile(fileId, principal.getName());
	}

	@RequestMapping(value = "/saveFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> commitFile(
			@RequestParam("filename") String fileName,
			@RequestParam("filecontent") String fileContent,
			@RequestParam("comments") String fileComment,
			@RequestParam("parentid") String parentId) {
		logger.info(" getFileDetails() start");
		User user = (User) SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		logger.debug("Filename:" + fileName + " File Content:" + fileContent
				+ " Comments:" + fileComment + " Parent id:" + parentId);

		String msg = fileServiceImpl.getFileByName(fileName, fileContent,
				fileComment, parentId, user.getUsername());
		Map<String, String> filemap = new HashMap();
		filemap.put("msg", msg);
		logger.debug("message==" + msg);
		logger.info(" getFileDetails() end");
		return filemap;
	}

	@RequestMapping(value = "/getContent", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject getFileContent(@RequestParam("filename") String fileName,
			@RequestParam("parentid") String parentId) {
		logger.info(" getFileContent() start");
		System.out.println("in controler getFileContent");
		User user = (User) SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		logger.debug("Filename:" + fileName + " Parent id:" + parentId);

		JSONObject json = fileServiceImpl.getFileContentByName(fileName,
				parentId, user.getUsername());
		System.out.println("in controler getFileContent json==" + json);
		logger.debug("json==" + json);
		logger.info(" getFileContent() end");
		return json;
	}

	@RequestMapping(value = "/unlockFiles", method = RequestMethod.GET)
	public String getLockedFiles() {
		return "unlockFiles";
	}

	@RequestMapping(value = "/getAllLockedFilesOfProject", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<FileLockedByUser> getAllLockedFilesOfProject(@RequestParam("projectName") String projectName) {

		List<FileLockedByUser> lockedFileList = null;
		if(StringUtils.isNotEmpty(projectName)){
			lockedFileList = retriveFileService.getFiles(projectName);
			logger.info("Locked Files From "+projectName+" Project : "+lockedFileList.toString());	
		}else{
			logger.info("Project Name is Empty.");
		}
		return lockedFileList;
	}

	@RequestMapping(value = "/unlockSelectedFile", method = RequestMethod.GET)
	@ResponseBody
	public String unlockSelectedFile(@RequestParam("fileId") String fileId) {

		String result = "";
		result = fileServiceImpl.unlockSelectedFile(fileId);

		return result;
	}

}
