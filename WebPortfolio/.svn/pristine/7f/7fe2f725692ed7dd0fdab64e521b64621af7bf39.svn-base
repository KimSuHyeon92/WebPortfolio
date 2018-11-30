<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/default.css" />" />

<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />"></script>
<script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script>
<style type="text/css">
td.name {
	width : 200px;
}

table tr:last-child td {
	padding-bottom: 10px;
	padding-top : 10px;

}

td.content {
	white-space: pre-line;
	padding:0 20px;
}

textarea {
	overflow :visible;
	width : 100%;
	height : 200px;
}

input {
	width: 100%;
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
<script type="text/javascript">

//컨트롤러에서 보낸 메세지가 있을 경우
window.onload = function(e){ 
	// addObject 한 것 꺼내기
	var resultMsg = '${resultMsg}';
	var resultCode = '${resultCode}';
	var currentCmd = '${currentCmd}';
	
	if(resultMsg.length > 0){
		alert(resultMsg);
	}
	
	// 첨부파일 삭제 할 경우 currentCmd = view 
	if(resultCode == 1 && currentCmd == ''){
		window.location.href = '/notice/read.do?noticeNo=${notice.no}&currentPageNo=${currentPageNo}';
	}
}

function goListPage() {
	var frm = document.bbsForm;
	window.location.href = '/WebPortfolio/notice/noticeList.do?currentPageNo='+frm.currentPageNo.value;
}

function doModify(){
	var frm = document.bbsForm;
	
	// 유효성 검사 필수!
	var name = frm.name.value;
	
	if(name.length == 0){ 	// 입력 했는지
		alert("이름을 입력하세요.");
		return;
	}
	else if(name.length > 45){	// 컬럼 데이터 타입에 맞는지
		alert('45자 이내로 입력하세요.')
		return;
	}
	
//		<input type="password" id="password"
	var password = $('#password').val();
	if(password.length == 0){
		alert("비밀번호를 입력하세요.");
		return;
	}
	else if(!/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/.test(password)){
		alert('영문숫자 포함 8~16자리로 입력해주세요');
		return;
	}
	
//		<input type="text" name="title"
	var title = $('input[name="title"]').val();
	if(title.length == 0){
		alert("제목을 입력하세요.");
		return;
	}
	else if(title.length > 200){
		alert('200자 이내로 입력하세요.')
		return;
	}
	
	//content 로 선언된 변수에 from에있는 name="content" 의 value값을 넣어준다 
	
	//다시 content 로 선언된 변수에 ck에디터에서 얻어온 데이터를 넣어준다
	var content = frm.content.value;
	content = CKEDITOR.instances.content.getData();
	
	//content 를 유효성검사해준다
	if(content.length == 0){
		alert("본문을 입력하세요.");
		return;
	}
	else if(content.length > 4000){
		alert('4000자 이내로 입력하세요.')
		return;
	}
	
	// ck에디터에서 가져온 데이터값을 content 에 저장해 유효성검사를 해주었는데 넘어가는 값은 form에있는 content값이 여야 하므로 다시 content의값을 바꿔준다.
	frm.content.value = content;
		
	// ajax 통신으로 비밀번호 먼저 비교, 컨트롤러 return 값이 true 일 경우 
	// bbsForm에 action 지정하여 submit 한다(), 아닐 경우 alert 띄운 후 종료
	$.ajax({
		url: '<c:url value="/notice/comparePass.do" />',
		// 파라미터는 오브젝트 { name : value} 형태로
		data : {
			pass : password, 
			// id 가 boardNo 인 element의 값(val) 을 가져옴
			noticeNo : $('#noticeNo').val() 	
		},
		success : function (data, textStatus, XMLHttpRequest) {
			// 컨트롤러에서 return 된 값이 true 일 경우 
			if(data){
				// bbsForm을 찾아서 frm 변수에 대입
				var frm = document.bbsForm;	// $("form[name='bbsForm']")[0]
			    
				// 사용자에게 받은 값을 [password]에 넣어주기
				$('#password').val(password);	
//					frm.password.value = password; (기존코드)
				
				// 게시판 구분
				$('input[name=attachDocType]').val('notice');
				// 게시글 pk
				$('input[name=attachDocKey]').val( $('#noticeNo').val() );
				
				var formData = new FormData(frm);
				var ajaxReq = $.ajax({
					url : '<c:url value="/notice/edit.do" />',
					data : formData,
				    type: 'POST',
				    dataType: 'text',
				    processData: false,
				    contentType: false,
					success : function (result, textStatus, XMLHttpRequest) {
						var data = $.parseJSON(result);
						// 컨트롤러에서 return 한 값 중 resultCode 가 1이면, 즉 수정했다면 
						if(data.resultCode){
							alert('수정 되었습니다.');
							// 수정했으니 읽기 페이지로
							window.location.href = "/WebPortfolio/notice/read.do?noticeNo="+$('#noticeNo').val()+"&currentPageNo="+$('#currentPageNo').val();
						}
					},
					error : function (XMLHttpRequest, textStatus, errorThrown) {
						alert('수정 에러 \n'+XMLHttpRequest.responseText);
					}
				});
			}
			else {
				alert('글 작성 당시 비밀번호와 다릅니다!');
				return;
			}
		},
		error : function (XMLHttpRequest, textStatus, errorThrown) {
			console.log(XMLHttpRequest.responseText);
			alert(XMLHttpRequest.responseText);
		}
	});
	
}
//첨부파일 삭제
function deleteAttachFile(){
	var frm = document.bbsForm;
	
	if(confirm("첨부파일을 삭제 하시겠습니까?")){
		frm.action = '<c:url value="/notice/deleteAttachFile.do" />';
		frm.submit();
	}
}

//바이트수 제한
//글자 byte 수 제한
$(document).ready( function() {
    //글자 byte 수 제한
    $('.byteLimit').blur(function(){
                     
        var thisObject = $(this);
         
        var limit = thisObject.attr("limitbyte"); //제한byte를 가져온다.
        var str = thisObject.val();
        var strLength = 0;
        var strTitle = "";
        var strPiece = "";
        var check = false;
                 
        for (i = 0; i < str.length; i++){
            var code = str.charCodeAt(i);
            var ch = str.substr(i,1).toUpperCase();
            //체크 하는 문자를 저장
            strPiece = str.substr(i,1)
             
            code = parseInt(code);
             
            if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))){
                strLength = strLength + 3; //UTF-8 3byte 로 계산
            }else{
                strLength = strLength + 1;
            }
             
            if(strLength>limit){ //제한 길이 확인
                check = true;
                break;
            }else{
                strTitle = strTitle+strPiece; //제한길이 보다 작으면 자른 문자를 붙여준다.
            }
             
        }
         
        if(check){
            alert(limit+"byte 초과된 문자는 잘려서 입력 됩니다.");
        }
         
        thisObject.val(strTitle);
         
    });
});
</script>
</head>
<body>
<form id="bbsForm" name="bbsForm" method="post" enctype="multipart/form-data">
      <input type="hidden" id="currentPageNo" name="currentPageNo" value="${currentPageNo}">
      <input type="hidden" id="noticeNo" name="noticeNo" value="${notice.no}">
      <input type="hidden" id="attachDocType" name="attachDocType" value="notice">
      <input type="hidden" id="attachDocKey" name="attachDocKey" value="">
      
      <div align="center">
      <table>
			<thead>
				<tr>
			      <th colspan="2"> 공지사항 수정</th>
			    </tr>
			    <tr>
					<th colspan="2"></th>
				</tr>
			</thead>
        <tr>
          <td class="name">글쓴이</td>
          <td><input type="text" id="name" class="byteLimit" limitbyte="45" name="name" value="<c:out value='${notice.name}'/>" /></td>
        </tr>
        <tr>
          <td class="name">비밀번호: </td>
          <td><input type="password" id="password" name="password" maxlength="45"/></td>
        </tr>
        <tr>
          <td class="name">제목</td>
          <td><input type="text" id="title" class="byteLimit" limitbyte="200"  name="title" value="<c:out value='${notice.title}'/>"></td>
        </tr>
        <tr>
          <td colspan="2"  class="content">
            <textarea id="content" name="content"><c:out value='${notice.content}'/></textarea>
            <script>
				CKEDITOR.replace( 'content' );
			</script>
          </td>
        </tr>
        <tr>
			 <td class="name">첨부파일</td>
			 <td>
				<c:choose>
					<c:when test="${attach eq null}">
						<input type="file" id="attachedFile" name="attachedFile" />
					</c:when>
					<c:otherwise>
						<input type="hidden" name="attachedFile" value="${attach.filename}" >
						<a href="/WebPortfolio/file/getFile.do?attachDocType=notice&attachDocKey=${notice.no}" >
							<c:out value="${attach.filename}"/>
						</a>
						&nbsp;
						<c:out value="${attach.fileSize}"/>
						&nbsp;
						<button type="button" id="btnDelAttach" onclick="deleteAttachFile()">삭제</button>
					</c:otherwise>
				</c:choose>
			</td>
        </tr>
		<tr>
          <td colspan="2" align="center">
          	<button type=button onclick="doModify()">저장하기</button>
          	&nbsp;
          	<button type=button onclick="goListPage()">뒤로가기</button>
          </td>
        </tr>
      </table>
    </div>
  </form>
</body>
</html>