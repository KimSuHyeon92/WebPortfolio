package com.pf.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pf.util.FileUtil;



@Controller
public class FileController {
	
	//로그찍기
	private static Log logger = LogFactory.getLog(DepartmentsController.class);
	
	@Autowired
	private FileUtil fUtil;
	
	@Autowired 
	ApplicationContext ctx;
	
	/**
	 * 첨부파일 다운로드
	 * @param attachDocType		첨부한 파일의 게시판 유형 (공지사항 등)
	 * @param attachDocKey		첨부한 파일의 게시글 키(pk)
	 */
    @RequestMapping(value = "/file/getFile.do")
    @ResponseBody
    public byte[] getFile(@RequestParam Map<String, Object> params, HttpServletResponse response) {
	   return fUtil.getFile(response, params);
    }

   
    
}