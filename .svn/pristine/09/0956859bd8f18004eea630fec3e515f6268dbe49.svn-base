package com.scs.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scs.service.RetriveFileService;
@Controller
public class CloneController {
	
	@Autowired
	RetriveFileService retriveFileService;
	
	@RequestMapping(value = "/cloneProject", method = RequestMethod.POST)
	@ResponseBody
	public String getFiles(HttpServletResponse response, HttpServletRequest request,
			@RequestParam("url") String url, ModelMap model) throws IOException {
		String msg = retriveFileService.getFiles(url, request.getSession().getServletContext()
				.getRealPath("/"));
		if (msg.equalsIgnoreCase("success")) {
			System.out.println("In Clone Servlet");

			response.setContentType("application/zip");
			response.setHeader("Content-Disposition",
					"attachment;filename=download.zip");

			InputStream is = null;
			ServletOutputStream  os = null;
			try {
				is = new FileInputStream(request.getSession()
						.getServletContext().getRealPath("/")
						+ "test.zip");
				int read = 0;
				byte[] bytes = new byte[1024];
				os = response.getOutputStream();

				while ((read = is.read(bytes)) != -1) {
					os.write(bytes, 0, read);
				}
				
				os.flush();
				os.close();
				is.close();
			} catch (FileNotFoundException e) {
				System.out.println("Exception : " + e.getMessage());
			}

			catch (IOException e) {
				System.out.println("Exception : " + e.getMessage());
			}
			finally{
				os.flush();
				os.close();
				is.close();
			}
		} else {
		}
		return "download";
	}

}
