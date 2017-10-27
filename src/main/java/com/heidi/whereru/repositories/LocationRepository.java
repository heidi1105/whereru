package com.heidi.whereru.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.heidi.whereru.models.Location;



@Repository
public interface LocationRepository extends CrudRepository<Location, Long> {
	List<Location> findAll();

	
}
