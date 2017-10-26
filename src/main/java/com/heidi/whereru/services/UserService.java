package com.heidi.whereru.services;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import com.heidi.whereru.models.User;
import com.heidi.whereru.repositories.RoleRepository;
import com.heidi.whereru.repositories.UserRepository;
@Service
public class UserService {
    private UserRepository userRepo;
    private RoleRepository roleRepo;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    
    public UserService(UserRepository userRepo, RoleRepository roleRepo, BCryptPasswordEncoder bCryptPasswordEncoder)     {
        this.userRepo = userRepo;
        this.roleRepo = roleRepo;
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
    
    
    
    
}
