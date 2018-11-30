package com.pf.service.impl;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pf.common.Salaries;
import com.pf.controller.EmployeesController;
import com.pf.controller.SalariesController;
import com.pf.dao.SalariesDao;
import com.pf.service.SalariesService;
@Service("salariesService")
public class SalariesServiceImpl implements SalariesService {
	
	@Autowired
	SalariesDao dao;
	
	private static Log logger = LogFactory.getLog(SalariesController.class);

	@Override
	public int insertSalaries(Map<String, Object> salaries) {
		// TODO Auto-generated method stub
		return dao.insertSalaries(salaries);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateSalaries(Map<String, Object> params)  {
		logger.debug("updateDeptEmp params : "+params);
		
		int update=0;
		int result=0;
		int msg = 0;
		
		try {
			//update 쿼리 실행으로 to_date 를 현재(now()) 로 변경해준다.
			update= dao.updateSalaries(params);
			System.out.println("---------------------->직함변경 업데이트 완료");
			//add 쿼리 실행으로 가
			result = dao.insertSalaries(params);
			System.out.println("---------------------->직함변경 입력 완료");
			
			msg=1;
		
		} catch (Exception e){
			logger.error("",e);
			
		}
		
		return msg;
	}

}
