package com.pf.test;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pf.util.MailUtil;


@RunWith(SpringJUnit4ClassRunner.class)
//스프링설정파일
@ContextConfiguration(locations = {
		"file:src/main/resources-local/beans/Spring-Beans.xml",
		"file:src/main/resources-local/database/Spring-Datasource.xml"
			})
public class MailSendTest {
	
	//private Logger logger = Logger.getLogger(MailSendTest.class);
	
	@Autowired 
	ApplicationContext ctx;
	//

	@javax.annotation.Resource(name="mailUtil")
    private MailUtil mail;
	
	Resource attachResource;
	
	@Test
	public void send() {
		try {
			//내프로필 메일보낼때 저장해서 항상 보내주기 설정
			//attach 아래에 image1.jpg 가 있다.
			//읽어와서 첨부파일로저장후 메일보내기
			attachResource = ctx.getResource("attach/image1.jpg");
//			File f = attachResource.getFile();
//			System.out.println(f.getAbsolutePath());
			
			Map<String, String> params = new HashMap<String, String>();
			params.put("sender", "kisusu1027@gmail.com"); //보내는사람 , 내 메일주소
			params.put("receiver", "kisusu1027@gmail.com");
			params.put("subject", "메일 발송 테스트");
			params.put("content", "내 프로필을 받으라!");
			params.put("attachFilePath", attachResource.getFile().getAbsolutePath()); //파일의절대경로
		
			mail.sendEmail(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
