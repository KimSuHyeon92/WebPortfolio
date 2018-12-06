package com.pf.util;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

//beans.xml 에서 scan해서 @component 읽어옴
@Component
public class MailUtil {

	//@Autowired 어디선가 bean으로 등록되어있다는 의미
	@Autowired
    protected JavaMailSender  mailSender;
	
	public int sendEmail(Map<String, String> params) throws Exception { 
		MimeMessage msg = mailSender.createMimeMessage();
		//System.out.println("메일유틸컨트롤러탐 >>> " + params);
		
		try{
		
			MimeMessageHelper helper = new MimeMessageHelper(msg, true,"UTF-8");
			//Mime:메세지 생성 helper:내용추가 
			//String result="";
			
			//dto사용시
			helper.setFrom(params.get("sender"));
			helper.setTo(params.get("receiver"));
			helper.setSubject(params.get("subject"));
			
			if("Y".equals(params.get("mailOverOk")) || "Y".equals(params.get("resetPwYn"))){ //인증메일일경우 본문다름
				
				//System.out.println("mailOverOk 탐 >>> " + params);
				helper.setText(params.get("content"), true);
				//result = "회원가입인증메일본문";
				//System.out.println("회원가입인증메일본문 >>>>>>> "+helper);
				
			}else if("Y".equals(params.get("sendProfile"))){ //프로필보내기일경우
				helper.setText(params.get("content"));
				
				File tempFile = new File(params.get("attachFilePath"));
				//System.out.println("tempFile >> " + tempFile);
			
				FileSystemResource file = new FileSystemResource(tempFile);
				/*System.out.println("-------------------------------------------------------------------");
				System.out.println("attach file path : "+tempFile.getAbsolutePath());
				System.out.println("attach file name : "+tempFile.getName());
				System.out.println("attach file size : "+tempFile.length());
				System.out.println("-------------------------------------------------------------------");*/
				
				helper.addAttachment(file.getFilename(), file);
				params.put("filename", tempFile.getName());
				params.put("fileSize", String.valueOf(tempFile.length()));
	
				/*System.out.println("helper >>>>>>>> "+file.getFilename());
				System.out.println("params filename >>>>>>>> "+params.get("filename"));
				System.out.println("params fileSize >>>>>>>> "+params.get("fileSize"));*/
				
				//result = "이력서메일보내기본문";
				//System.out.println("이력서메일보내기본문 >>>>>>> "+helper);
		
			}
			
			//System.out.println("text >>>>>>"+result);
			
			mailSender.send(msg); //최종적으로메일을보낸다
			
			//System.out.println("메일보내기성공 >>>>>>>>>>>>>>>>");
			return 1;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
			
	}
}
