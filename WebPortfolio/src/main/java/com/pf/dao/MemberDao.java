package com.pf.dao;

import java.util.List;
import java.util.Map;

import com.pf.common.Employees;
import com.pf.common.Member;

public interface MemberDao {
	
	
	Member selectCustBase(Member vo) throws Exception;
	int userInsert (Member vo) throws Exception;
}
