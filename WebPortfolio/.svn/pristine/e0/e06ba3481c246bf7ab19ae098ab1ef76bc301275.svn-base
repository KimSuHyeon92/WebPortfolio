package com.pf.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pf.common.DeptEmp;
import com.pf.service.DeptEmpService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
		"file:src/main/resources-local/database/Spring-Datasource.xml",
		"file:src/main/resources-local/beans/Spring-Beans.xml"
})
public class DeptEmpTest {
//private static Log log = LogFactory.getLog(DeptEmpService.class);
	
	@Resource(name="deptEmpService")
	private DeptEmpService deptempService;
	
	@Test
	public void list(){
		Map<String, String> params = new HashMap<String, String>();
		List<DeptEmp> deptemp = deptempService.list(params);
		//System.out.println("deps : "+deps.size());
		
		for(int i=0; i<deptemp.size(); i++){
			System.out.println(deptemp.get(i));
		}
	}
	
	@Test
	public void insert(){
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("empNo", "11321");
		params.put("fromDate", "1992-10-27");
		params.put("toDate", "9999-01-01");
		params.put("deptNo", "d004");

		int result = deptempService.insertDeptEmp(params);

		System.out.println(result);
		
		
	}
}
