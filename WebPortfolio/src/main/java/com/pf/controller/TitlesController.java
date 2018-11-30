package com.pf.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pf.service.TitlesService;

@Controller
public class TitlesController {
	private static Log logger = LogFactory.getLog(TitlesController.class);
	
	@Autowired
	private TitlesService tiService;
	
	/**
	 * 타이틀변경페이지이동
	 */
	@RequestMapping("/titles/changeTitlesInfo.do")
	public String getChangeTitlePage() {
		return "/titles/changeTitlesPopup";
	}
	
	/**
	 * 타이틀변경 
	 */
	@RequestMapping("/titles/changetitles.do")
	@ResponseBody
	public Map<String, Object> getChangeTitle(@RequestParam Map<String, Object> params,HttpServletRequest request){
		Map<String, Object> retValues = new HashMap<String, Object>();
		logger.debug("getChangeTitle params > " + params);
		
		int result = 0; 	// 코드
		String msg = null;	// 메세지
		try{
			
			result = tiService.updateTitles(params);
			
			msg = (result == 1) ? "변경 되었습니다." : "실패!";
			
			//내가작성한글
			HttpSession session = request.getSession();
			
			if( session.getAttribute("LoginId") != null || session.getAttribute("LoginId") != "" ){//로그인이되어있는사람이 직함변경에 성공했을경우
				//
				
				
			}
			
		}catch (Exception e) {
			logger.error("", e);
			msg = "실패!";
		}
		
		retValues.put("result", result);
		retValues.put("msg", msg);
		
		return retValues;
		
	}
	
	
}
