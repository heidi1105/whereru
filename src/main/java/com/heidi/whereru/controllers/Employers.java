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
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.heidi.whereru.models.Shift;
import com.heidi.whereru.models.User;
import com.heidi.whereru.services.UserService;
import com.heidi.whereru.validators.UserValidator;


@Controller
public class Employers {
	private UserService userService;
	

	
	
	public Employers(UserService userService) {
		this.userService = userService;
	}	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm");
		binder.registerCustomEditor(Date.class, "assignedSignIn", new CustomDateEditor(timeFormat, true));	
		binder.registerCustomEditor(Date.class, "assignedSignOut", new CustomDateEditor(timeFormat, true));
		binder.registerCustomEditor(Date.class, "assignedDate", new CustomDateEditor(dateFormat, true));
	}

	
	@RequestMapping("/employers/dashboard")
	public String employersDashboard(@ModelAttribute("shift") Shift shift, Model model) {
		model.addAttribute("employees", userService.findAllEmployees());
		return "employers.jsp";
	}
	
	@PostMapping("/employers/dashboard")
	public String addShift(@Valid @ModelAttribute("shift")Shift shift, BindingResult result, Principal principal, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("employees", userService.findAllEmployees());
			return "employers.jsp";				
		}else {
			
			
			System.out.println(shift.getAssignedDate());
			System.out.println(shift.getAssignedSignIn());
			System.out.println(shift.getAssignedSignOut());
			
			return "redirect:/employers/dashboard";
		}
		
	
	}
	
	

	

	
	
	
	

}