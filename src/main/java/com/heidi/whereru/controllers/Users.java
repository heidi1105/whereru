package com.heidi.whereru.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.heidi.whereru.models.Shift;
import com.heidi.whereru.models.User;
import com.heidi.whereru.services.UserService;
import com.heidi.whereru.validators.UserValidator;


@Controller
public class Users {
	private UserService userService;
	private UserValidator userValidator;

	
	
	public Users(UserService userService, UserValidator userValidator) {
		this.userService = userService;
		this.userValidator=userValidator;

	}	

//	public void initBinder(WebDataBinder binder) {
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		dateFormat.setLenient(false);
//		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
//	}
	
	
	@RequestMapping("/login")
	public String forms(@RequestParam(value="error", required=false)String error, 
			@RequestParam(value="logout", required=false) String logout,
			@Valid @ModelAttribute("regUser") User regUser, Model model) {
		if (error !=null) {
			System.out.println("got to login");
			model.addAttribute("errorMessage", "Invalid Credentials, Please try again");
		}
		if (logout!= null) {
			model.addAttribute("logoutMessage", "Logout Successfully");
		}
		
		return "login.jsp";
		
	}

	
	@PostMapping("/register")
	public String registration(@Valid @ModelAttribute("regUser") User user, BindingResult result, @RequestParam("role") String role) {
		System.out.println("here in register controller");
		userValidator.validate(user, result);
		if(result.hasErrors()) {
			System.out.println("here with register error");
			return "login.jsp";
		}else {
			if (role.equals("employer")) {
				userService.saveWithEmployerRole(user);				
			}else {
				userService.saveWithUserRole(user);				
			}
		}
		return "redirect:/";
	}
	
	@RequestMapping("/")
	public String firstPage(Model model, Principal principal) {
		String username = principal.getName();
		User currentUser = 	userService.findByUsername(username)	;
		String role = userService.checkRole(currentUser);
		if (role.equals("ROLE_ADMIN")) {
			return "redirect:/admin";
		} else if(role.equals("ROLE_EMPLOYER")) {
			return "redirect:/employers/dashboard";
		}else {
			return "redirect:/employees/dashboard";
		}
	}


	
	
	
	

}
