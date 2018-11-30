package com.pf.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pf.common.Departments;
import com.pf.common.Employees;
import com.pf.service.DepartmentsService;
import com.pf.service.DeptEmpService;
import com.pf.service.EmployeesService;
import com.pf.service.SalariesService;
import com.pf.service.TitlesService;
import com.pf.util.ExcelUtil;
import com.pf.util.JsonResponse;

@Controller
public class EmployeesController {
	
	private static Log logger = LogFactory.getLog(EmployeesController.class);

	@Autowired
	private EmployeesService empService;
	
	@Autowired 
	private ExcelUtil excel;


	@RequestMapping("/emp/empList.do")
	@ResponseBody
	public ModelAndView listPage(@RequestParam Map<String, String> params){
		ModelAndView view = new ModelAndView();
		view.setViewName("emp/empList");
		return view;
	}

	@RequestMapping("/emp/list.do")
	@ResponseBody
	public JsonResponse<Map<String, Object>> list(@RequestParam Map<String, Object> params){
		//parameter for paging 
		int pageSize = Integer.parseInt(params.get("rows").toString());	// 한 페이지에 보여줄 개수
		int currentPage = Integer.parseInt(params.get("page").toString());	// 현재 페이지
		int totalCount = empService.getRow(params);		// 총 게시글 수
		int totalPage = (totalCount % pageSize == 0)?(totalCount/pageSize):(totalCount/pageSize)+1;	// 총 페이지
		int start = (currentPage - 1) * pageSize;	// 시작 로우

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(pageSize));
		params.put("sidx", String.valueOf(params.get("sidx")));
		params.put("sord", String.valueOf(params.get("sord")));
		
		List<Map<String, Object>> list = empService.selectList(params);
		
		JsonResponse<Map<String, Object>> res = new JsonResponse<Map<String, Object>>();
		res.setRows(list); //전체리스트
		res.setPage(String.valueOf(currentPage)); //현재
		res.setTotal(String.valueOf(totalPage)); //총페이지
		res.setRecords(String.valueOf(totalCount)); //총몆개
		
		return res;

	}
	
	@RequestMapping("/emp/deptList.do")
	@ResponseBody
	public ModelAndView deptPage(@RequestParam Map<String, String> params){
		ModelAndView view = new ModelAndView();
		view.setViewName("emp/deptList");
		return view;
	}

	@RequestMapping("/emp/deptPage.do")
	@ResponseBody
	public JsonResponse<Map<String, Object>> deptlist(@RequestParam Map<String, Object> params){
		//parameter for paging 
		int pageSize = Integer.parseInt(params.get("rows").toString());	// 한 페이지에 보여줄 개수
		int currentPage = Integer.parseInt(params.get("page").toString());	// 현재 페이지
		int totalCount = empService.getManager(params);		// 총 게시글 수
		int totalPage = (totalCount % pageSize == 0)?(totalCount/pageSize):(totalCount/pageSize)+1;	// 총 페이지
		int start = (currentPage - 1) * pageSize;	// 시작 로우

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(pageSize));
		params.put("sidx", String.valueOf(params.get("sidx")));
		params.put("sord", String.valueOf(params.get("sord")));
		
		List<Map<String, Object>> list = empService.departList(params);
		
		JsonResponse<Map<String, Object>> res = new JsonResponse<Map<String, Object>>();
		res.setRows(list); //전체리스트
		res.setPage(String.valueOf(currentPage)); //현재
		res.setTotal(String.valueOf(totalPage)); //총페이지
		res.setRecords(String.valueOf(totalCount)); //총몆개
		
		return res;

	}
	
	/**
	 * 직원 정보 입력
	 */
	@RequestMapping("/emp/addEmpInfo.do")
	@ResponseBody
	public void addEmpInfo(@RequestParam Map<String, Object> params){
		logger.debug("addEmpInfo : "+params);
		
		empService.insertEmployees(params);
		
	}
	
	/**
	 * 직원 정보 삭제
	 */
	@RequestMapping("/emp/delEmpInfo.do")
	@ResponseBody
	public void delEmpInfo(@RequestParam Map<String, Object> params){
		logger.debug("delEmpInfo : "+params);
		
		empService.deleteEmployees(params);
		
	}
	
	/**
	 * 부서장 정보 엑셀 다운로드
	 * @param params
	 * @return
	 *  엑셀을 파라미터로 데이터값을가져올수없어서 request와 resonse 로 받은뒤 파라미터를 담는다.
	 */
	@RequestMapping("/emp/deptmListExcel.do")
	public void deptListExcel(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params){
		
		logger.debug("deptmListExcel params > "+params);
		
		List<Map<String, Object>> list = empService.departList(params);
		//엑셀의 depts 는? list에서 가져온걸 map에 넣는데 그 이름이 depts
		//엑셀에서 자동으로 for문이 돌아가 데이터를 가져와준다
		
		
		Map<String, Object> beans = new HashMap<String, Object>();
        beans.put("deptsmanager", list);
        // request, response, 출력 데이터, 파일명, 템플릿 파일명
		excel.exportExcel(request, response, beans, "deptsmanager", "deptsmanager");
	}
	


}
