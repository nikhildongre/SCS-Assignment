package com.scs.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scs.dao.FileDAO;
import com.scs.model.FileDocument;
/*
 * This class is use to create file structure on local machine 
 */
@Service(value = "RetriveFileService")
public class RetriveFileService {
	
	@Autowired
	FileDAO filedao;
	public String getFiles(String path, String contextPath)
	{
	
		
		//System.out.println(files);
		List<FileDocument>files=new ArrayList<FileDocument>();
		
		 try {
			files=filedao.findByPathClone("^"+path);
			
			if(files==null || files.isEmpty()){
				return "Invalid URL/Url is not accessible for this user";
			}
		} catch (Exception e1) {
			System.out.println("Exception : "+e1.getMessage());
		}
		
		
		 for(FileDocument file1 : files)
			{
				System.out.println("path from db "+file1.getPath());
				String final_path = contextPath+file1.getPath().replace("/", "\\")+file1.getName();
				System.out.println("Final_Path : "+final_path);
				
				if(file1.getName()!=null && file1.getName().contains(".") && !file1.isDeleted())
				{
					System.out.println("Name : "+file1.getName()+" Deleted : "+file1.isDeleted());
					try {
						// Contets to be added later
						System.out.println("Writing");
						if(file1.getVersions().size()>1){
							FileWriterService.writeFile(final_path, file1.getVersions().get(0).getContent());
						}else{
							FileWriterService.writeFile(final_path,"");
						}
						//FileWriterService.writeFile(final_path, file1.getContent());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					 
				}
				String zipPath=contextPath+path.replace("/", "\\");
				
				try {
					ZipService.zipDir(contextPath+"test.zip", zipPath);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		 return "Success";
	}
}
