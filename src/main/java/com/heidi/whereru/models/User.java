package com.heidi.whereru.models;

import java.util.Date;
import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;




@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue
	private Long id;
	
	@Column(unique=true)
	@Pattern(regexp="^[a-zA-Z0-9+._-]+@[A-Za-z0-9+._-]+\\.[A-Za-z]+$")
	private String username;
	@Size(min=2)
	
	private String firstname;
	@Size(min=2)
	
	private String lastname;
	
	@Size(min=8)
	private String password;
	
	
	@Transient
	private String pwdcfm;
	

	
	@ManyToMany(fetch=FetchType.EAGER)
	private List<Role> roles;
	
	@OneToMany(mappedBy="employee", fetch=FetchType.LAZY)
	private List<Shift> shifts;
	
	@OneToMany(mappedBy="employer", fetch=FetchType.LAZY)
	private List<Shift> overseenShifts;


	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
			name="employers_employees",
			joinColumns=@JoinColumn(name="employee_id"),
			inverseJoinColumns = @JoinColumn(name="employer_id")
			)
    private List<User> employees;
	
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
			name="employers_employees",
			joinColumns=@JoinColumn(name="employer_id"),
			inverseJoinColumns = @JoinColumn(name="employee_id")
			)
    private List<User> employers;	
	
		
	
	public User() {
		
	}

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

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPwdcfm() {
		return pwdcfm;
	}
	

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public List<Shift> getShifts() {
		return shifts;
	}

	public void setShifts(List<Shift> shifts) {
		this.shifts = shifts;
	}

	public List<Shift> getOverseenShifts() {
		return overseenShifts;
	}

	public void setOverseenShifts(List<Shift> overseenShifts) {
		this.overseenShifts = overseenShifts;
	}

	public List<User> getEmployees() {
		return employees;
	}

	public void setEmployees(List<User> employees) {
		this.employees = employees;
	}

	public List<User> getEmployers() {
		return employers;
	}

	public void setEmployers(List<User> employers) {
		this.employers = employers;
	}

	public void setPwdcfm(String pwdcfm) {
		this.pwdcfm = pwdcfm;
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
