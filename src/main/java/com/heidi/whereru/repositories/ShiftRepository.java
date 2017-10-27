package com.heidi.whereru.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.heidi.whereru.models.Shift;
import com.heidi.whereru.models.User;



@Repository
public interface ShiftRepository extends CrudRepository<Shift, Long> {
	@Query("SELECT s FROM Shift s JOIN s.employer e WHERE e.id=?1")
	List<Shift> findbyEmployerId(Long id);
	
	@Query("SELECT s FROM Shift s JOIN s.employee e WHERE e.id=?1")
	List<Shift> findByEmployeeId(Long id);
	
//	List<Shift> findbyEmployee(User employee);
	
	
}
