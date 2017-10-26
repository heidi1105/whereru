package com.heidi.whereru.models;

import java.util.Date;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;





@Entity
@Table(name="shifts")
public class Shift {
	@Id
	@GeneratedValue
	private Long id;
	
	@ManyToOne(fetch= FetchType.LAZY)
	@JoinColumn(name="employee_id")
	private User employee;
	
	@ManyToOne(fetch= FetchType.LAZY)
	@JoinColumn(name="employer_id")
	private User employer; 
	
	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date assignedDate;

	@DateTimeFormat(pattern="hh:mm")	
	private Date signin;
	
	@DateTimeFormat(pattern="hh:mm")	
	private Date signout;
	
	@ManyToOne(fetch= FetchType.LAZY)
	@JoinColumn(name="location_id")
	private Location location;	
	
	

	
	@Column(updatable=false)
	private Date createdAt;
	
	private Date updatedAt;
	@PrePersist
	protected void onCreate() {
		this.createdAt=new Date();
	}
	
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt=new Date();
	}


	public void setId(Long id) {
		this.id = id;
	}

	public User getEmployee() {
		return employee;
	}

	public void setEmployee(User employee) {
		this.employee = employee;
	}

	public Date getSignin() {
		return signin;
	}

	public void setSignin(Date signin) {
		this.signin = signin;
	}

	public Date getSignout() {
		return signout;
	}

	public void setSignout(Date signout) {
		this.signout = signout;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public User getEmployer() {
		return employer;
	}

	public void setEmployer(User employer) {
		this.employer = employer;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Date getAssignedDate() {
		return assignedDate;
	}

	public void setAssignedDate(Date assignedDate) {
		this.assignedDate = assignedDate;
	}

	public Long getId() {
		return id;
	}



	
	
	
	
	

}
