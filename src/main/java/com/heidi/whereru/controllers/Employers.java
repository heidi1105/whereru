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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.heidi.whereru.models.Location;
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
	public String employersDashboard(@ModelAttribute("shift") Shift shift, Model model, Principal principal) {
		User currentUser = userService.findByUsername(principal.getName());
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("employees", userService.findAllEmployees());
		model.addAttribute("locations", userService.findAllLocation());
		model.addAttribute("shifts", userService.findFutureShifts(currentUser.getId()));
		return "employers.jsp";
	}
	
	@PostMapping("/employers/dashboard")
	public String addShift(@Valid @ModelAttribute("shift")Shift shift, BindingResult result, Principal principal, Model model) {
		if (result.hasErrors()) {
			User currentUser = userService.findByUsername(principal.getName());
			model.addAttribute("currentUser", currentUser);
			model.addAttribute("employees", userService.findAllEmployees());
			model.addAttribute("locations", userService.findAllLocation());
			model.addAttribute("shifts", userService.findFutureShifts(currentUser.getId()));
			
			return "employers.jsp";				
		}else {

			userService.addShift(shift);
			
			return "redirect:/employers/dashboard";
		}
		
	}
	
	@RequestMapping("/employers/addLocation")
	public String addLocation(@ModelAttribute("location") Location location, @RequestParam(value="address", required=false, defaultValue="Los Angeles") String address, Model model) {
		model.addAttribute("address", address);
		return "location.jsp";
	}

	
	@PostMapping("/employers/createLocation")
	public String createLocation(@RequestParam("name")String name, 
			@RequestParam("latitude")Double lat, 
			@RequestParam("address")String address,
			@RequestParam("longitude")Double lng) {

		Location loc = new Location();
		loc.setAddress(address);
		loc.setLat(lat);
		loc.setLng(lng);
		loc.setName(name);
		userService.saveLocation(loc);
		return "redirect:/employers/dashboard";
	}
	
	
	@RequestMapping("/employers/delete/{id}")
	public String removeShift(@PathVariable("id")Long id) {
		userService.removeShift(id);
		return "redirect:/employers/dashboard";
	}


	@RequestMapping("/employers/edit/{id}")
	public String getShift(@PathVariable("id")Long id, @ModelAttribute("shift")Shift shift, Model model) {
		model.addAttribute("shift", userService.findShiftById(id));
		model.addAttribute("employees", userService.findAllEmployees());
		model.addAttribute("locations", userService.findAllLocation());
		return "editShift.jsp";
	}
	
	@RequestMapping("/employers/previousShifts")
	public String previousShifts(@ModelAttribute("shift") Shift shift, Model model, Principal principal) {
		User currentUser = userService.findByUsername(principal.getName());
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("employees", userService.findAllEmployees());
		model.addAttribute("locations", userService.findAllLocation());
		model.addAttribute("shifts", userService.findPreviousShifts(currentUser.getId()));
		return "previousShifts.jsp";
	}

	

}
