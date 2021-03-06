package com.heidi.whereru.repositories;


import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.heidi.whereru.models.Shift;




@Repository
public interface ShiftRepository extends CrudRepository<Shift, Long> {
	@Query("SELECT s FROM Shift s JOIN s.employer e WHERE e.id=?1")
	List<Shift> findbyEmployerId(Long id);
	
	@Query("SELECT s FROM Shift s JOIN s.employee e WHERE e.id=?1 and s.signOut=null")
	List<Shift> findByEmployeeId(Long id);

	@Query("SELECT s FROM Shift s JOIN s.employer e WHERE e.id=?1")
	List<Shift> findFutureShiftsbyEmployerId(Long id);	
	
	
	Shift findShiftById(Long id);
	
	@Query("SELECT s FROM Shift s JOIN s.employee e WHERE e.id=?1")
	List<Shift> findPreviousByEmployeeId(Long id);
	
//	List<Shift> findbyEmployee(User employee);
	
	
}
