package com.pf.service.impl;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.pf.common.Titles;
import com.pf.controller.SalariesController;
import com.pf.controller.TitlesController;
import com.pf.dao.TitlesDao;
import com.pf.service.TitlesService;

@Service("titlesService")
public class TitlesServiceImpl implements TitlesService {

	@Autowired
	TitlesDao dao;
	
	private static Log logger = LogFactory.getLog(SalariesController.class);
	
	@Override
	public int insertTitles(Map<String, Object> titles) {
		// TODO Auto-generated method stub
		return dao.insertTitles(titles);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateTitles(Map<String, Object> params) {
		// TODO Auto-generated method stub
		
		int update=0;
		int result=0;
		int msg = 0;
		
		try {
			//update 쿼리 실행으로 to_date 를 현재(now()) 로 변경해준다.
			update= dao.updateTitles(params);
			System.out.println("---------------------->연봉변경 업데이트 완료");
			//add 쿼리 실행으로 가
			result = dao.insertTitles(params);
			System.out.println("---------------------->연봉변경 입력 완료");
			
			msg=1;
		
		} catch (Exception e){
			logger.error("",e);
			
		}
		
		return msg;
	}

}
