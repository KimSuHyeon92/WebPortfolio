package com.pf.common;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("Salaries")
public class Salaries {
	
	private int empNo;
	private int salary;
	private Date fromDate;
	private Date toDate;
	
	public Salaries() {
		// TODO Auto-generated constructor stub
	}

	public Salaries(int empNo, int salary, Date fromDate, Date toDate) {
		super();
		this.empNo = empNo;
		this.salary = salary;
		this.fromDate = fromDate;
		this.toDate = toDate;
	}

	public int getEmpNo() {
		return empNo;
	}

	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public Date getFromDate() {
		return fromDate;
	}

	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}

	public Date getToDate() {
		return toDate;
	}

	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}

	@Override
	public String toString() {
		return "Salaries [empNo=" + empNo + ", salary=" + salary + ", fromDate=" + fromDate + ", toDate=" + toDate
				+ "]";
	}
	
	
	

}
