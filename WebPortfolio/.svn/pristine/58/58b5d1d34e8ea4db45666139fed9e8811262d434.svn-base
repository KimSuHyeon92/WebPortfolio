package com.pf.test;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import com.pf.service.TitlesService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
		"file:src/main/resources-local/database/Spring-Datasource.xml",
		"file:src/main/resources-local/beans/Spring-Beans.xml"
})
public class TitleTest {
//private static Log log = LogFactory.getLog(TitlesService.class);
	
	@Resource(name="titleService")
	private TitlesService titlesService;
	
	@Test
	private void updatetest(){
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("empNo", "500010");
		params.put("oldTitle", "회계부");
		params.put("oldFromDate","2017-11-29");
		
		//titlesService.
		
		
	}

}
