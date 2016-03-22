package com.scs.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ZipService {
	public static void zipDir(String zipFileName, String dir) throws Exception {
	    File dirObj = new File(dir);
	    ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
	    System.out.println("Creating : " + zipFileName);
	    String path=dirObj.getAbsolutePath().substring(dirObj.getAbsolutePath().lastIndexOf("\\scsProject") + 1, dirObj.getAbsolutePath().length());
	    System.out.println("P : "+dirObj.getAbsolutePath());
	    addDir(path,dirObj, out);
	    
	    out.close();
	  }

	  static void addDir(String path,File dirObj, ZipOutputStream out) throws IOException {
	    File[] files = dirObj.listFiles();
	    byte[] tmpBuf = new byte[1024];
	    if(files!=null)
	    for (int i = 0; i < files.length; i++) {
	    	System.out.println("FILES : "+files[i].getName());
	      if (files[i].isDirectory()) {
	    	  char[] arr=path.toCharArray();
	    	  String dirPath="";
	    	  if(arr[arr.length-1]!='/'){
	    		  dirPath=path+"\\"+files[i].getName();
	    	  }
	    	  else
	    	  {
	    		  dirPath=path+files[i].getName();
	    	  }
	    	  System.out.println("dirPath : "+dirPath);
	        addDir(dirPath,files[i], out);
	        continue;
	      }
	      System.out.println("Absolute Path : "+files[i].getAbsolutePath());
	      FileInputStream in = new FileInputStream(files[i].getAbsolutePath());
	      System.out.println(" Adding: " + path+"\\"  +files[i].getName());
	      out.putNextEntry(new ZipEntry(path+"\\" + files[i].getName()));
	      int len;
	      while ((len = in.read(tmpBuf)) > 0) {
	        out.write(tmpBuf, 0, len);
	      }
	      out.closeEntry();
	      in.close();
	    }
	  }

	 

}
