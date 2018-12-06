package com.pf.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pf.common.Notice;
import com.pf.common.Comment;
import com.pf.dao.NoticeDao;
import com.pf.service.NoticeService;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDao dao;

	@Override
	public List<Notice> list(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.list(params);
	}

	@Override
	public int findTotalNotice() {
		// TODO Auto-generated method stub
		return dao.findTotalNotice();
	}

	@Override
	public int insertNotice(Notice newBoard) {
		// TODO Auto-generated method stub
		return dao.insertNotice(newBoard);
	}

	@Override
	public Notice getNotice(int boardNo) {
		// TODO Auto-generated method stub
		return dao.getNotice(boardNo);
	}

	@Override
	public String makePassword(String password) {
		// TODO Auto-generated method stub
		return dao.makePassword(password);
	}

	@Override
	public int modifyNotice(Notice board) {
		// TODO Auto-generated method stub
		return dao.modifyNotice(board);
	}

	@Override
	public int deleteNotice(int no) {
		// TODO Auto-generated method stub
		return dao.deleteNotice(no);
	}

	@Override
	public int readCount(int boardNo) {
		return dao.readCount(boardNo);
		
	}

	@Override
	public int getRow(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.getRow(params);
	}

	@Override
	public int setComment(Comment comment) {
		// TODO Auto-generated method stub
		return dao.setComment(comment);
	}

	@Override
	public List<Map<String, Object>> getComment(int noticeNo) {
		// TODO Auto-generated method stub
		return dao.getComment(noticeNo);
	}

	@Override
	public Comment modifyComment(int commentNo) {
		// TODO Auto-generated method stub
		return dao.modifyComment(commentNo);
	}

	@Override
	public int updateComment(Comment comment) {
		// TODO Auto-generated method stub
		//System.out.println("여기까지는타냐 >>>>>>>>>>>");
		return dao.updateComment(comment);
	}

	@Override
	public int deleteComment(int commentNo) {
		// TODO Auto-generated method stub
		return dao.deleteComment(commentNo);
	}

	@Override
	public int deleteCommentNotice(int noticeNo) {
		// TODO Auto-generated method stub
		return dao.deleteCommentNotice(noticeNo);
	}

}
