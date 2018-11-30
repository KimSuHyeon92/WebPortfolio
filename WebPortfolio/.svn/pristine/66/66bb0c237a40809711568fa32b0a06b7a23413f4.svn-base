package com.pf.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pf.service.SalariesService;

@Controller
public class SalariesController {

	private static Log logger = LogFactory.getLog(DepartmentsController.class);

	@Autowired
	private SalariesService salService;
	
	/**
	 * 연봉변경 페이지 (modal)
	 * @return
	 */
	@RequestMapping("/salaries/changeSalaryInfo.do")
	public String getChangeDeptEmpPage() {
		return "/salaries/changeSalariesPopup";
	}
	
	/**
	 * 연봉변경 저장
	 * @param params
	 */
	@RequestMapping("/salaries/changeSalaries.do")
	@ResponseBody
	public Map<String, Object> changeDept(@RequestParam Map<String, Object> params){
		Map<String, Object> retValues = new HashMap<String, Object>();
		logger.debug("chnageDeptEmpInfo params > " + params);
		
		int result = 0; 	// 코드
		String msg = null;	// 메세지
		try{
			
			result = salService.updateSalaries(params);
			
			msg = (result == 1) ? "변경 되었습니다." : "실패!";
			
		}catch (Exception e) {
			logger.error("", e);
			msg = "실패!";
		}
		
		retValues.put("result", result);
		retValues.put("msg", msg);
		
		return retValues;
		
	}
}
