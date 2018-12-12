package com.pf.service;

import java.util.List;
import java.util.Map;

import com.pf.common.Email;

public interface EmailService {

	public List<Map<String, Object>> getEmail (int params);
	public int addEmail (Map<String, String> params);
	public int deleteEmail (int params);
	public int updateEmail(Map<String, String> params);
	
	
}
