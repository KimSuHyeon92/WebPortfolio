package com.pf.dao;

import java.util.List;
import java.util.Map;

import com.pf.common.DeptEmp;

public interface DeptEmpDao {
	
	List<DeptEmp> list(Map<String, String> params);
	public int insertDeptEmp(Map<String, Object> deptemp);
	int updateDeptEmp(Map<String, Object> params);
	int addDeptEmp(Map<String, Object> params);
	int delDeptInfoButton(Map<String, Object> params);
}
