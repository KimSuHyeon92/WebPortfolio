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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoteController {

	//로그찍기
	private static Log logger = LogFactory.getLog(DepartmentsController.class);

	@Autowired 
	ApplicationContext ctx;

	/**
	 * 제작노트
	 */
	@RequestMapping("note/makenote.do")
	public ModelAndView makenote(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("note/makenote");
		return mv;
	}


	/**
	 * employees jpg파일 다운로드
	 */
	@RequestMapping(value="/note/empdownModelingImg.do")
	@ResponseBody
	public byte[] EmpGetImgFile(HttpServletResponse response, Map<String, Object> params){
		try {
			File file = ctx.getResource("classpath:attach/employees.jpg").getFile();

			//한글 파일명 utf8
			String encodingName = java.net.URLEncoder.encode(file.getName(), "UTF-8");

			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingName + "\"");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");


			return FileUtils.readFileToByteArray(file);
		} catch(IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		}

	}
	
	/**
	 * employees mvb파일 다운로드
	 */
	@RequestMapping(value="/note/empdownModelingmvb.do")
	@ResponseBody
	public byte[] EmpGetMwbFile(HttpServletResponse response, Map<String, Object> params){
		try {
			File file = ctx.getResource("classpath:attach/employees.mwb").getFile();

			//한글 파일명 utf8
			String encodingName = java.net.URLEncoder.encode(file.getName(), "UTF-8");

			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingName + "\"");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");


			return FileUtils.readFileToByteArray(file);
		} catch(IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		}

	}
	
	/**
	 * board jpg파일 다운로드
	 */
	@RequestMapping(value="/note/brddownModelingImg.do")
	@ResponseBody
	public byte[] BrdGetImgFile(HttpServletResponse response, Map<String, Object> params){
		try {
			File file = ctx.getResource("classpath:attach/board.jpg").getFile();

			//한글 파일명 utf8
			String encodingName = java.net.URLEncoder.encode(file.getName(), "UTF-8");

			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingName + "\"");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");


			return FileUtils.readFileToByteArray(file);
		} catch(IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		}

	}
	
	/**
	 * board mvb파일 다운로드
	 */
	@RequestMapping(value="/note/brddownModelingmvb.do")
	@ResponseBody
	public byte[] BrdGetMwbFile(HttpServletResponse response, Map<String, Object> params){
		try {
			File file = ctx.getResource("classpath:attach/board.mwb").getFile();

			//한글 파일명 utf8
			String encodingName = java.net.URLEncoder.encode(file.getName(), "UTF-8");

			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingName + "\"");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");


			return FileUtils.readFileToByteArray(file);
		} catch(IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		}

	}
	
	/**
	 * member jpg파일 다운로드
	 */
	@RequestMapping(value="/note/memdownModelingImg.do")
	@ResponseBody
	public byte[] MemGetImgFile(HttpServletResponse response, Map<String, Object> params){
		try {
			File file = ctx.getResource("classpath:attach/member.jpg").getFile();

			//한글 파일명 utf8
			String encodingName = java.net.URLEncoder.encode(file.getName(), "UTF-8");

			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingName + "\"");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");


			return FileUtils.readFileToByteArray(file);
		} catch(IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		}

	}
	
	/**
	 * email jpg파일 다운로드
	 */
	@RequestMapping(value="/note/maildownModelingImg.do")
	@ResponseBody
	public byte[] MailGetImgFile(HttpServletResponse response, Map<String, Object> params){
		try {
			File file = ctx.getResource("classpath:attach/email.jpg").getFile();

			//한글 파일명 utf8
			String encodingName = java.net.URLEncoder.encode(file.getName(), "UTF-8");

			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingName + "\"");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");


			return FileUtils.readFileToByteArray(file);
		} catch(IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		}

	}
	
	
}
