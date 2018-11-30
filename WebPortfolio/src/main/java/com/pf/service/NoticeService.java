package com.pf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.pf.common.Notice;
import com.pf.common.Comment;
import com.pf.common.Departments;




public interface NoticeService {
	

	public List<Notice> list(Map<String, Object> params);

	public int findTotalNotice();
	
	public int insertNotice(Notice notice);

	public Notice getNotice(int noticeNo);

	public String makePassword(String password);

	public int modifyNotice(Notice notice);

	public int deleteNotice(int no);

	public int readCount(int noticeNo);
	
	public int getRow(Map<String, Object> params);

	public int setComment (Comment comment);
	
	public List<HashMap<String, Object>> getComment(int noticeNo);
	
	public Comment modifyComment(int commentNo);
	
	public int updateComment(Comment comment);
	
	public int deleteComment(int no);
	
	public int deleteCommentNotice(int no);
}
