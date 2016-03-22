package com.scs.controller;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.scs.service.impl.FileServiceImpl;
import com.scs.service.impl.UserServiceDetails;
import com.scs.utility.exception.CustomGenericException;

/**
 * This Controller is used to control the login of user Authors : Sumit
 */
@Controller
public class LoginController {

	@Autowired
	FileServiceImpl fileServiceImpl;

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	UserServiceDetails userDetailsService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String defaultPage(ModelMap map) {
		System.out.println("default page.......");
		 return "redirect:/";
		
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(ModelMap model) {
	 	return "login";
	}

	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String welcome(ModelMap model, HttpServletRequest request) {
		String url = null;
		if (request.isUserInRole("ADMIN")) {
			url = "admin";
		} else {
			User user = (User) SecurityContextHolder.getContext()
					.getAuthentication().getPrincipal();
			if (user.getPassword() != null
					&& user.getPassword().equals("welcome@123")) {
				return "changepassword";
			}
			url = "welcome";
		}
		System.out.println("welcome compare.......");
		JSONObject json = fileServiceImpl.getContentsForCompare("pom.xml",
				"2.4","1.5", "sourabh");
		logger.debug("json==" + json);
		System.out.println("in controller json==" + json);
		return url;
	}

	@ExceptionHandler(Exception.class)
	public String handleAllException(ModelMap model, Exception ex) {

		model.addAttribute("errMsg", "Exception");

		return "error";

	}

	@RequestMapping(value = "/change", method = RequestMethod.GET)
	public String change(ModelMap model) {
		return "changepassword";
	}
	
	@RequestMapping(value = "/accessdenied", method = RequestMethod.GET)
	public String accessDenied(ModelMap model) {
		return "denied";
	}
	
	

	@RequestMapping(value = "/cloneProject", method = RequestMethod.GET)
	public String cloneProject(ModelMap model) {
		return "cloneProject";
	}

	
	@RequestMapping(value = "/changepassword", method = RequestMethod.POST)
	public String changePassword(
			@RequestParam("confirmPassword") String confirmpassword,
			@RequestParam("newPassword") String newpassword, ModelMap model) {
		String url = "";
		User user = (User) SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		if (user.getPassword().equals(newpassword)) {
			model.addAttribute("error",
					"New password and current password cannot be same");
			url = "changepassword";
		}
		com.scs.model.User scsUser = userDetailsService.getUserDetail(user
				.getUsername());
		scsUser.setPassword(newpassword);
		userDetailsService.save(scsUser);
		model.addAttribute("error",
				"New password and current password cannot be same");
		url = "welcome";
		return url;
	}
}
