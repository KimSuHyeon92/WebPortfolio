package com.pf.test;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import com.pf.service.SalariesService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
		"file:src/main/resources-local/database/Spring-Datasource.xml",
		"file:src/main/resources-local/beans/Spring-Beans.xml"
})
public class Salaries {
//private static Log log = LogFactory.getLog(SalariesService.class);
	
	@Resource(name="salariesService")
	private SalariesService salariesService;
	
	
	@Test
	public void inserttest(){
		
		int oldsalaries = 48312;
		double addsalaries = 0.03;
		
		
	}

}
