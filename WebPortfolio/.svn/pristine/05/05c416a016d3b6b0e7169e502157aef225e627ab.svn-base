package com.pf.service.impl;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pf.common.Attachment;
import com.pf.dao.AttachmentDao;
import com.pf.service.AttachmentService;



@Service("attachmentService")
public class AttachmentServiceImpl implements AttachmentService{
	
	Log logger = LogFactory.getLog(this.getClass());
	
	@Autowired
	private AttachmentDao dao;
	
	@Override
	public Attachment getAttachment(Map<String, Object> params){
		return dao.getAttachment(params);
	}

	@Override
	@Transactional
	public int addAttachment(Attachment attach) {
		return dao.addAttachment(attach);
	}

	@Override
	@Transactional
	public int deleteAttachment(Attachment attach) {
		return dao.deleteAttachment(attach.getAttachSeq()); 
	}
	
}
