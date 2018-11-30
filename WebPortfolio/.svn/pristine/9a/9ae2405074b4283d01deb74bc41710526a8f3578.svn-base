package com.pf.test;

import java.util.HashMap;

import java.util.Map;

import javax.annotation.Resource;

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

public class AssessmentNCS_김수현 {
	
	@Resource(name="employeesService") //EmployeesServiceImpl 의 value 값
	private EmployeesService empService;
	
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
		//
		params.put("fromDate", "1990-10-10");
		
		int result = empService.insertEmployees(params);
		System.out.println("입력결과"+result);
		
			
	}
	
	@Test
	public void delTest(){
		
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
			
		empService.deleteEmployees(params);
				
	}
	

}
