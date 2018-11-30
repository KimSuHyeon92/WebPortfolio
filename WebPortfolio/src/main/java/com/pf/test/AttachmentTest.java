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

import com.pf.common.Attachment;
import com.pf.common.Notice;
import com.pf.service.AttachmentService;
import com.pf.service.NoticeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
		"file:src/main/resources-local/database/Spring-Datasource.xml",
		"file:src/main/resources-local/beans/Spring-Beans.xml"
})
public class AttachmentTest {
	//private static Log log = LogFactory.getLog(EmployeesServiceTest.class);

	@Resource(name="attachmentService") //EmployeesServiceImpl 의 value 값
	private AttachmentService attService;

	@Resource(name="noticeService") //noticeServiceImpl 의 value 값
	private NoticeService noticeService;

	@Test
	public void addAttachment(){

		String name = "첨부파일입력";
		String password = "1234567a";
		String title = "첨부파일입력";
		String content = "첨부파일입력";
		String hasFile = "1";

		Notice notice = new Notice();
		notice.setName(name);
		notice.setPassword(password);
		notice.setTitle(title);
		notice.setContent(content);
		notice.setHasFile(hasFile);
		noticeService.insertNotice(notice);

		String attachDocType = "test";
		int attachDocKey = notice.getNo();
		String filename = "test";
		String fakeName = "test";
		long fileSize = 1;
		String contentType = "notice";


		Attachment attach = new Attachment();
		attach.setAttachDocType(attachDocType);
		attach.setAttachDocKey(attachDocKey);
		attach.setFilename(filename);
		attach.setFakeName(fakeName);
		attach.setFileSize(fileSize);
		attach.setContentType(contentType);
		attService.addAttachment(attach);

	}

	@Test
	public void getAttachment(){

		 Map<String, Object> params = new HashMap<String, Object>();
	      params.put("attachDocType", "test3");
	      params.put("attachDocKey", "369");
	      Attachment attach = attService.getAttachment(params);

		
	}


	@Test
	public void testdelete(){
		
		 int attachSeq = 4;
	      
	      Attachment attach = new Attachment();
	      attach.setAttachSeq(attachSeq);
	      
	      attService.deleteAttachment(attach);
	      
	     
	      Notice notice = new Notice();
	      
	      int no = 374;
	      String hasFile="0";
	      String title = "제목입니다 수정";
	      String content = "내용 수정";
	      
	      notice.setNo(no);
	      notice.setHasFile(hasFile);
	      notice.setTitle(title);
	      notice.setContent(content);
	      
	      noticeService.modifyNotice(notice);

		
		
	}


}
