package com.pf.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pf.common.CertEmail;
import com.pf.service.EmailService;
import com.pf.util.MailUtil;

@Controller
public class MailController {

	//로그찍기
	private static Log logger = LogFactory.getLog(DepartmentsController.class);
	
	@Autowired
	private EmailService emService;
	
	@Autowired 
	ApplicationContext ctx;
	

	@javax.annotation.Resource(name="mailUtil")
    private MailUtil mail;
	
	Resource attachResource;
	
	/**
	 * 개인프로필
	 * @param params
	 * @return
	 */
	@RequestMapping("mail/profile.do")
	public ModelAndView profile(@RequestParam Map<String, String> params) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("mail/profile");
		return mv;
	}
	
	/**
	 * 회원인증메일
	 * @param params
	 * @return
	 */
	@RequestMapping("mail/mailOk.do")
	public ModelAndView mailOk(@RequestParam Map<String, String> params) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("mail/mailOk");
		return mv;
	}
	
	/**
	 * 메일보내기
	 */
	@RequestMapping("mail/mailpost.do")
	public String mailpost(){
		return "/mail/mailpost";
	}
	
	
	
	public String RandomNum(){
		StringBuffer buffer = new StringBuffer();
		for ( int i=0; i<= 6; i++){
			int n = (int) (Math.random() * 10);
			buffer.append(n);
		}
		return buffer.toString();
	}
	
	/**
	 * 메일 입력,업데이트
	 */
	@RequestMapping("mail/addEmail.do")
	@ResponseBody
	public Map<String, Object> addEmail( @RequestParam Map<String, String> params,ModelMap model,HttpServletRequest request, HttpServletResponse response){
		logger.debug("addEmail params > " + params);
		//System.out.println("메일보내기탐 >>>>>"+params.get("mailOverOk"));
		Map<String, Object> retValues = new HashMap<String, Object>();
		String msg = null;
		
		
		try{
		
			if("Y".equals(params.get("sendProfile"))){
				attachResource = ctx.getResource("classpath:attach/kimsuhyeonprofile.docx");
				
				File f = attachResource.getFile();
				//System.out.println(f.getAbsolutePath());
				
				params.put("filename", f.getName());
				//System.out.println("111111111"+params.get("filename"));
				params.put("fileSize", String.valueOf(f.length()));
				//System.out.println("222222222"+params.get("fileSize"));
				
				params.put("attachFilePath", attachResource.getFile().getAbsolutePath()); //파일의절대경로
				//System.out.println("333333333"+params.get("attachFilePath"));
			}
		
		emService.addEmail(params);
		System.out.println("이메일 add 성공=================");
		
		if("Y".equals(params.get("mailOverOk"))){
			String authNum = "";
			authNum = RandomNum();
			retValues.put("authNum", authNum); 
	        params.put("authNum", authNum); //params 에 넣어 메일로 보내준다.
		}
		
		mail.sendEmail(params);
		System.out.println("이메일 send 성공=================");
		
		
		
		//System.out.println("메일인증테이블 add 성공================="+basic.getCertYn()+basic.getSendEmail()+basic.getUserEmail()+basic.getIdx());
		
		emService.updateEmail(params);
		System.out.println("이메일 update 성공=================");
		
		msg = "메일보내기 성공";
		
		retValues.put("msg", msg);
		
		
		}catch (Exception e) {
			msg = "메일보내기 실패";
			
			retValues.put("msg", msg);
			
		}
		
		return retValues;
		
		
		
	}
	
	
	
}
