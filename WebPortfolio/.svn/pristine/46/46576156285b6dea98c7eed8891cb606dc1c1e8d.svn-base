package com.pf.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.swing.plaf.synth.SynthSplitPaneUI;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pf.common.Notice;
import com.pf.service.NoticeService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
		"file:src/main/resources-local/database/Spring-Datasource.xml",
		"file:src/main/resources-local/beans/Spring-Beans.xml"
})

public class NoticeTest {
	
	//private static Log log = LogFactory.getLog(EmployeesServiceTest.class);
	
	@Resource(name="noticeService") //EmployeesServiceImpl 의 value 값
	private NoticeService noticeService;
	

	@Test
	public void list(){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("start",1);
		params.put("end", 1000);
		
		List<Notice> list = noticeService.list(params);
		//System.out.println("deps : "+deps.size());
		
		for(int i=0; i<list.size(); i++){
			System.out.println(list.get(i));
		}
	}
	
	@Test
	public void findTotalNotice(){
		int result = noticeService.findTotalNotice();
		System.out.println("findTotalNotice"+result);
	}
	
	@Test
	public void insertNotice(){
		
		String name = "홍길동";
		String password = "45678912a";
		String title = "123";
		String content = "123";
		String hasFile = "1";
		
		Notice notice = new Notice();
		
		notice.setName(name);
		notice.setPassword(password);
		notice.setTitle(title);
		notice.setContent(content);
		notice.setHasFile(hasFile);

		int result = noticeService.insertNotice(notice);
		System.out.println(result);
		
	}
	
	@Test
	public void getBoard(){
		
		int no=101;
		Notice result=noticeService.getNotice(no);
		System.out.println("getBoard : "+result);
		
		
	}
	
	@Test
	public void makePassword(){
		String password = "1234567a";
		String makepw=noticeService.makePassword(password);
		System.out.println("make password : "+ makepw);
	}
	
	@Test
	public void modifyBoard(){
		
		int no = 1284;
		String name = "홍길동수정";
		String password = "1234567a";
		String title = "타이틀수정";
		String content = "내용수정";
		String hasFile = "1";
		
		Notice notice = new Notice();
		
		notice.setNo(1284);
		notice.setName(name);
		notice.setPassword(password);
		notice.setTitle(title);
		notice.setHasFile(hasFile);
		notice.setContent(content);
		
		int result = noticeService.modifyNotice(notice);
		System.out.println("수정성공시 반환값 : "+result);
		
		
	}
	
	@Test
	public void deleteBoard(){
		int no=1287;
		int result = noticeService.deleteNotice(no);
		System.out.println("삭제성공시 반환값 : "+result);
	}
	
	

}
