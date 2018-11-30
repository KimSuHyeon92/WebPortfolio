package com.pf.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pf.common.CertEmail;
import com.pf.service.EmailService;
import com.pf.util.MailUtil;

@Controller
public class IndexController {
	
	private static Log logger = LogFactory.getLog(DepartmentsController.class);
	
	@Autowired
	private EmailService emService;
	
	@Autowired 
	ApplicationContext ctx;
	//

	@javax.annotation.Resource(name="mailUtil")
    private MailUtil mail;
	
	Resource attachResource;


	/**
	 * jQuery UI 테마 메인페이지 이동.
	 */
	@RequestMapping("/j-index.do")
	public ModelAndView goIndex(@RequestParam Map<String, String> params) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		return mv;
	}
	
	/**
	 * 부트스트랩 테마 메인페이지 이동.
	 */
	@RequestMapping("/index.do")
	@ResponseBody
	public ModelAndView goBootstrapIndex(@RequestParam Map<String, String> params) throws Exception  {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("bootIndex");
		return mv;
	}
	
	/**
	 * 첫 페이지
	 * @param params
	 * @return
	 */
	@RequestMapping("/home.do")
	public ModelAndView home(@RequestParam Map<String, String> params,HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		
		mv.setViewName("home");
		return mv;
	}
	
	
	
	
}
