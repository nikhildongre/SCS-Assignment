package com.scs.service;
import java.io.*;
/*
 * This class is use to create folder structure and write content to file
 */
public class FileWriterService {
	
		static public void writeFile(String filename,String content)throws IOException
		{
			  File file = new File(filename);
		      // creates the file
			  file.getParentFile().mkdirs(); 
		      file.createNewFile();
		      // creates a FileWriter Object
		      FileWriter writer = new FileWriter(file); 
		      // Writes the content to the file
		      writer.write(content); 
		      writer.flush();
		      writer.close();
		}

	



}
