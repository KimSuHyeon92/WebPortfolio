package com.pf.service.impl;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.fabric.xmlrpc.base.Params;
import com.pf.common.Employees;
import com.pf.controller.EmployeesController;
import com.pf.dao.DeptEmpDao;
import com.pf.dao.EmployeesDao;
import com.pf.dao.SalariesDao;
import com.pf.dao.TitlesDao;
import com.pf.service.EmployeesService;

@Service("employeesService")
public class EmployeesServiceImpl implements EmployeesService {
	
	@Autowired
	EmployeesDao dao;
	
	@Autowired
	DeptEmpDao deDao;
	
	@Autowired
	SalariesDao saDao;
	
	@Autowired
	TitlesDao tiDao;
	
	private static Log logger = LogFactory.getLog(EmployeesController.class);


	@Override
	public int getRow(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.getRow(params);
	}

	@Override
	public List<Map<String, Object>> departList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.departList(params);
	}

	@Override
	public int getManager(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.getManager(params);
	}

	@Override
	public List<Map<String, Object>> selectList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.selectList(params);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)    //rollbackFor 어떤 예외가발생하면 rollback 시킬것인지  ,  dao를 사용한다면 dao에 적어줘도 상관없다
	public int insertEmployees(Map<String, Object> employees){
		// TODO Auto-generated method stub
		
		try{
			//사원 기본정보 입력
			dao.insertEmployees(employees);
			System.out.println("---------------------->사원 기본정보 입력완료");
			//사원 부서정보 입력
			deDao.insertDeptEmp(employees);
			System.out.println("---------------------->사원 부서정보 입력완료");
			//연봉정보 입력
			saDao.insertSalaries(employees);
			System.out.println("---------------------->사원 연봉정보 입력완료");
			//직함정보 입력
			tiDao.insertTitles(employees);
			System.out.println("---------------------->사원 직함정보 입력완료");
			
			
		}catch(Exception e){
			logger.error("",e);
			
		}
		
		return Integer.valueOf(employees.get("empNo").toString());
	}

	

	@Override
	public int deleteEmployees(Map<String, Object> params) {
		return dao.deleteEmployees(params);
		
	}


	

	


}
