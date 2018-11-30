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

import com.mysql.fabric.xmlrpc.base.Params;
import com.pf.common.Departments;
import com.pf.service.DepartmentsService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
		"file:src/main/resources-local/database/Spring-Datasource.xml",
		"file:src/main/resources-local/beans/Spring-Beans.xml"
})
public class DepartmentsServiceTest{
	//private static Log log = LogFactory.getLog(DepartmentsService.class);
	
	@Resource(name="departmentsService")
	private DepartmentsService depService;
	
	@Test
	public void list(){
		Map<String, Object> params = new HashMap<String, Object>();
		/*List<Departments> deps = depService.list(params);*/
		//System.out.println("deps : "+deps.size());
		
		/*for(int i=0; i<deps.size(); i++){
			System.out.println(deps.get(i));
		}*/
	}
	
	@Test
	public void testSelect(){
		
		String deptNo="d099";
		depService.getDepartments(deptNo);
		System.out.println(depService.getDepartments(deptNo));
	}
	
	
	@Test
	public void testRow(){
		/*System.out.println(depService.getRow(Params));*/
		
	}
	
	@Test
	public void testInsert(){
		
		String deptNo = "d099";
		String deptName="감사부";
		
		Departments dept = new Departments();
		dept.setDeptNo(deptNo);
		dept.setDeptName(deptName);
		depService.addDepartments(dept);
		
		
		
	}
	
	@Test
	public void testUpdate(){
		String deptNo = "d099";
		String deptName="감사부 test";
		
		Departments dept = new Departments();
		dept.setDeptNo(deptNo);
		dept.setDeptName(deptName);
		depService.updateDepartments(dept);
	}
	
	@Test
	public void testDelete(){
		String deptNo = "d099";
		depService.deleteDepartments(deptNo);
	}
	
	
}
