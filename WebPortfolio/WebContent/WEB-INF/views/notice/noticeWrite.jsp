<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/default.css" />" />

<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />"></script>
<script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script>

<style type="text/css">
textarea {
	overflow :visible;
	width : 100%;
	height : 200px;
}

input {
	width:100%;
	padding: 0px 10px;
}

table tr:last-child td {
	padding-bottom : 10px;
	padding-top : 10px;

}
table .content { padding: 20px 10px; }
button{
	padding:0 8px;
}
</style>
<title>BBS Write</title>
<script type="text/javascript">

	// 컨트롤러에서 보낸 메세지가 있을 경우(첨부파일삭제후)
	window.onload = function(e){ 
		// addObject 한 것 꺼내기
		var resultMsg = '${resultMsg}';
		var resultCode = '${resultCode}';
		if(resultMsg.length > 0){
			alert(resultMsg);
		}
		if(resultCode != 0){
			window.location.href = '/WebPortfolio/notice/noticeList.do?currentPageNo=1';
		}
	}

	function goBack() {
		var frm = document.bbsForm;
		window.location.href = '/WebPortfolio/notice/noticeList.do?currentPageNo='+frm.currentPageNo.value;
	}
	
	

	function doWrite(){
		// bbsForm을 찾아서 frm 변수에 대입
		var frm = document.bbsForm;	// $("form[name='bbsForm']")[0]

		// 유효성 검사 필수!
		var name = frm.name.value;
		if(name.length == 0){ 	// 입력 했는지
			alert("이름을 입력하세요.");
			return;
		}
		else if(name.length > 45){	// 컬럼 데이터 타입에 맞는지
			alert('45자 이내로 입력하세요.');
			return;
		}
		
		var password = frm.password.value;
		
		if(password.length == 0){
			alert("비밀번호를 입력하세요.");
			return;
		}
		else if(!/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/.test(password)){
			alert('비밀번호를 영문숫자 포함 8~16자리로 입력해주세요');
			password = null;
			return;
		}
		
		
		var title = frm.title.value;
		if(title.length == 0){
			alert("제목을 입력하세요.");
			return;
		}
		else if(title.length > 200){
			alert('200자 이내로 입력하세요.')
			return;
		}
		
		
		var content = CKEDITOR.instances.content.getData();
		
		if(content.length == 0){
			alert("본문을 입력하세요.");
			return;
		}
		else if(content.length > 8000){
			alert('8000자 이내로 입력하세요.')
			return;
		}
		
		frm.content.value = content;
		
		
		
		
		
		/* console.log("indexOf >> "+filename.indexOf("."));
		console.log("indexOf >> "+filename.substring(filename.lastIndexOf(".")));
		console.log("indexOf >> "+filename.lastIndexOf("."));
		console.log("filename2 >> "+filename2); */
		
		
		var attresult= attachtype();
		
		if(attresult){
			return;
		}
		
		// 게시판 구분
		$('input[name=attachDocType]').val('notice');
		
		
		//var frm = document.bbsForm;
		var formData = new FormData(frm);
		var ajaxReq = $.ajax({
			url : '<c:url value="/notice/write.do" />',
			data : formData,
		    type: 'POST',
		    dataType: 'text',
		    processData: false,
		    contentType: false,
			success : function (result, textStatus, XMLHttpRequest) {
				
				var data = $.parseJSON(result);
				// 컨트롤러에서 return 한 값 중 resultCode 가 1이면, 즉 작성했다면 
				if(data.resultCode > 0){
					alert('작성 되었습니다.');
					// 작성했으니 그리드 처음(1 page)로 이동 
					window.location.href = "/WebPortfolio/notice/noticeList.do?currentPageNo=1";
				}
				else {
					alert("["+filename2+"] 확장자 파일은 첨부할 수 없습니다. \n첨부 가능한 파일 : doc, txt, xlsx, jpg, png, pdf");
					document.bbsForm.attachedFile.value = null;
				}
			},
			error : function (XMLHttpRequest, textStatus, errorThrown) {
				alert('작성 에러 \n'+XMLHttpRequest.responseText);
			}
		});
		
	}
	
	function attachtype(){
		var frm = document.bbsForm;
		var filename = frm.attachedFile.value;
		/* console.log("filename >> "+filename); */
		// 확장자명 구하기
		/*  
		indexOf : 기본적으로 문자열에서 문자의 위치를 찾기 위해서 , 전체 문자열의 왼쪽에서부터 특정 문자열이 존재하는 위치를 찾고 싶은 것
		lastIndexOf : 기본적으로 문자열에서 문자의 마지막에 등장하는 위치를 찾고 싶을때  , 전체 문자열의 오른쪽에서부터 특정 문자열이 존재하는 위치를 찾고 싶은 것
		
		첨부파일이름.substring(첨부파일이름.lastIndexOf(첨부파일이름.indexOf(".")))
		
		- lastIndexOf 사용이유?
		첨부파일이름에서 중간에 .이 들어갈수 있기 때문에 ex) t.est.txt  오른쪽에서부터 . 을찾아 잘라준다.
		
		- (  첨부파일이름.lastIndexOf(".")  )  하면 오른쪽에서부터 . 을 찾고 인덱스번호값을 찾은다음   ex) test.txt  ->  .txt
		. 을 없애기 위해서는 +1 해주면 . 도 사라지며 
		*/
		
		var filename2 = filename.substring(filename.lastIndexOf(".")+1);
		
		if(filename2.match)
		if(filename2 == "docx" || filename2 == "doc" || filename2 == "txt" || filename2 == "xlsx" || filename2 == "jpg" || filename2 == "png" || filename2 == "pdf" || filename2 == null || filename2 == ''){
        }else{
           alert("["+filename2+"] 확장자 파일은 첨부할 수 없습니다. \n첨부 가능한 파일 : doc, txt, xlsx, jpg, png, pdf");
           document.bbsForm.attachedFile.value = null;
           return true;
        }
	}
	
	
	
</script>
</head>
<body>
  <form name="bbsForm" method="post" enctype="multipart/form-data">
      <input type="hidden" id="currentPageNo" name="currentPageNo" value="${currentPageNo}">
      <input type="hidden" name="attachDocType" value="notice">
      <input type="hidden" name="attachDocKey" value="">
       
      <div align="center">
		<table>
      		<thead>
				<tr>
			      <th colspan="2"> 공지사항 작성</th>
			    </tr>
			    <tr>
					<th colspan="2"></th>
				</tr>
			</thead>
        <tr>
          <td>글쓴이</td>
          <td><input type="text" name="name"/></td>
        </tr>
        <tr>
          <td>비밀번호</td>
          <td><input type="password" name="password"  /></td>
        </tr>
        <tr>
          <td>제목</td>
          <td><input type="text" name="title"/></td>
        </tr>
        <tr>
          <td colspan="2" class="content" >
            <textarea name="content"></textarea>
			<script>
				CKEDITOR.replace( 'content' );
			</script>
          </td>
        </tr>
        <tr>
          <td>첨부파일</td>
          <td><input type="file" name="attachedFile"/></td>
          
        </tr>
        <tr>
          <td colspan="2" align="center">
          	<button type=button onclick="doWrite()">작성하기</button>
          	&nbsp;
          	<button type=button onclick="goBack()">뒤로가기</button>
          </td>
        </tr>
      </table>
    </div>
  </form>
</body>
</html>