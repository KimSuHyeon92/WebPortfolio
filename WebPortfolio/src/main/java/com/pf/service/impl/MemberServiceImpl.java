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
import com.pf.common.Member;
import com.pf.controller.EmployeesController;
import com.pf.dao.DeptEmpDao;
import com.pf.dao.EmployeesDao;
import com.pf.dao.MemberDao;
import com.pf.dao.SalariesDao;
import com.pf.dao.TitlesDao;
import com.pf.service.EmployeesService;
import com.pf.service.MemberService;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDao dao;
	
	private static Log logger = LogFactory.getLog(EmployeesController.class);

	@Override
	public Member selectCustBase(Member vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectCustBase(vo);
	}

	@Override
	public int userInsert(Member vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.userInsert(vo);
	}

	@Override
	public int updateUserPw(Member basic) throws Exception {
		// TODO Auto-generated method stub
		return dao.updateUserPw(basic);
	}

	
}
