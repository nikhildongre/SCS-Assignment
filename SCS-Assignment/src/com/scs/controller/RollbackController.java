package com.scs.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.scs.model.FileDocument;
import com.scs.model.FileDocumentVersion;
import com.scs.model.Node;
import com.scs.service.impl.FileServiceImpl;

@Controller
public class RollbackController {

	@Autowired
	FileServiceImpl fileServiceImpl;
	
	@RequestMapping(value = "/redirectrollback", method = RequestMethod.GET )
	@ResponseBody
	public String getVersions(@RequestParam("id") String id) {
		
		String versionJson=fileServiceImpl.getVersionArray(id);
		return versionJson;
	}
	
	@RequestMapping(value = "/rollback", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject rollbackToAVersion(@RequestParam("filename") String fileName,@RequestParam("versionno") String versionNo) {
		JSONObject json=fileServiceImpl.rollbackToVersion(fileName, versionNo);
		System.out.println(" rollbackToVersion start   versn="+json);
		return json;
	}
}
