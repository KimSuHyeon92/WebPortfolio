package com.pf.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pf.common.Departments;
import com.pf.dao.DepartmentsDao;
import com.pf.service.DepartmentsService;

@Service("departmentsService")
public class DepartmentsServiceImpl implements DepartmentsService {

	@Autowired
	DepartmentsDao dao;
	
	@Override
	public List<Departments> list(Map<String, String> params) {
		return dao.list(params);
	}

	@Override
	public int addDepartments(Departments dept) {
		// TODO Auto-generated method stub
		return dao.addDepartments(dept);
	}

	@Override
	public int updateDepartments(Departments dept) {
		// TODO Auto-generated method stub
		return dao.updateDepartments(dept);
	}

	@Override
	public int deleteDepartments(String deptNo) {
		// TODO Auto-generated method stub
		return dao.deleteDepartments(deptNo);
	}

	@Override
	public Departments getDepartments(String deptNo) {
		// TODO Auto-generated method stub
		return dao.getDepartments(deptNo);
	}

	@Override
	public int getRow(Map<String, String> params) {
		// TODO Auto-generated method stub
		return dao.getRow(params);
	}


}
