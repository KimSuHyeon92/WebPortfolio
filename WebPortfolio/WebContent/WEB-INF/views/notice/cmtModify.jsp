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
<script type="text/javascript">
function modifyComment(){
	//alert("댓글수정 확인창");
	
	//아작스로 컨트롤러에서 댓글수정업데이트후 완료시 댓글수정팝업창이 닫히고 댓글부분 리스트 다시불러오기;
	$.ajax({
		// 바로 사용자 가 입력한 비밀번호 암호화하러가기
		
		url: '<c:url value="/notice/cmtUpdate.do" />',
		// 파라미터는 오브젝트 { name : value} 형태로
		data : {
			commentNo : $("#commentNo").val(),
			writer : $("#writer").val(),
			comment : $("#comment").val()
		},
		//컨트롤러에서 보낸 result값이 true인경우
		success : function (data, textStatus, XMLHttpRequest) {
			//alert("여기타야됨");
			if(data.retValues>0){
				//alert("댓글이 수정되었습니다.");
				//var noticeNo = $("#noticeNo").val();
				//alert(noticeNo);
				//alert(${list.noticeNo });
				//수정창 닫히고 댓글부분 reload
				window.opener.location.reload();    //부모창 reload
				//getCommentList(); //등록된댓글있으면가져오기
				window.close();    //현재 팝업창 Close
				 
			}else{
				alert("댓글 수정 실패");
				return;
			}
		},
		//컨트롤러에서 보낸 result값이 false인경우
		error : function (XMLHttpRequest, textStatus, errorThrown) {
			console.log(XMLHttpRequest.responseText);
			alert(XMLHttpRequest.responseText);
		}
	});
	

}

</script>
<style>
#modify header {
	background:#F0F3F7;
}
#modify .header_title{
    line-height: 50px;
    font-weight: normal;
    font-size: 20px;
    padding-left: 28px;
}    
#modify fieldset {
border: 0;
    text-align: center;
    padding: 30px 28px;
    font-size: 14px;
    
    margin: 0 auto;
}
#writer {
	float:left;
	margin-bottom:10px;
	padding:5px;
}
#comment {
	float:left;
	margin-bottom:20px;
	padding:5px;
	width: 100%;
}
.wrap_btn {
	clear:both;
	text-align: right;
}
</style>
</head>
<body>
	<body id="modify">

	<header>
		<p class="header_title" >댓글 수정</p>
	</header>
	<form name="bbsForm" method="post" >
		<fieldset>
			<input type="hidden" id="commentNo" name="commentNo" value="${list.commentNo }">
			<input type="hidden" id="noticeNo" name="noticeNo" value="${list.noticeNo }">
	
			<div class="wrap_guest modify_guest">
				<input type="text" id="writer" placeholder="아이디" value="${list.writer }">
			</div>
			<div class="wrap_content">
				<textarea id="comment" name="comment" cols="45" rows="9" placeholder="인터넷은 우리가 함께 만들어가는 소중한 공간입니다. 댓글 작성 시 타인에 대한 배려와 책임을 담아주세요.">${list.comment }</textarea>
			</div>
			<div class="wrap_btn">
				<button type="button" class="btn btn_reset" onClick="window.close()">취소</button>
				<button type="button" class="btn btn_submit" onclick="modifyComment()">확인</button>
			</div>
			
		</fieldset>
	</form>
</body>
</body>
</html>