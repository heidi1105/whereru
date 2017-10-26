package com.heidi.whereru.controllers;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.security.Principal;


import javax.net.ssl.HttpsURLConnection;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.heidi.whereru.models.GoogleResponse;
import com.heidi.whereru.models.Location;
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
	@RequestMapping("/employers/dashboard")
	public String employersDashboard(@ModelAttribute("shift") Shift shift) {
		return "employers.jsp";
	}
	
	@RequestMapping("/employers/addLocation")
	public String addLocation(@ModelAttribute("location") Location location, @RequestParam(value="address", required=false, defaultValue="Los Angeles") String address, Model model) {
		model.addAttribute("address", address);
		return "location.jsp";
	}
//	
//	@PostMapping("employers/addLocation")
//	public String createLocation(@RequestParam("name") String name, @RequestParam("address")String address) {
//		System.out.println(name);
//		System.out.println(address);
//		return "redirect:/employers/addLocation";
//	}
	
	@PostMapping("/employers/addLocation")
	public String getGeoLocation(@RequestParam("address")String address) throws Exception{
		String newAddress = address.replaceAll("\\s","");
		String url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + newAddress + "&key=AIzaSyA6GV4vn8fPfAwYa1BHw1yYeygwSFXW5tQ";
		URL obj = new URL(url);
		HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
		
		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'GET' request to URL : " + url);
	    System.out.println("Response Code : " + responseCode);
	    
	    BufferedReader in = new BufferedReader(
	            new InputStreamReader(con.getInputStream()));
	    String inputLine;
	    StringBuffer response = new StringBuffer();

	    while ((inputLine = in.readLine()) != null) {
	        response.append(inputLine);
	    }
	    in.close();

	    System.out.println(response.toString());

	    GsonBuilder builder = new GsonBuilder();
	    builder.setPrettyPrinting();
//
	    Gson gson = builder.create();
	    GoogleResponse numbers = gson.fromJson(response.toString(), GoogleResponse.class);
	    System.out.println(numbers.getResults());
//	    System.out.println(intoken.getAccess_token());
//	    String getInfo = "https://api.instagram.com/oauth/authorize/?client_id=34b735fb437e48d891c05ced7e4c6846&"
//	            + "redirect_uri=http://localhost:8080/instalogin"
//	            + "&scope=public_content"
//	            + "&response_type=token";
////	        http://your-redirect-uri#access_token=ACCESS-TOKEN
//	//https://api.instagram.com/oauth/authorize/?client_id=34b735fb437e48d891c05ced7e4c6846&redirect_uri=http://localhost:8080/instalogin&response_type=token        
//	    String info2 = "https://api.instagram.com/v1/locations/search?lat=48.858844&lng=2.294351&access_token="+intoken.getAccess_token();
//
//	    // model.addAttribute("access", intoken.getAccess_token());
//
//
//	    return "login.jsp";
//
//
////	    return "login.jsp";
	    
	    return "redirect:/employers/addLocation";
	}
//	public static GeoPoint getGeoPointFromAddress(@RequestParam("address")String address) {
//		GeoPoint locationPoint = null;
//        String addy = address.replaceAll(" ", "%20");
//        String str = "http://maps.googleapis.com/maps/api/geocode/json?address="
//                + addy + "&sensor=true";
//
//        String ss = readWebService(str);
//        JSONObject json;
//        try {
//
//            String lat, lon;
//            json = new JSONObject(ss);
//            JSONObject geoMetryObject = new JSONObject();
//            JSONObject locations = new JSONObject();
//            JSONArray jarr = json.getJSONArray("results");
//            int i;
//            for (i = 0; i < jarr.length(); i++) {
//                json = jarr.getJSONObject(i);
//                geoMetryObject = json.getJSONObject("geometry");
//                locations = geoMetryObject.getJSONObject("location");
//                lat = locations.getString("lat");
//                lon = locations.getString("lng");
//
//                locationPoint = Utils.getGeoPoint(Double.parseDouble(lat),
//                        Double.parseDouble(lon));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return locationPoint;
//    }

}
