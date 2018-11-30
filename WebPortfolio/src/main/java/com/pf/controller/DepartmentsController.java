package com.pf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pf.controller.DepartmentsController;
import com.pf.util.ExcelUtil;
import com.pf.common.Departments;
import com.pf.common.DeptEmp;
import com.pf.service.DepartmentsService;
import com.pf.service.DeptEmpService;
import com.pf.util.JsonResponse;



@Controller
public class DepartmentsController {

	private static Log logger = LogFactory.getLog(DepartmentsController.class);

	@Autowired
	private DepartmentsService deptService;
	
	@Autowired
	private DeptEmpService deService;
	
	@Autowired 
	private ExcelUtil excel;
	
	
	/**
	 * 부서 정보 조회 페이지 이동 (기본 그리드)
	 * 
	 * @param params
	 * @return
	 */
	@RequestMapping("/dept/deptList.do")
	@ResponseBody
	public ModelAndView listPage(@RequestParam Map<String, String> params){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dept/deptList");
		return mv;
	}
	
	/**
	 * 부서 정보 조회 데이터 전달
	 * @param params
	 * @return
	 */
	@RequestMapping("/dept/list.do")
	@ResponseBody //파일이나이미지를응담에담아바로넘겨준다 그럼화면에 사진,파일 다운로드가 되는것  써주면  제이슨리스펀스가 set을 했기때문에 아까본 스트링으로 한번에 바뀜(goo.gl/9nJqRo)
	public JsonResponse<Departments> list(@RequestParam Map<String, String> params){
		
		//parameter for paging 
		int pageSize = Integer.parseInt(params.get("rows").toString());	// 한 페이지에 보여줄 개수
		int currentPage = Integer.parseInt(params.get("page").toString());	// 현재 페이지
		int totalCount = deptService.getRow(params);		// 총 게시글 수
		int totalPage = (totalCount % pageSize == 0)?(totalCount/pageSize):(totalCount/pageSize)+1;	// 총 페이지
		int start = (currentPage - 1) * pageSize;	// 시작 로우
		
		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(pageSize));
		params.put("sidx", String.valueOf(params.get("sidx")));
		params.put("sord", String.valueOf(params.get("sord")));
		
		List<Departments> list = deptService.list(params);
				
		JsonResponse<Departments> res = new JsonResponse<Departments>();
		res.setRows(list); //전체리스트
		res.setPage(String.valueOf(currentPage)); //현재
		res.setTotal(String.valueOf(totalPage)); //총페이지
		res.setRecords(String.valueOf(totalCount)); //총몆개
		
		return res;
	}
	
	/**
	 * 부서 정보 조회 페이지 이동 (add/edit/delete 그리드)
	 */
	
	@RequestMapping("/dept/deptEdit.do")
	@ResponseBody
	public ModelAndView deptEdit(@RequestParam Map<String, String> params){
		ModelAndView view = new ModelAndView();
		view.setViewName("dept/deptEdit");
		return view;
	}
	
	/**
	 * 부서 정보 수정
	 * update,insert,delete : 무조건 int로 반환
	 * 값을 받을때는 
	 */
	
	@RequestMapping("/dept/editDeptInfo.do")
	@ResponseBody
	public Map<String, Object> editDeptInfo(@RequestParam Map<String, String> params){
		
		logger.debug("editDeptInfo params : "+params);
		
		Map<String, Object> editValues = new HashMap<String, Object>();
		
		Departments dept = new Departments();
		dept.setDeptName(params.get("deptName"));
		dept.setDeptNo(params.get("deptNo"));
		
		int result = deptService.updateDepartments(dept);
		
		String msg = (result == 1) ? "수정되었습니다" : "수정실패!";
		
		editValues.put("result", result);
		editValues.put("msg", msg);
		
		return editValues;
	}
	
	/**
	 * 부서 정보 입력
	 */
	@RequestMapping("/dept/addDeptInfo.do")
	@ResponseBody
	public Map<String, Object> addDeptInfo(@RequestParam Map<String, String> params){
		
		logger.debug("addDeptInfo : " + params);
		
		Map<String, Object> addValues = new HashMap<String, Object>();
		
		Departments dept = new Departments();
		dept.setDeptName(params.get("deptName"));
		dept.setDeptNo(params.get("deptNo"));
		
		int result = deptService.addDepartments(dept);
		
		String msg = (result == 1) ? "입력되었습니다" : "입력실패!";
		
		addValues.put("result", result);
		addValues.put("msg", msg);
		
		return addValues;
		
	}
	
	/**
	 * 부서 정보 삭제 그리드
	 */
	@RequestMapping("/dept/delDeptInfo.do")
	@ResponseBody
	public Map<String, Object> delDeptInfo(@RequestParam Map<String, String> params){
		
		logger.debug("delDeptInfo : " + params);
		
		Map<String, Object> delValues = new HashMap<String, Object>();
		
		String deptNo = params.get("id"); //deptNo가 아닌 id? jsonReader 에서 id 값에 컬럼이름지정 그 값이 컬럼들의 구분값(pk값) 
		
		int result = deptService.deleteDepartments(deptNo);
		
		String msg = (result == 1) ? "삭제되었습니다." : "삭제실패!";
		
		delValues.put("result", result);
		delValues.put("msg", msg);
		
		return delValues;
		
	}
	
	/**
	 * 부서 정보 삭제 버튼
	 */
	@RequestMapping("/dept/delDeptInfoButton.do")
	@ResponseBody
	public Map<String, Object> delDeptInfoButton(@RequestParam Map<String, Object> params){
		
		logger.debug("delDeptInfoButton : " + params);
		
		Map<String, Object> delValues = new HashMap<String, Object>();
		
		int result = deService.delDeptInfoButton(params);
		
		String msg = (result == 1) ? "입력되었습니다" : "입력실패!";
		
		delValues.put("result", result);
		delValues.put("msg", msg);
		
		return delValues;
		
	}
	
	/**
	 * 부서 정보 조회 (검색조건)
	 */
	
	@RequestMapping("dept/deptSearch.do")
	public ModelAndView deptSearch (@RequestParam Map<String, Object> params){
		
		logger.debug("deptSearch : " + params);
		
		ModelAndView view = new ModelAndView();
		
		view.setViewName("dept/deptSearch");
		
		return view;
		
	}
	
	/**
	 * select box 생성하기위한 부서코드 get
	 */
	@RequestMapping("/dept/getSelectBoxData.do")
	@ResponseBody
	public List<Departments> getSelectBoxData(@RequestParam Map<String, String> params){
		logger.debug("getSelectBoxData : "+ params);
		System.out.println("deptNo >> "+params);
		List<Departments> list = deptService.list(params);
		
		return list;
	}
	
	/**
	 * 부서 정보 엑셀 다운로드 페이지 이동
	 * 
	 * @param params
	 * @return
	 */
	@RequestMapping("/dept/deptGridExcelPage.do")
	@ResponseBody
	public ModelAndView deptGridExcelPage(@RequestParam Map<String, String> params){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dept/deptGridExcel");
		return mv;
	}
	
	/**
	 * 부서 정보 엑셀 다운로드
	 * @param params
	 * @return
	 *  엑셀을 파라미터로 데이터값을가져올수없어서 request와 resonse 로 받은뒤 파라미터를 담는다.
	 */
	@RequestMapping("/dept/deptEditExcel.do")
	public void deptListExcel(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> params){
		
		logger.debug("deptListExcel params > "+params);
		
		//parameter for paging 
		//int totalCount = deptService.totalCount(params);		// 총 게시글 수
		
		//params.put("start", "0");
		//params.put("end", String.valueOf(totalCount));
		
		List<Departments> list = deptService.list(params);
		//엑셀의 depts 는? list에서 가져온걸 map에 넣는데 그 이름이 depts
		//엑셀에서 자동으로 for문이 돌아가 데이터를 가져와준다
		
		
		Map<String, Object> beans = new HashMap<String, Object>();
        beans.put("depts", list);
        // request, response, 출력 데이터, 파일명, 템플릿 파일명
		excel.exportExcel(request, response, beans, "departments", "departments");
	}
	
	
	

	/**
	 * 부서변경 페이지 (modal)
	 * @return
	 */
	@RequestMapping("/dept/chagneDeptInfo.do")
	public String getChangeDeptEmpPage() {
		return "dept/changeDeptEmpPopup";
		//jsp가 리턴된다. ? @RequestMapping 어노테이션으로 인해 리턴형이 void 여도 무조건 리턴되는 값이 있다 . 안적어주면 스프링이 맵핑 url 을 jsp로 바뀌면서 리턴된다.
		//
	}
	
	/**
	 * 부서변경 저장
	 * @param params
	 */
	@RequestMapping("/dept/changeDept.do")
	@ResponseBody
	public Map<String, Object> changeDept(@RequestParam Map<String, Object> params){
		Map<String, Object> retValues = new HashMap<String, Object>();
		logger.debug("chnageDeptEmpInfo params > " + params);
		
		int result = 0; 	// 코드
		String msg = null;	// 메세지
		try{
			
			result = deService.updateDeptEmp(params);
			
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
