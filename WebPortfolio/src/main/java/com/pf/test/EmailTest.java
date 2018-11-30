package com.pf.test;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pf.service.EmailService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
		"file:src/main/resources-local/database/Spring-Datasource.xml",
		"file:src/main/resources-local/beans/Spring-Beans.xml"
})

public class EmailTest {

	private static Log log = LogFactory.getLog(EmailTest.class);
	
	@Resource(name="EmailService")
	private EmailService emService;
	
	
	@Test
	public void addEmail(){
		
		String sender = "mg4186@daum.net";
		String receiver = "mg4186@naver.com";
		String subject = "이메일 보내기 제목 테스트 중입니다.";
		String content = "이메일 보내기 내용 테스트 중입니다.";
		String filename="이메일 보내기 첨부파일 테스트 중입니다.";
		String fileSize = "10";
		
		Map<String, String> params = new HashMap<String,String>();
		params.put("sender", sender);
		params.put("receiver", receiver);
		params.put("subject", subject);
		params.put("content", content);
		//params.put("sendDate", "2017-12-04");
		params.put("filename", filename);
		params.put("fileSize", fileSize);
		params.put("createDate", "2017-12-04");
		
		int result = emService.addEmail(params);
		
		System.out.println("addEmail >> "+result);
	
	}
	
	@Test
	public void getEmail(){
		
		int idx=4;
		System.out.println("getEmail >> "+emService.getEmail(idx));
		
		
	}
	
	@Test
	public void delEmail(){
		
		int idx=4;
		System.out.println(emService.deleteEmail(idx));
			
	}
	
	@Test
	public void updateEmail(){
		
		String sender = "mg4186@daum.net";
		String receiver = "mg4186@naver.com";
		String subject = "이메일 보내기 제목 테스트 중입니다.";
		String content = "이메일 보내기 내용 테스트 중입니다.";
		String filename="이메일 보내기 첨부파일 테스트 중입니다.";
		String fileSize = "10";
		
		Map<String, String> params = new HashMap<String,String>();
		params.put("sender", sender);
		params.put("receiver", receiver);
		params.put("subject", subject);
		params.put("content", content);
		//params.put("sendDate", "2017-12-04");
		params.put("filename", filename);
		params.put("fileSize", fileSize);
		params.put("createDate", "2017-12-04");
		
		int add = emService.addEmail(params);
		
		System.out.println("addEmail >> "+ add);
			
		params.put("filename", "2.이메일 보내기 첨부파일 테스트 중입니다.");
		params.put("fileSize", "20");
		
		
		int update = emService.updateEmail(params);
		
		System.out.println("updateEmail >> "+ update);
		
	}
	
	
}
