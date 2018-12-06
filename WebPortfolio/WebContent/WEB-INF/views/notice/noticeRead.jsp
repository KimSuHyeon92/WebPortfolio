<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BBS Write</title>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />

<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />"></script>
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
button{
	padding:0 8px;
}

</style>
<script type="text/javascript">

	// 문서가 초기화 된 상태(준비)라면
	$(document).ready(
		// 아래 함수 실행	
		
		function(){
			
			// <button id="btnDelete"
			$('#btnDelete').click(function(){
				// 사용자에게 패스워드 입력 받고
				var password = inputPassword();
				if(password.length > 0){
					// 비밀번호 비교를 ajax 방식으로 호출하여 비교하여 true 일 경우 페이지 이동
					// 아닐 경우 alert 띄운 후 종료
					$.ajax({
						url: '<c:url value="/notice/comparePass.do" />',
						// 파라미터는 오브젝트 { name : value} 형태로
						data : {
							pass : password, 
							noticeNo : $('#noticeNo').val() 	// id 가 boardNo 인 element의 값(val) 을 가져옴
						},
						success : function (data, textStatus, XMLHttpRequest) {
							// 컨트롤러에서 return 한 값이 true 일 경우
							if(data){
								
								// 한번 더 비동기 방식으로 컨트롤러의 삭제 메서드 호출  
								$.ajax({
									url: '<c:url value="/notice/noticeDel.do" />',
									data : { noticeNo : $('#noticeNo').val() },
									success : function (data, textStatus, XMLHttpRequest) {
										// 컨트롤러에서 return 한 값이 true, 즉 지웠다면 
										if(data){
											alert('삭제 되었습니다.');
											// 삭제 했으니 그리드로 페이지 이동
											window.location.href = '<c:url value="/notice/noticeList.do" />';
											return;
										}
									},
									error : function (XMLHttpRequest, textStatus, errorThrown) {
		// 								console.log(XMLHttpRequest.responseText);
										alert('삭제 에러 \n'+XMLHttpRequest.responseText);
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
				else {
					alert("비밀번호를 입력하세요.");
				}
			}	// 함수 닫기
		);
			getCommentList(); //등록된댓글있으면가져오기	
		}
		
	);
	
	function inputPassword(){
		return window.prompt("글 작성 당시 비밀번호를 입력하세요.");
	}

	function goModify(){
		// 사용자에게 패스워드 입력 받고 변수 password 에 저장
		var password = inputPassword();
		// 사용자에게 입력받은 패스워드의 값이 0보다 크면(즉 패스워드를 입력했으면)
		if(password.length > 0){
			// 비밀번호 비교를 ajax 방식으로 호출하여 비교하여 "true 일 경우 페이지 이동"
			$.ajax({
				// 바로 사용자 가 입력한 비밀번호 암호화하러가기
				url: '<c:url value="/notice/comparePass.do" />',
				// 파라미터는 오브젝트 { name : value} 형태로
				data : {
					pass : password, 
					noticeNo : $('#noticeNo').val() 	// id 가 boardNo 인 element의 값(val) 을 가져옴
				},
				//컨트롤러에서 보낸 result값이 true인경우
				success : function (data, textStatus, XMLHttpRequest) {
					if(data){
						
						var frm = document.bbsForm;
						// 사용자에게 받은 값을 [password]에 넣어주기
						frm.password.value = password;
						frm.action = '<c:url value="/notice/noticeEdit.do" />';
						
						// 파라미터는 bbsForm의 element들의 name이 key가 되어 post로 전송된다.
						// ex) name="board" value="blabla"
						// -> {board : blabla}
						frm.submit();
					}
					else {
						alert('글 작성 당시 비밀번호와 다릅니다!');
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
		// 아닐 경우 alert 띄운 후 종료
		else {
			alert("비밀번호를 입력하세요.");
		}
	}
	
	function goListPage() {
		var frm = document.bbsForm;
		window.location.href = '/WebPortfolio/notice/noticeList.do?currentPageNo='+frm.currentPageNo.value;
	}
	
	function goComment(){ //댓글등록
		
		if( $('#comment').val() == null || $('#comment').val() == "" ){
			alert("댓글을 입력해주세요.");
			return;
		}
		
		if( $('#writer').val() == null || $('#writer').val() == "" ){
			alert("아이디를 입력해주세요.");
			return;
		}
		
		if( $('#writerPw').val() == null || $('#writerPw').val() == "" ){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		var data = { 
				"comment" : $('#comment').val(),
				
				"writer" : $('#writer').val(),
				
				"writerPw" : $('#writerPw').val(),
				
				"noticeNo" : $('#noticeNo').val()
		}
		
		//postAjax("<c:url value='/notice/wrComment.do' />", data, afComment);
		$.ajax({
	        url : "<c:url value='/notice/wrComment.do' />",
	        data:data,
	        success : function(data){
	        	if( data.retValues > 0 ){
	        		alert("댓글이 등록 되었습니다.");
	        		var wrCmtYn="Y";
	    			getCommentList(); //댓글불러오기
	                $("#comment").val("");
	                $("#writer").val("");
	                $("#writerPw").val("");
	    		}else{
	    			alert("댓글 등록이 실패했습니다. 다시 시도해주세요.");
	    			return;
	    		}
	        },
	        error:function(request,status,error){
	            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       }
		});
		
	}
	
	
	function getCommentList(){
		//alert("댓글리스트");
		var data = { 
				
				"noticeNo" : $('#noticeNo').val()
		}
		
		//postAjax("<c:url value='/notice/lsComment.do' />", data, afCommentList);
		$.ajax({
	        url : "<c:url value='/notice/lsComment.do' />",
	        data:data,
	        success : function(data){
	        	
	        	//alert("댓글등록완료");
	        	
	        	/* $.each(data, function(idx, val) {
	        		console.log(idx + " " + val.createDate);
	        	}); */
	        	
	        	var html = "";
	            var cCnt = "["+data.length+"]";
	        	
	            
	        	if(data.length > 0){
	                
	                for(i=0; i<data.length; i++){
	                	html += "<div style='margin-bottom:20px;clear:both;padding: 5px 15px;background: #f5f5f5;'>"
	                	html += "<p style='border-bottom:1px solid #ddd;padding-bottom:5px;margin-bottom:5px;font-weight:bold;'>"+data[i].writer+"<span style='float:right;font-weight:normal;'>"+data[i].createDate+"</span></p>";
	                    html += "<p>"+data[i].comment+"</p>";
	                    html += "<p style='height:35px;'><button type='button' class='btn btn-default' onclick='cmCancle("+data[i].commentNo+")' style='float:right;'>삭제하기</button><button type='button' class='btn btn-default' onclick='cmModify("+data[i].commentNo+")' style='float:right;margin-right:5px;'>수정하기</button></p>";
	                    html += "</div>";
	                }
	                
	                
	            } else {
	                
	            	html += "<div style='margin-bottom:20px;'>"
	                	
	                    html += "<p>등록된 댓글이 없습니다.</p>";
	                    html += "</div>";
	                
	            }
	        	$("#CmTotal").html(cCnt);
                $("#CmMain").html(html);

	        },
	        error:function(request,status,error){
	            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       }
		}); 
	
		
	}
	
	function cmCancle(commentNo){
		// 사용자에게 패스워드 입력 받고 변수 password 에 저장
		var password = inputPassword();
		if(password.length > 0){
			// 비밀번호 비교를 ajax 방식으로 호출하여 비교하여 "true 일 경우 페이지 이동"
			$.ajax({
				// 바로 사용자 가 입력한 비밀번호 암호화하러가기
				url: '<c:url value="/notice/CmtcomparePass.do" />',
				// 파라미터는 오브젝트 { name : value} 형태로
				data : {
					pass : password, 
					commentNo : commentNo
					// id 가 boardNo 인 element의 값(val) 을 가져옴
				},
				//컨트롤러에서 보낸 result값이 true인경우
				success : function (data, textStatus, XMLHttpRequest) {
					if(data.cmtYn == "Y"){
						var commentNo = data.commentNo;
						//alert("비밀번호맞을경우 삭제창이 뜬다");
						
						//삭제 함수 실행	
						deleteComment(commentNo);
						
					}
					else if((data.cmtYn == "N")) {
						alert('댓글 작성 당시 비밀번호와 다릅니다!');
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
		// 아닐 경우 alert 띄운 후 종료
		else {
			alert("비밀번호를 입력하세요.");
		}
	}
	
	function deleteComment(commentNo){
		//alert(commentNo);
		$.ajax({
			// 바로 사용자 가 입력한 비밀번호 암호화하러가기
			url: '<c:url value="/notice/cmtDelete.do" />',
			// 파라미터는 오브젝트 { name : value} 형태로
			data : {
				commentNo : commentNo,
				noticeNo : $('#noticeNo').val()
				// id 가 boardNo 인 element의 값(val) 을 가져옴
			},
			//컨트롤러에서 보낸 result값이 true인경우
			success : function (data, textStatus, XMLHttpRequest) {
				if(data.retValues > 0){
					
					alert("삭제가 완료되었습니다.");
					location.reload();
					
				}
				else if(data.retValues > 0) {
					alert('삭제실패');
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
	
	
	function cmModify(commentNo){
		//alert("수정하기버튼클릭")
		// 사용자에게 패스워드 입력 받고 변수 password 에 저장
		var password = inputPassword();
		// 사용자에게 입력받은 패스워드의 값이 0보다 크면(즉 패스워드를 입력했으면)
		if(password.length > 0){
			// 비밀번호 비교를 ajax 방식으로 호출하여 비교하여 "true 일 경우 페이지 이동"
			$.ajax({
				// 바로 사용자 가 입력한 비밀번호 암호화하러가기
				url: '<c:url value="/notice/CmtcomparePass.do" />',
				// 파라미터는 오브젝트 { name : value} 형태로
				data : {
					pass : password, 
					commentNo : commentNo
					// id 가 boardNo 인 element의 값(val) 을 가져옴
				},
				//컨트롤러에서 보낸 result값이 true인경우
				success : function (data, textStatus, XMLHttpRequest) {
					if(data.cmtYn == "Y"){
						var commentNo = data.commentNo;
						//alert("비밀번호맞을경우 수정창이 뜬다");
						CmtModifyPopup(commentNo);
						
						/* var frm = document.bbsForm;
						// 사용자에게 받은 값을 [password]에 넣어주기
						frm.commentNo.value = commentNo;
						frm.action = '<c:url value="/notice/cmtModify.do" />';
						
						// 파라미터는 bbsForm의 element들의 name이 key가 되어 post로 전송된다.
						// ex) name="board" value="blabla"
						// -> {board : blabla}
						frm.submit(); */
						
					}
					else if((data.cmtYn == "N")) {
						alert('댓글 작성 당시 비밀번호와 다릅니다!');
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
		// 아닐 경우 alert 띄운 후 종료
		else {
			alert("비밀번호를 입력하세요.");
		}
	}
	
	function CmtModifyPopup(commentNo){
		//alert("수정창이 뜬다");
		var popUrl = '/WebPortfolio/notice/cmtModify.do?commentNo='+commentNo;	//팝업창에 출력될 페이지 URL

		var popOption = "width=400, height=420, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)

			window.open(popUrl,"",popOption);

	}

</script>
</head>
<body>
	<form name="bbsForm" method="post">
		<input type="hidden" id="currentPageNo" name="currentPageNo" value="${currentPageNo}">		<%-- 현재 페이지 번호 --%>
		<input type="hidden" id="noticeNo" name="noticeNo" value="${notice.no}">	<%-- 글번호 --%>
		<input type="hidden" id="password" name="password" value="">
		<input type="hidden" id="commentNo" name="commentNo" value="">
		
		<div align="center">
			<table>
			
				<thead>
					<tr>
						<th colspan="2"> 공지사항 <c:out value="${notice.no}"/> 번 글</th>
				    </tr>
				    <tr>
						<th colspan="2"></th>
					</tr>
				</thead>
		        <tr>
		        	<td class="name">글쓴이</td>
		        	<td><c:out value="${notice.name}"/></td>
		        </tr>
		        <tr>
		        	<td class="name">작성시간: </td>
		        	<td><c:out value="${notice.createDate}"/></td>
		        </tr>
		        <tr>
		        	<td class="name">수정된시간: </td>
		        	<td><c:out value="${notice.updateDate}"/></td>
		        </tr>
		        <tr>
		        	<td class="name">제목</td>
		        	<td><c:out value="${notice.title}"/></td>
		        </tr>
		        <tr>
		        	<td colspan="2" class="content">
		        		${notice.content}
		        	</td>
		        </tr>
		        <tr>
					<td class="name">첨부파일</td>
					<td>
						<c:choose>
							<c:when test="${attach eq null}">
								- 첨부파일이 없습니다.
							</c:when>
							<c:otherwise>
								<a href='<c:url value="/file/getFile.do?attachDocType=notice&attachDocKey=${notice.no}" />' >
									<c:out value="${attach.filename}"/>
								</a>
								&nbsp;
								(<c:out value="${attach.fileSize}"/> bytes)
							</c:otherwise>							
						</c:choose>
					</td>
		        </tr>
		        <tr>
		        	<td colspan="2" align="center" class="button_wrap" style="padding: 20px 10px 40px;">
			          	<button type="button" onclick="goModify()">수정하기</button>
			          	&nbsp;
			          	<button type=button id="btnDelete" >삭제하기</button>
			          	&nbsp;
						<button type=button onclick="goListPage()">뒤로가기</button>
					</td>
		        </tr>
			</table>
			<!--{ 댓글 -->
	      	<table class="comment-Wrap">
	      		<!-- comment -->
				 <tr>
		        	<td colspan="2"  class="text-left title">
			          	Comment <span id="CmTotal"></span>
					</td>
				</tr>
				<tr >
					<td colspan="2"  class="wrap" >
						<div class="login">
							<span class="title">ID</span><input type="text" id="writer"><br>
							<span class="title">PW</span><input type="password" id="writerPw">
						</div>
			          	<textarea id="comment" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>
			          	<button type="button" onclick="goComment()"  class="btn btn-default">등록</button>
					</td>
				</tr>
		        <tr >
					<td id="CmMain" colspan="2" >
		        	</td>
		        </tr>
	      	</table>
	      	
    	</div>
  	</form>
  	
</body>
</html>