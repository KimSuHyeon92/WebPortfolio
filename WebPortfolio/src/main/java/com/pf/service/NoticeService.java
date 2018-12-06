package com.pf.service;

import java.util.List;
import java.util.Map;

import com.pf.common.Notice;
import com.pf.common.Comment;

public interface NoticeService {
	

	/** 게시글 리스트 불러오기
	 * @param params
	 * @return
	 */
	public List<Notice> list(Map<String, Object> params);

	/** 총 게시글수
	 * @return
	 */
	public int findTotalNotice();
	
	/** 게시글 작성하기 
	 * @param notice
	 * @return
	 */
	public int insertNotice(Notice notice);

	/** 해당 게시글 가져오기
	 * @param noticeNo
	 * @return
	 */
	public Notice getNotice(int noticeNo);

	/** 사용자 패스워드 암호화
	 * @param password
	 * @return
	 */
	public String makePassword(String password);

	/** 게시글 수정
	 * @param notice
	 * @return
	 */
	public int modifyNotice(Notice notice);

	/** 게시글 삭제 
	 * @param no
	 * @return
	 */
	public int deleteNotice(int no);

	/** 게시글 방문횟수
	 * @param noticeNo
	 * @return
	 */
	public int readCount(int noticeNo);
	
	/** 총게시글수
	 * @param params
	 * @return
	 */
	public int getRow(Map<String, Object> params);

	/** 댓글 쓰기 
	 * @param comment
	 * @return
	 */
	public int setComment (Comment comment);
	
	/** 댓글 리스트 불러오기
	 * @param noticeNo
	 * @return
	 */
	public List<Map<String, Object>> getComment(int noticeNo);
	
	/** 댓글 수정 그리드 화면
	 * @param commentNo
	 * @return
	 */
	public Comment modifyComment(int commentNo);
	
	/** 댓글 수정 
	 * @param comment
	 * @return
	 */
	public int updateComment(Comment comment);
	
	/** 댓글 삭제 
	 * @param commentNo
	 * @return
	 */
	public int deleteComment(int commentNo);
	
	/** 댓글 삭제 
	 * @param noticeNo
	 * @return
	 */
	public int deleteCommentNotice(int noticeNo);
	
}
