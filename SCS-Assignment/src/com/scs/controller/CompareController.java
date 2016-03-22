package com.scs.controller;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scs.service.impl.FileServiceImpl;

@Controller
public class CompareController {

	@Autowired
	FileServiceImpl fileServiceImpl;
	
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@RequestMapping(value="/compare",method=RequestMethod.POST)
	@ResponseBody
	public JSONObject compareVersions(@RequestParam("fileName") String fileName,@RequestParam("currentVersion") String currentVersion,@RequestParam("selectedVersion") String selectedVersion,@RequestParam("parentNodeId") String parentNodeId)
	{
		System.out.println("in CompareController controller........");

		JSONObject json = fileServiceImpl.getContentsForCompare(fileName,
				currentVersion,selectedVersion, parentNodeId);
		System.out.println(" getFileContent() json=="+json);
		logger.debug("json==" + json);
		logger.info(" getFileContent() end");
		return json;
	}
}
