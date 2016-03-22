package com.scs.service;

import org.json.simple.JSONObject;


public interface FileService {

	public String getFileByName(String fileName, String fileContent,
			String fileComment, String parentId,String userName);
	public JSONObject  getFileContentByName(String fileName, String parentId, String userName);
	public JSONObject getContentsForCompare(String fileName, String versionid1,String versionid2,
			String userName);
	
}
