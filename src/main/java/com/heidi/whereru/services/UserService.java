package com.heidi.whereru.services;


import java.util.Date;
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.heidi.whereru.models.Location;
import com.heidi.whereru.models.Shift;
import com.heidi.whereru.models.User;
import com.heidi.whereru.repositories.LocationRepository;
import com.heidi.whereru.repositories.RoleRepository;
import com.heidi.whereru.repositories.ShiftRepository;
import com.heidi.whereru.repositories.UserRepository;
@Service
public class UserService {
    private UserRepository userRepo;
    private RoleRepository roleRepo;
    private LocationRepository locRepo;
    private ShiftRepository shiftRepo;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    
    public UserService(UserRepository userRepo, RoleRepository roleRepo, ShiftRepository shiftRepo, LocationRepository locRepo, BCryptPasswordEncoder bCryptPasswordEncoder)     {
        this.userRepo = userRepo;
        this.roleRepo = roleRepo;
        this.locRepo=locRepo;
        this.shiftRepo=shiftRepo;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }
    
    public void saveWithUserRole(User user) {
    		System.out.println("got to save with user role");
    		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
    		user.setRoles(roleRepo.findByName("ROLE_USER"));
    		userRepo.save(user);
    }

    public void saveWithEmployerRole(User user) {
		System.out.println("got to save with Employer role");
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepo.findByName("ROLE_EMPLOYER"));
		userRepo.save(user);
}    
    
    
    public void saveUserWithAdminRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepo.findByName("ROLE_ADMIN"));
		System.out.println("service/ saveUserWithAdminRole");
		userRepo.save(user);
    }
    
    public User findByUsername(String username) {
    		return userRepo.findByUsername(username);
    }
    
    public int countAdmin() {
		return roleRepo.findByName("ROLE_ADMIN").get(0).getUsers().size();
    }
    
    public String checkRole(User user) {
		return user.getRoles().get(0).getName();
    }
    
    public List<User> findAllEmployees(){
    		return userRepo.findAllEmployees();
    }
    
    public void saveLocation(Location location) {
    		locRepo.save(location);
    }
    
    public List<Location> findAllLocation(){
    		System.out.println("in service to find locations");
    		return locRepo.findAll();
    }
    
    public void addShift(Shift shift) {
    		shiftRepo.save(shift);
    }
    
    public List<Shift> findShiftsByEmployer(Long id){
    		return shiftRepo.findbyEmployerId(id);
    }
    
    public void removeShift(Long id) {
    		shiftRepo.delete(id);
    }

	public Shift findShiftById(Long id) {
		return shiftRepo.findShiftById(id);
	}
    
    public List<Shift> findShiftsByEmployee(Long id){
    		return shiftRepo.findByEmployeeId(id);
    }
    
    public String signShift(Long shiftId, Long employeeId, Double lat, Double lng) {
    		Shift sign = shiftRepo.findOne(shiftId);
    		if (Math.abs(sign.getLocation().getLat()-lat) < 0.0003 && Math.abs(sign.getLocation().getLng()-lng) < 0.0003) {
        		if (sign.getEmployee()== userRepo.findOne(employeeId)) {
        			if (sign.getSignIn()==null) {
        				sign.setSignIn(new Date());
        			}else {
        				sign.setSignOut(new Date());
        			}
        		}
    		} else {
    			return "Liar!!!!!!!!!";
    		}
    		

    		shiftRepo.save(sign);
    		return "success";
    		
    		
    }
    
}
