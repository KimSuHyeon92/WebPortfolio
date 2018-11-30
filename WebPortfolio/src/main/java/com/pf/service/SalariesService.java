package com.pf.service;

import java.util.Map;

import com.pf.common.Salaries;

public interface SalariesService {
	public int insertSalaries(Map<String, Object> salaries);
	public int updateSalaries(Map<String, Object> params);
}
