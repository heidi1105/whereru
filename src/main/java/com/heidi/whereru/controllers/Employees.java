package com.heidi.whereru.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.heidi.whereru.models.Shift;
import com.heidi.whereru.models.User;
import com.heidi.whereru.services.UserService;

@Controller
public class Employees {
	private UserService userService;
	
	public Employees(UserService userService) {
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
	
	@RequestMapping("/employees/dashboard")
	public String employeesDashboard(@ModelAttribute("shift") Shift shift, Model model, Principal principal) {
		User currentUser = userService.findByUsername(principal.getName());
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("shifts", userService.findShiftsByEmployee(currentUser.getId()));
		return "employee.jsp";
	}
	
	@RequestMapping("/employees/currentLocation/{id}")
	public String getCurrentLocation(@PathVariable("id")Long id, Model model, Principal principal) {
		User currentUser = userService.findByUsername(principal.getName());
		Shift shift = userService.findShiftById(id);
		model.addAttribute("shift", shift);
		model.addAttribute("currentUser", currentUser);
		return "currentlocation.jsp";
	}
	@RequestMapping("/process/signIn")
	public String createSignIn(@RequestParam("lng") Double lng, @RequestParam("lat") Double lat, Principal principal) {

		System.out.println(lng);
		System.out.println(lat);
		
		return "redirect:/employees/dashboard";
	}
	@RequestMapping("/employees/sign/{id}")
	public String sign(@PathVariable("id")Long id, Principal principal, @RequestParam("latitude")Double lat, @RequestParam("longitude")Double lng) {
		User currentUser = userService.findByUsername(principal.getName());
		if (userService.signShift(id, currentUser.getId(), lat, lng) =="success") {
			return "redirect:/employees/dashboard";			
		}else {
			return "redirect:/employees/liar";
		}
	}
	
	@RequestMapping("/employees/liar")
	public String liar(Principal principal, Model model) {
		User currentUser = userService.findByUsername(principal.getName());
		model.addAttribute("currentUser", currentUser);
		return "liar.jsp";
	}

}
