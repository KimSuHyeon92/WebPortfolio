package com.pf.dao;
import java.util.Map;

import com.pf.common.Attachment;


public interface AttachmentDao {
	// 첨부파일 정보 가져오기
	Attachment getAttachment(Map<String, Object> params);
	// 첨부파일 정보 입력
	int addAttachment(Attachment attach);
	// 첨부파일 정보 삭제
	public int deleteAttachment(int attachSeq);


}
