package com.heidi.whereru.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.heidi.whereru.models.User;



@Repository
public interface UserRepository extends CrudRepository<User, Long> {
	User findByUsername(String username);
	
	@Query("SELECT u FROM User u JOIN u.roles r WHERE r.id=3")
	List<User> findAllEmployees();
	
	
	
}
