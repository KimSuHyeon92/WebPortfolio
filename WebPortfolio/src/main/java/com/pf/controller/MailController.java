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
	public Map<String, Object> addEmail( @RequestParam Map<String, String> params,HttpServletRequest request, HttpServletResponse response){
		logger.debug("addEmail params > " + params);
		//System.out.println("메일보내기탐 >>>>>"+params.get("mailOverOk"));
		Map<String, Object> retValues = new HashMap<String, Object>();
		
		try{
		
			if("Y".equals(params.get("sendProfile"))){ //개인프로필보내기일때
				//System.out.println("개인프로필보내기탐>>>>>>>>>>>");
				params.put("sender", "kimsuhyeon1027@gmail.com");
	       		params.put("subject", "신입 웹개발자 김수현 이력서 입니다.");
	       		params.put("content", "안녕하세요? 신입 웹개발자 김수현이력서 를 받아주셔서 감사합니다.");
	       		
				attachResource = ctx.getResource("classpath:attach/kimsuhyeonprofile.docx");
				
				File f = attachResource.getFile();
				//System.out.println(f.getAbsolutePath());
				
				params.put("filename", f.getName());
				//System.out.println("111111111"+params.get("filename"));
				params.put("fileSize", String.valueOf(f.length()));
				//System.out.println("222222222"+params.get("fileSize"));
				
				params.put("attachFilePath", attachResource.getFile().getAbsolutePath()); //파일의절대경로
				//System.out.println("333333333"+params.get("attachFilePath"));
				
			} else if("Y".equals(params.get("mailOverOk"))){ //회원가입일때
				//System.out.println("회원가입탐>>>>>>>>>>>");
				params.put("sender", "kimsuhyeon1027@gmail.com");
	       		params.put("subject", "김수현 포트폴리오 회원가입 인증메일");
	       		
	       		String authNum = "";
				authNum = RandomNum();
				retValues.put("authNum", authNum); //view 로 인증번호를 넘겨준다.
				params.put("authNum", authNum); //params 에 넣어 메일로 보내준다.
	   			
	   			String html = "";
				html +=("<p>안녕하세요? 신입 웹개발자 김수현 사이트를 가입해주셔서 감사합니다.</p>");
				html +=("<p>아래 인증번호를 홈페이지에서 입력하신후 인증확인버튼 을 누르시면 인증확인이 완료됩니다.</p>");
				html +=("<p>인증번호 [");
				html +=(params.get("authNum") );
				html +=("]</p>");
				params.put("content", html);
   
			} else if("Y".equals(params.get("resetPwYn"))){ //비밀번호찾기일때
				params.put("sender", "kimsuhyeon1027@gmail.com");
	       		params.put("subject", "김수현 포트폴리오 비밀번호 변경 인증번호를 보내드립니다.");
	       		
	       		String authNum = "";
				authNum = RandomNum();
				HttpSession session = request.getSession();
				session.setAttribute("authNum", authNum); //세션 로 인증번호를 넘겨준다.
				params.put("authNum", authNum); //params 에 넣어 메일로 보내준다.
	   			
	   			String html = "";
				html +=("<p>비밀번호 변경 인증번호 를 확인해주시고 홈페이지에서 인증번호를 입력해주세요.</p>");
				html +=("<p>인증번호 [");
				html +=(params.get("authNum") );
				html +=("]</p>");
				params.put("content", html);
				retValues.put("userEmail", params.get("receiver"));
			}
		
			int EmailCode = emService.addEmail(params);
			
			if(EmailCode > 0){
				
				int sendCode = mail.sendEmail(params);
				
				if(sendCode == 1 ){
					retValues.put("resultCode", 1);
					//System.out.println("이메일 send 성공=================");
				}else{
					retValues.put("resultCode", -2);
					//System.out.println("이메일 send 실패=================");
				}
				
				//System.out.println("이메일 add 성공=================");
				
			}else{
				retValues.put("resultCode", -1);
				//System.out.println("이메일 add 실패=================");
			}
		
		}catch (Exception e) {
			e.printStackTrace();
			retValues.put("resultCode", 0);
			//System.out.println("이메일 컨트롤러접근 실패=================");
		}
		
		return retValues;
		
		
		
	}
	
	
	
}
