package com.pf.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.pf.common.Attachment;
import com.pf.common.Comment;
import com.pf.common.Notice;
import com.pf.service.NoticeService;
import com.pf.util.FileUtil;
import com.pf.util.JsonResponse;



@Controller
public class NoticeController {

	private static Log logger = LogFactory.getLog(NoticeController.class);

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private FileUtil fileUtil;
	
	

	/**
	 * 게시판 그리드 화면
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/noticeList.do")
	public ModelAndView listpage(@RequestParam Map<String, Object> params){

		// 파라미터가 콘솔창에서 로그로 찍힌다. 메소드 첫줄은 로그찍어서 파라미터를 받아오는걸 작성해줘야한다.
		logger.debug("noticecListPage params : "+params);

		// jsp 지정과 jsp 쓸 파라미터를 넣어 줄 수 있는 클래스인 ModelAndView 선언
		ModelAndView view = new ModelAndView();

		if(params.get("currentPageNo") != null) {
			// 뒤로가기 할 때 나올 현재 페이지
			int currentPageNo = Integer.valueOf(params.get("currentPageNo").toString());
			view.addObject("currentPageNo", currentPageNo);
		}
		// ViewResolver에 전달할 viewName 설정
		view.setViewName("notice/noticeList");
		// view에서보여줄 내용들 호출한 jsp로전달
		return view;

	}

	/** 게시판 리스트 화면
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/list.do")
	@ResponseBody //각각 HTTP 요청 몸체를 자바 객체로 변환하고 자바 객체를 HTTP 응답 몸체로 변환하는 데 사용된다. //return되는 값은 View를 통해서 출력되는 것이 아니라 HTTP Response Body에 직접쓰여지게 된다.
	public JsonResponse<Notice> list(@RequestParam Map<String, Object> params){
		logger.debug("getNoticeListData params > "+params);

		//parameter for paging 
		
		int pageSize = Integer.parseInt(params.get("rows").toString());	// 한 페이지에 보여줄 개수
		int currentPage = Integer.parseInt(params.get("page").toString());	// 현재 페이지
		int totalCount = noticeService.getRow(params);		// 총 게시글 수
		int totalPage = (totalCount % pageSize == 0)?(totalCount/pageSize):(totalCount/pageSize)+1;	// 총 페이지
		int start = (currentPage - 1) * pageSize;	// 시작 로우

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(pageSize));
		params.put("sidx", String.valueOf(params.get("sidx")));
		params.put("sord", String.valueOf(params.get("sord")));

		List<Notice> list = noticeService.list(params);
		
		//com.pf.util 에 제이슨파일에 있는 메소드들
		//jsonReader는 json방식으로 jqGrid에 맞는 json 형태로 가져와 page, rows, total, records 매핑된다.

		//서버단에서 데이터를 jqGrid의 json방식으로 만들어줘서 뿌려주면된다.

		JsonResponse<Notice> res = new JsonResponse<Notice>();
		res.setRows(list); //전체리스트
		res.setPage(String.valueOf(currentPage)); //현재
		res.setTotal(String.valueOf(totalPage)); //총페이지
		res.setRecords(String.valueOf(totalCount)); //총몆개

		return res;

	}


	/** 게시판 읽기 화면
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/read.do")
	public ModelAndView read(@RequestParam Map<String, Object> params){
		
		logger.debug("goReadNotice params : "+params);
		
		// 뒤로가기 눌렀을 때 페이지 번호 있어야 함
		int currentPageNo = Integer.valueOf(params.get("currentPageNo").toString());  
		// 조회할 게시글 번호
		int NoticeNo = Integer.valueOf(params.get("noticeNo").toString());
		// 첨부파일 검색 첫번째 조건은 url에 get 방식으로 넘어온다. 없으면 기본값 notice 저장
		String attachDocType = params.containsKey("attachDocType") ? params.get("attachDocType").toString() : "notice";
		//containsKey : 해당키값이 있는지여부 boolean형 으로 반환
		noticeService.readCount(NoticeNo); //방문횟수
		
		// jsp 지정과 jsp 쓸 파라미터를 넣어 줄 수 있는 클래스인 ModelAndView 선언
		ModelAndView model = new ModelAndView();
		
		Notice resultMap = noticeService.getNotice(NoticeNo); //게시글번호로 게시글 가져온다.
		
		// ' " 바꾸기 
		String content = resultMap.getContent().toString();
		content = content.replace("\'", "'");
		content = content.replace("\\\"", "\"");
		// 바꾼 content 다시 꺼낸 곳에 넣어주기
		resultMap.setContent(content);
		
		// 가지고 온 게시글에 첨부파일이 있다면
		if(resultMap.getHasFile().equals("1")) {
			params.put("attachDocType", attachDocType);
			// 첨부파일 검색 조건 中 두번째 조건인 게시글 key를 넣어준다.
			params.put("attachDocKey", resultMap.getNo());
			// 첨부파일 조회
			Attachment attach = fileUtil.getAttachment(params);
			
			// jsp에서 사용하기 위해 addObject
			model.addObject("attach", attach);
		}
		
		// jsp에서 사용하기 위해 addObject
		model.addObject("notice", resultMap);
		model.addObject("currentPageNo", currentPageNo);
		model.addObject("noticeNo", NoticeNo);
		
		// jsp 페이지 지정
		model.setViewName("notice/noticeRead");
		
		return model;

	}

	
	/** 게시판 쓰기 그리드  화면
	 * @param params
	 * @return
	 */
	@RequestMapping(value="/notice/noticeWrite.do")
	public ModelAndView noticeWrite(@RequestParam Map<String, Object> params){

		// 로그찍기
		logger.debug("noticeWrite params : "+params);

		// 뒤로가기 누를때 현재페이지 구하기
		int currentPageNo = Integer.valueOf(params.get("currentPageNo").toString());

		ModelAndView view = new ModelAndView();
		view.addObject("currentPageNo",currentPageNo);

		view.setViewName("notice/noticeWrite");

		return view;

	}

	
	/** 게시판 쓰기 화면
	 * @param params
	 * @param file
	 * @return
	 */
	@RequestMapping(value="/notice/write.do")
	@ResponseBody
	public Map<String, Object> write(@RequestParam Map<String, Object> params, @RequestParam("attachedFile") MultipartFile file){
		logger.debug("write params > "+params);
		logger.debug("write file > "+file);
		System.out.println("file.getOriginalFilename() >> "+file.getOriginalFilename());
		
		int result = 0;
		
		// ajax로 다시 돌려줄  map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 파일 확장자
		String resultfilename = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1);
		logger.debug("filename2 >> "+resultfilename);
		
		if(resultfilename.equals("doc") || resultfilename.equals("txt") || resultfilename.equals("xlsx") || resultfilename.equals("jpg") || 
		   resultfilename.equals("png") || resultfilename.equals("pdf") || resultfilename.equals(null) || resultfilename.equals("")) {
				
				System.out.println("1filename2 >> "+resultfilename);
					
		} else{
				System.out.println("2filename2 >> "+resultfilename);
				
				
				resultMap.put("resultCode", result);
				
				return resultMap;	
		} 
		
		
		
		int currentPageNo = Integer.valueOf(params.get("currentPageNo").toString());
		// 화면에서 넘어온 파라미터 변수로 대입
		// 첨부파일 검색 첫번째 조건은 url에 get 방식으로 넘어온다. 없으면 기본값 notice 저장
		String attachDocType = params.containsKey("attachDocType") ? params.get("attachDocType").toString() : "notice";

		String name = params.get("name").toString();
		String password = params.get("password").toString();
		String title = params.get("title").toString();
		
		String content = params.get("content").toString();
		
		content = content.replace("'", "\\'");		// single quote 바꾸기 ex) 쿼리에서 이미 '' 가 있다 values('A'BLOCK');  values('A'		BLOCK'); 인식 하므로 에러  따라서 ''를 특수문자로 바꿔줘야한다. 
		content = content.replace("\"", "\\\"");	// double quote 바꾸기(.replace)
/*		content = content.replaceAll("\n", "<br>");		// 줄 바꿈 변환	 
		content = content.replaceAll("\r", "<br>");		// 줄 바꿈 변환 
		content = content.replaceAll("\r\n", "<br>");	// 줄 바꿈 변환
*/		
		// 화면에서 넘어온 파라미터, 변수로 DTO대입
		Notice notice = new Notice(); //DTO생성
		notice.setName(name);
		notice.setPassword(password);
		notice.setTitle(title);
		notice.setContent(content);
		                            
		
		notice.setHasFile(!file.isEmpty() ? "1":"0");
		

		result = noticeService.insertNotice(notice);
		System.out.println("result 값 >> "+result);
		System.out.println("no 값 >> "+ notice.getNo());
		
		
		// MultipartFile가 null이 아니고 빈(empty) 파일이 아니라면
		if(file != null && !file.isEmpty()) {
			
			params.put("attachDocType", attachDocType);
			params.put("attachDocKey", notice.getNo());
			// 업로드 유틸 클래스로 보냄
			fileUtil.uploadFile(params, file);
			
			
		}
		//resultMap.put("filename2", filename2);
		// 영향 받은 row 수를 resultMap에 put, ajax 결과값 처리에 쓰임
		resultMap.put("resultCode", result);
		resultMap.put("currentPageNo", currentPageNo);

		return resultMap;		
	}
	
	
	/** 사용자 패스워드 암호화
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/comparePass.do")
	@ResponseBody
	public boolean comparePass(@RequestParam Map<String, Object> params){
		
		//넘어오는 파라미터 로그찍기
		logger.debug("comparePass params : "+params);
		//System.out.println("comment commentNo >> "+params.get("commentNo"));
		//사용자가 입력한 패스워드 받기
		String pass = params.get("pass").toString();
		//System.out.println("params.get pass >> "+params.get("pass").toString());
		//입력받은 패스워드를 바로 암호화 시킨다.
		String makepass = noticeService.makePassword(pass);
		//System.out.println("입력받은패스워드 암호화 한 값 >> "+makepass);
		
		
	
		// 조회할 게시글 번호
		int NoticeNo = Integer.valueOf(params.get("noticeNo").toString());	
		//게시글번호로 게시물불러오기
		Notice notice = noticeService.getNotice(NoticeNo);
		
		//사용자입력패스워드(암호화) 와 사용자가게시글작성시입력했던패스워드(암호화) 되어있는것 비교
		boolean result = notice.getPassword().equals(makepass);
		//System.out.println("result 값 >> "+result);
		return result;
		
	}
	
	
	/** 댓글 사용자 패스워드 암호화
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/CmtcomparePass.do")
	@ResponseBody
	public Comment CmtcomparePass(@RequestParam Map<String, Object> params){
		
		//System.out.println("comment commentNo >> "+params.get("commentNo"));
		//사용자가 입력한 패스워드 받기
		String pass = params.get("pass").toString();
		//System.out.println("params.get pass >> "+params.get("pass").toString());
		//입력받은 패스워드를 바로 암호화 시킨다.
		String makepass = noticeService.makePassword(pass);
		//System.out.println("입력받은패스워드 암호화 한 값 >> "+makepass);
		
		
		
		//댓글 수정/삭제 댓글번호 조회
		int commentNo = Integer.valueOf(params.get("commentNo").toString());
		Comment comment = noticeService.modifyComment(commentNo);
		//System.out.println("comment commentNo >> "+comment.getCommentNo());
		//System.out.println("코멘트 작성자 패스워드값 >> "+comment.getWriterPw());
		boolean result = comment.getWriterPw().equals(makepass);
		
		if(result){
			comment.setCmtYn("Y");
		}else{
			comment.setCmtYn("N");
		}
		
		return comment;
	}
	
	
	/** 게시글 삭제 화면
	 * @param noticeNo
	 * @return
	 */
	@RequestMapping("/notice/noticeDel.do")
	@ResponseBody
	public int noticeDel(@RequestParam int noticeNo){
		//System.out.println("게시글삭제 컨트롤러"+noticeNo);
		
		Notice notice = noticeService.getNotice(noticeNo);
		if(notice.getHasFile().equals("1")){
			
			int attachDocKey = noticeNo;
			String attachDocType = "notice";
			
			Map<String, Object> param = new HashMap<String, Object>();
			
			param.put("attachDocType", attachDocType);
			param.put("attachDocKey", attachDocKey);
			
			fileUtil.deleteAttachment(param);
			
			
		}
		
		//해당게시글에있던 댓글도 삭제한다.
		noticeService.deleteCommentNotice(noticeNo);
		
		int result = noticeService.deleteNotice(noticeNo);
		
		return result;
		
	}
	
	
	/** 게스글 수정 그리드 화면
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/noticeEdit.do")
	public ModelAndView noticeEdit(@RequestParam Map<String, Object> params){
		logger.debug("noticeEdit params : "+params);
		
		//수정페이지 뒤로가기 - 현재페이지번호 가져오기
		int currentPageNo = Integer.valueOf(params.get("currentPageNo").toString());
		//수정할게시글 가져오기 - 수정할게시글번호 가져오기
		int noticeNo = Integer.valueOf(params.get("noticeNo").toString());
		//수정할게시판 type 공지사항으로 지정
		String attachDocType = "notice";
		
		//수정할 게시글 가져오기
		
		Notice notice = noticeService.getNotice(noticeNo);
		String content = notice.getContent();
		content = content.replace("\'", "'");
		content = content.replace("\'", "'");
		content = content.replaceAll("(?i)<br */?>", "\n");		// 줄 바꿈 변환	 
		content = content.replaceAll("(?i)<br */?>", "\r");		// 줄 바꿈 변환 
		content = content.replaceAll("(?i)<br */?>", "\r\n");	// 줄 바꿈 변환
		notice.setContent(content);
		
		// jsp 지정과 jsp 쓸 파라미터를 넣어 줄 수 있는 클래스인 ModelAndView 선언
		ModelAndView model = new ModelAndView();
		model.addObject("currentPageNo", currentPageNo); //현재페이지 jsp에 넘겨주기(뒤로가기)
		model.addObject("notice", notice); //불러온수정할게시글 jsp에 넘겨주기
		
		// 가지고 온 게시글에 첨부파일이 있다면
		if(notice.getHasFile().equals("1")) {
			params.put("attachDocType", attachDocType);
			// 첨부파일 검색 조건 中 두번째 조건인 게시글 key를 넣어준다.
			params.put("attachDocKey", notice.getNo());
			// 첨부파일 조회
			Attachment attach = fileUtil.getAttachment(params);
			
			// jsp에서 사용하기 위해 addObject
			model.addObject("attach", attach);
		}
				
		model.setViewName("notice/noticeEdit");
		return model;
		
		
	}
	
	
	/** 게시글 수정 화면
	 * @param params
	 * @param mRequest
	 * @return
	 */
	@RequestMapping(value="notice/edit.do")
	@ResponseBody
	public Map<String, Object> edit(@RequestParam Map<String, Object> params, MultipartHttpServletRequest mRequest){
		
		logger.debug("edit params : "+params);
		
		// 화면에서 넘어온 파라미터 변수로 대입
		int noticeNo = Integer.valueOf(params.get("noticeNo").toString());
		// 첨부파일 검색 첫번째 조건은 url에 get 방식으로 넘어온다. 없으면 기본값 notice 저장
		String attachDocType = params.containsKey("attachDocType") ? params.get("attachDocType").toString() : "notice";
		
		// file 찾기 
		MultipartFile file = mRequest.getFile("attachedFile");
		
		String name = params.get("name").toString();
		String password = params.get("password").toString();
		String title = params.get("title").toString();
		String content = params.get("content").toString();
		content = content.replace("'", "\\'");		// single quote 바꾸기 ex) 쿼리에서 이미 '' 가 있다 values('A'BLOCK');  values('A'		BLOCK'); 인식 하므로 에러  따라서 ''를 특수문자로 바꿔줘야한다. 
		content = content.replace("\"", "\\\"");	// double quote 바꾸기(.replace)
		content = content.replaceAll("\n", "<br>");		// 줄 바꿈 변환	 
		content = content.replaceAll("\r", "<br>");		// 줄 바꿈 변환 
		content = content.replaceAll("\r\n", "<br>");	// 줄 바꿈 변환
		
		// ajax로 다시 돌려줄  map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 수정할 게시글 가져오기
		Notice notice = noticeService.getNotice(noticeNo);
		
		// 화면에서 넘어온 파라미터는 params로 받았다. params에 수정할 컬럼 값들이 들어 있다.
		// 기존 게시글의 hasFile을 넣어준다.
		 Notice newNotice = new Notice();
         newNotice.setName(name);
         newNotice.setPassword(password);
         newNotice.setTitle(title);
         newNotice.setContent(content);
         newNotice.setHasFile(notice.getHasFile());
		
		// file이 있다면, 즉 jsp에서 input type="file" tag가 있는 상태에서 여기로 왓다면
		if(file != null) {
			// 빈(empty) 파일이 아니라면  1
			 newNotice.setHasFile(!file.isEmpty()? "1":"0");
		}
		
		// 수정할 게시글 번호 넣어주기,
		newNotice.setNo(noticeNo);
		
		// 영향받은 row 수가 return 된다.
		int result = noticeService.modifyNotice(newNotice);
		
		// MultipartFile가 null이 아니고 빈(empty) 파일이 아니라면
		if(file != null && !file.isEmpty()) {
			
			params.put("attachDocType", attachDocType);
			params.put("attachDocKey", notice.getNo());
			
			// 업로드 유틸 클래스로 보냄
			fileUtil.uploadFile(params, file);
		}
		
		// 영향 받은 row 수를 resultMap에 put, ajax 결과값 처리에 쓰임
		resultMap.put("resultCode", result);
		
		return resultMap;
				
	}
	
	/** 첨부파일 삭제 화면
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/deleteAttachFile.do")
	public ModelAndView deleteAttachFile(@RequestParam Map<String, Object> params){
		
		logger.debug("deleteAttachFile params : "+params);
		
		ModelAndView view = new ModelAndView();
		
		// 넘어온파라미터 변수대입
		int noticeNo = Integer.valueOf(params.get("noticeNo").toString());
		int currentPageNo = Integer.valueOf(params.get("currentPageNo").toString());
		
		// 첨부파일 정보
		String attachDocType = params.containsKey("attachDocType") ? params.get("attachDocType").toString() : "notice";
		int attachDocKey = noticeNo;
		
		// 첨부파일 삭제를 위한 파라미터 put
		params.put("attachDocType", attachDocType);
		params.put("attachDocKey", attachDocKey);
				
		// 첨부파일 삭제, 1건만 삭제되어야 하므로 return 1이 와야함. 
		int delResult = fileUtil.deleteAttachment(params);
		
		// 수정할 게시글 가져오기
		Notice noticeMap = noticeService.getNotice(noticeNo);
		
		// 첨부파일삭제후 hasFile 0
		noticeMap.setHasFile("0");
		
		noticeService.modifyNotice(noticeMap);
		
		view.addObject("currentPageNo", currentPageNo);
		view.addObject("notice", noticeMap);
		
		if(delResult == 1) {
			view.addObject("resultMsg", delResult == 1 ? "첨부 파일이 삭제 되었습니다." : "첨부 파일이 삭제되지 않았습니다.");
			view.addObject("resultCode", delResult);
			view.addObject("currentCmd", "view");
		}
		
		view.setViewName("notice/noticeEdit");
		
		return view;
			
	}
	
	/** 댓글 쓰기 화면
	 * @param comment
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/notice/wrComment.do")
	@ResponseBody
	public Map<String, Object> wrComment(@ModelAttribute Comment comment)throws Exception{
		//System.out.println("댓글작성컨트롤러");
		Map<String, Object> retValues = new HashMap<String, Object>();
		
		//System.out.println("사용자 입력받은패스워드값 >> "+comment.getWriterPw());
		//입력받은 패스워드를 바로 암호화 시킨다.
		String writerPw = noticeService.makePassword(comment.getWriterPw());
		//System.out.println("사용자 입력받은패스워드 암호화한값 >> "+writerPw);
		
		comment.setWriterPw(writerPw);
		
		int result = noticeService.setComment(comment);
		//System.out.println("comment.getCommentNo();"+comment.getCommentNo());
		
		if( result > 0){
			retValues.put("retValues", result);
		}else{
			retValues.put("retValues",result);
		}
		
		return retValues;
	}
	
	
	/** 댓글 리스트 화면 불러오기
	 * @param comment
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/notice/lsComment.do")
	@ResponseBody
	public List<Map<String, Object>> lsComment(@ModelAttribute Comment comment) throws Exception{
			logger.debug("deleteAttachFile params : "+comment);
			System.out.println("댓글리스트 불러오기");
			Map<String, Object> retValues = new HashMap<String, Object>();
		
			//해당게시글의 댓글전체 가져오기
			//해당게시글번호 로 댓글 테이블에서 리스트 가져오기
			//즉 해당게시글번호만 필요함.
			List<Map<String, Object>> list = noticeService.getComment(comment.getNoticeNo());
			//System.out.println("list >>>> "+list);
			
			List<Map<String, Object>> htmList = new ArrayList<Map<String, Object>>();
			
			if(list.size() > 0){
				
				for(int i=0; i < list.size(); i++){
					Map<String, Object> cmtList = new HashMap<String, Object>();
					
					//System.out.println("setCommentNo >> "+Integer.valueOf(list.get(i).get("commentNo").toString()));
					cmtList.put("commentNo",list.get(i).get("commentNo"));
					//cmtList.setCommentNo(Integer.valueOf(list.get(i).get("commentNo").toString()));
					//System.out.println("setComment >> "+list.get(i).get("comment"));
					cmtList.put("comment",list.get(i).get("comment"));
					//cmtList.setComment(list.get(i).get("comment").toString());
					//System.out.println("setWriterPw >> "+list.get(i).get("writer"));
					cmtList.put("writer",list.get(i).get("writer"));
					//cmtList.setWriter(list.get(i).get("writer").toString());
					//System.out.println("setWriterPw >> "+list.get(i).get("writerPw"));
					cmtList.put("writerPw",list.get(i).get("writerPw"));
					//cmtList.setWriterPw(list.get(i).get("writerPw").toString());
					//System.out.println("setCreateDate >> "+list.get(i).get("createDate").toString());
					cmtList.put("createDate",list.get(i).get("createDate").toString());
					//cmtList.setCreateDate(list.get(i).get("createDate").toString());
					
					htmList.add(cmtList);
					
				}
				System.out.println("cmtList >> "+ htmList);
				//retValues.put("retValues", "1");
				
			}else{
				System.out.println("if문안탐>>>>>>>>>");
				//retValues.put("retValues", "0");
			}
		return htmList; 
	}
	
	/** 댓글 수정 그리드 화면
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/cmtModify.do")
	public ModelAndView cmtModify(@RequestParam Map<String, Object> params){
		System.out.println("댓글 업데이트 화면"+params.get("commentNo"));
		ModelAndView view = new ModelAndView();
		
		int No = Integer.valueOf(params.get("commentNo").toString());

		Comment comment = noticeService.modifyComment(No);

		view.addObject("list",comment);
		view.setViewName("notice/cmtModify");
		return view;
	}
	
	/** 댓글 수정 화면
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/cmtUpdate.do")
	@ResponseBody 
	public Map<String, Object> cmtUpdate(@RequestParam Map<String, Object> params){
		System.out.println("댓글업데이트 메소드");
		Map<String, Object> retValues = new HashMap<String, Object>();
		
		Comment list = new Comment();
		
		int commentNo = Integer.valueOf(params.get("commentNo").toString());
		String comment = params.get("comment").toString();
		String writer = params.get("writer").toString();

		list.setComment(comment);
		list.setWriter(writer);
		list.setCommentNo(commentNo);

		int result = noticeService.updateComment(list);

		if(result > 0){
			retValues.put("retValues", result);
		}else{
			retValues.put("retValues", result);
		}
		
		return retValues;

	}
	
	/** 댓글 삭제 화면
	 * @param params
	 * @return
	 */
	@RequestMapping("/notice/cmtDelete.do")
	@ResponseBody 
	public Map<String, Object> cmtDelete(@RequestParam Map<String, Object> params){
		System.out.println("댓글삭제 메소드");
		Map<String, Object> retValues = new HashMap<String, Object>();
		
		int commentNo = Integer.valueOf(params.get("commentNo").toString());
		int result = noticeService.deleteComment(commentNo);
		
		if(result > 0){
			retValues.put("retValues", result);
		}else{
			retValues.put("retValues", result);
		}
		
		return retValues;
		
	}
	
	
}
