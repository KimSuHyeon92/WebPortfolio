package com.pf.test;

import java.sql.SQLException;
import java.util.Date;
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

import com.pf.service.EmployeesService;

@RunWith(SpringJUnit4ClassRunner.class) //클래스참조실행
@ContextConfiguration(locations={ // 설정파일만따로읽어들어 실행시켜준다(톰캣이 없어도실행가능)
		"file:src/main/resources-local/database/Spring-Datasource.xml",
		"file:src/main/resources-local/beans/Spring-Beans.xml"
})

public class EmployeesServiceTest {
	//private static Log log = LogFactory.getLog(EmployeesServiceTest.class);
	
	/*@Autowired
	ApplicationContext ctx;*/
	
	@Resource(name="employeesService") //EmployeesServiceImpl 의 value 값
	private EmployeesService empService;
	

	@Test
	public void selectList(){
		Map<String, Object> params = new HashMap<String, Object>();
		List<Map<String, Object>> emps = empService.selectList(params);
		for(int i=0; i<emps.size(); i++){
			System.out.println(emps.get(i));
		}
	}
	
	@Test
	public void insert(){

		Map<String, Object> params = new HashMap<String, Object>();
		
		//생일
		params.put("birthDate", "1990-07-07");
		//이름
		params.put("firstName", "kim");
		params.put("lastName", "true");
		//성별
		params.put("gender", "M");
		//입사일
		params.put("hireDate", "2017-12-18");
		//부서번호
		params.put("deptNo", "d001");
		//연봉
		params.put("salary", "49,123");
		//월급
		params.put("title", "Lupn Salaries");
		
		int result = empService.insertEmployees(params);
		System.out.println("입력결과"+result);
		
			
	}
	
	@Test
	public void delTest(){
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		//생일
		params.put("empNo", 500038);
		
		empService.deleteEmployees(params);
				
	}
	
	
}


