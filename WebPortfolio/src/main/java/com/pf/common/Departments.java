package com.pf.common;

import org.apache.ibatis.type.Alias;

@Alias("Departments")
public class Departments {
	
	private String deptNo;
	private String deptName;
	
	public Departments() {
		// TODO Auto-generated constructor stub
	}

	public Departments(String deptNo, String deptName) {
		super();
		this.deptNo = deptNo;
		this.deptName = deptName;
	}

	public String getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	@Override
	public String toString() {
		return "Departments [deptNo=" + deptNo + ", deptName=" + deptName + "]";
	}

	
	
	

}
