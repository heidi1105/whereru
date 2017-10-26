package com.heidi.whereru.models;

import java.util.Date;

import javax.persistence.*;





@Entity
@Table(name="employers_employees")
public class EE {
	@Id
	@GeneratedValue
	private Long id;
	
	@ManyToOne(fetch= FetchType.LAZY)
	@JoinColumn(name="employee_id")
	private User employee;
	
	@ManyToOne(fetch= FetchType.LAZY)
	@JoinColumn(name="employer_id")
	private User employer; 
	
	
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

	public Long getId() {
		return id;
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
	
	
	
	

}
