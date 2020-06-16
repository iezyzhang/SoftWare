package com.bookshop.model.notice;

public class AdminRecord {
	private String managerId;
	private String managerName;
	private String password;
	private String lastLoginTime;
	private String createTime;

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public AdminRecord() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AdminRecord(String managerId, String managerName, String password, String lastLoginTime, String createTime) {
		super();
		this.managerId = managerId;
		this.managerName = managerName;
		this.password = password;
		this.lastLoginTime = lastLoginTime;
		this.createTime = createTime;
	}

}
