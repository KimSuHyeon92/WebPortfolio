package com.pf.dao;

import java.util.List;
import java.util.Map;

import com.pf.common.CertEmail;

public interface EmailDao {
	
	public List<Map<String, Object>> getEmail (int params);
	public int addEmail (Map<String, String> params);
	public int deleteEmail (int params);
	public int updateEmail (Map<String, String> params);
	public int addCertEmail (CertEmail basic);
	public int updateCertEmail (String userEmail);
	
}
