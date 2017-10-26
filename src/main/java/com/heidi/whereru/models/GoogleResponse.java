package com.heidi.whereru.models;

public class GoogleResponse {
	private 	Object[] results;
	private String status;
	public Object[] getResults() {
		return results;
	}
	public void setResults(Object[] results) {
		this.results=results;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public GoogleResponse() {
		
	}
	
	
	
}
