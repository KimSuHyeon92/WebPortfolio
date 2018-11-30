package com.pf.service;

import java.util.List;
import java.util.Map;

import com.pf.common.Employees;
import com.pf.common.Member;
import com.pf.common.Notice;



public interface MemberService {
	

	Member selectCustBase(Member vo) throws Exception;
	int userInsert (Member vo) throws Exception;
	
}
