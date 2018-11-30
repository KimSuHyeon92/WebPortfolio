package com.pf.dao;

import java.util.List;
import java.util.Map;

import com.pf.common.Employees;

public interface EmployeesDao {
	
	
	
	List<Map<String, Object>> selectList(Map<String,Object> params);
	List<Map<String, Object>> departList(Map<String,Object> params);
	int getRow(Map<String, Object> params);
	int getManager(Map<String, Object> params);
	int insertEmployees(Map<String, Object> employees);
	int deleteEmployees(Map<String, Object> params);

}
