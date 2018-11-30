package com.pf.controller;

import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pf.common.Member;
import com.pf.service.MemberService;
import com.pf.service.NoticeService;

@Controller
public class MemberController {
	private static Log logger = LogFactory.getLog(DepartmentsController.class);
	
	@Autowired
	MemberService memberservice;
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 회원 이메일중복체크.
	 */
	@RequestMapping("/member/mailCheck.do")
	@ResponseBody
	public int mailCheck (@ModelAttribute Member vo)throws Exception{
		//System.out.println("컨트롤러탐 >>>>>>>>>>>>>");
		ModelAndView mv = new ModelAndView();
		int ResultCode = 0;
		
		Member basic = memberservice.selectCustBase(vo); //회원정보조회
		//System.out.println("회원정보조회성공 >>>>>>>>>>>>>");
		
		if(basic == null || basic.getUserEmail() == "") { //이메일이 DB에 없을경우 (등록된 회원이 아님)
			ResultCode = 1;
		}else if (basic != null || basic.getUserEmail() != ""){
			ResultCode = -1;
		}
		
		return ResultCode;
		
		
	}
	
	
	/**
	 * 회원가입
	 */
	@RequestMapping("/member/joinUs.do")
	@ResponseBody
	public Map<String, Object> joinUs (@ModelAttribute Member vo,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//System.out.println("회원가입 컨트롤러 탐>>>>>>>>>>>");
		Map<String, Object> retValues = new HashMap<String, Object>();
		
		/*HttpSession session = request.getSession();
        PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
        session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
		
        if (privateKey == null) {
            throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
        }*/
        
        int resultcode = memberservice.userInsert(vo); // 회원 insert
		
        if(resultcode > 0){
        	retValues.put("retValues", resultcode);
        }else{
        	retValues.put("retValues", resultcode);
        }
        
		return retValues;
		
	}
	
    
    /**
	 * 로그인
	 */
	@RequestMapping("/member/LoginUs.do")
	@ResponseBody
	public Map<String, Object> LoginUs (@ModelAttribute Member vo,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//System.out.println("로그인 컨트롤러 탐>>>>>>>>>>>");
		Map<String, Object> retValues = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
        
        Member basic = memberservice.selectCustBase(vo); //회원정보조회
        
        if( basic == null || "".equals(basic)){ //회원정보조회실패
        	//System.out.println("회원가입안되있슴");
        	retValues.put("retValues", "0"); //실패
        }else if( basic != null && !"".equals(basic) ){
        	//System.out.println("회원가입되어있는아이디");
        	//입력받은 패스워드를 바로 암호화 시킨다
        	String makepass = noticeService.makePassword(vo.getUserPassword());
        	//System.out.println("사용자 암호화 패스워드 값 : "+makepass);
        	//System.out.println("디비에 저장된 암호화 패스워드 값 : "+basic.getUserPassword());
        	
        	if ( basic.getUserPassword().equals(makepass) ){
        		retValues.put("retValues", "1"); //로그인성공
        		retValues.put("UserEmail", basic.getUserEmail());
        		retValues.put("UserName", basic.getUserName());
        		session.setAttribute("isLogin", true); // 로그인여부 세션 저장
        		session.setAttribute("LoginId", basic.getUserEmail()); // 로그인 아이디 세션 저장
        		session.setAttribute("LoginName", basic.getUserName());
        		//System.out.println("세션값"+session.getAttribute("LogindUser"));
        	}else{
        		//System.out.println("패스워드틀림");
        		retValues.put("retValues", "-1"); //패스워드 틀림
        	}
        	
        	
        	
        }
        
		return retValues;
		
	}
	
	/**
	 * 로그아웃
	 */
	@RequestMapping("/member/logOut.do")
	@ResponseBody
	public ModelAndView logOut(@RequestParam Map<String, String> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//System.out.println("로그아웃");
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		//System.out.println("로그아웃0");
		session.invalidate();
		//System.out.println("로그아웃1");
		mv.setViewName("bootIndex");
		//System.out.println("로그아웃2");
		return mv;
		}
}
