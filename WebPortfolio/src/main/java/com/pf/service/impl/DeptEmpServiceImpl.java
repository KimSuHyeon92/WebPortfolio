package com.pf.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pf.common.DeptEmp;
import com.pf.controller.EmployeesController;
import com.pf.dao.DeptEmpDao;
import com.pf.service.DeptEmpService;

@Service(value="deptEmpService")
public class DeptEmpServiceImpl implements DeptEmpService {

	@Autowired
	DeptEmpDao dao;
	
	private static Log logger = LogFactory.getLog(EmployeesController.class);
	
	@Override
	public List<DeptEmp> list(Map<String, String> params) {
		// TODO Auto-generated method stub
		return dao.list(params);
	}

	@Override
	public int insertDeptEmp(Map<String, Object> deptemp) {
		// TODO Auto-generated method stub
		return dao.insertDeptEmp(deptemp);
	}

	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateDeptEmp(Map<String, Object> params)  {
		logger.debug("updateDeptEmp params : "+params);
		
		int update=0;
		int result=0;
		int msg = 0;
		
		try {
			//update 쿼리 실행으로 to_date 를 현재(now()) 로 변경해준다.
			update= dao.updateDeptEmp(params);
			System.out.println("---------------------->부서정보 업데이트 완료");
			//add 쿼리 실행으로 가
			result = dao.insertDeptEmp(params);
			System.out.println("---------------------->부서정보 입력 완료");
			
			msg=1;
		
		} catch (Exception e){
			logger.error("",e);
			
		}
		
		return msg;
	}

	@Override
	public int addDeptEmp(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.addDeptEmp(params);
	}

	@Override
	public int delDeptInfoButton(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.delDeptInfoButton(params);
	}

	

}
