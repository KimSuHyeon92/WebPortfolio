package com.pf.common;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("Comment")
public class Comment {

	private int commentNo;
	private int noticeNo;	
	private String comment;		
	private String writer;		
	private String writerPw;	
	private String createDate;	
	private String updateDate;
	private String cmtyYn;
	
	
	
	public String getCmtYn() {
		return cmtyYn;
	}
	public void setCmtYn(String cmtyYn) {
		this.cmtyYn = cmtyYn;
	}
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWriterPw() {
		return writerPw;
	}
	public void setWriterPw(String writerPw) {
		this.writerPw = writerPw;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}	
	
	
}
