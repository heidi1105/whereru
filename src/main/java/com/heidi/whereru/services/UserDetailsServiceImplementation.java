package com.heidi.whereru.services;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.heidi.whereru.models.Role;
import com.heidi.whereru.models.User;
import com.heidi.whereru.repositories.UserRepository;

@Service
public class UserDetailsServiceImplementation implements UserDetailsService {
	private UserRepository userRepo;

	public UserDetailsServiceImplementation(UserRepository userRepo) {
		this.userRepo=userRepo;
	}
	
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    		System.out.print("email: ");
        User user = userRepo.findByUsername(username);

        if(user == null) {
            throw new UsernameNotFoundException("You are not registered");
        }
        System.out.println(user.getUsername());
        user.setUpdatedAt(new Date());
        userRepo.save(user);
        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), getAuthorities(user));
    }
	
    private List<GrantedAuthority> getAuthorities(User user){
    		System.out.println("granting authority");
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        for(Role role : user.getRoles()) {
            GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(role.getName());
            authorities.add(grantedAuthority);
        }
        return authorities;
    }	
	
	
}
