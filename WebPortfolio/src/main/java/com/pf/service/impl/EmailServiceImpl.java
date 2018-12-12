package com.pf.service.impl;

import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pf.common.Email;
import com.pf.controller.EmployeesController;
import com.pf.dao.EmailDao;
import com.pf.service.EmailService;

@Service("EmailService")
public class EmailServiceImpl implements EmailService {

	@Autowired
	EmailDao emdao;
	
	private static Log logger = LogFactory.getLog(EmployeesController.class);

	
	@Override
	public List<Map<String, Object>> getEmail(int params) {
		// TODO Auto-generated method stub
		return emdao.getEmail(params);
	}

	@Override
	@Transactional(rollbackFor = Exception.class) 
	public int addEmail(Map<String, String> params) {
		// TODO Auto-generated method stub
		
		return emdao.addEmail(params);
		
	}

	@Override
	public int deleteEmail(int params) {
		// TODO Auto-generated method stub
		return emdao.deleteEmail(params);
	}

	@Override
	public int updateEmail(Map<String, String> params) {
		// TODO Auto-generated method stub
		return emdao.updateEmail(params);
	}



}
