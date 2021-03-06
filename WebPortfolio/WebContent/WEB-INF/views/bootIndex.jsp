<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>:: 김수현 포트폴리오 ::</title>

    
    <script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/proper/js/proper.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />" /></script>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />

    <script type="text/javascript">
    $(document).ready(function(){
        	// 왼쪽메뉴그룹 
            $("#accordion").collapse();
            
            // 초기 페이지 세팅
            $("#demoFrame").attr("src", '<c:url value="/home.do" />');
			$(".sub-title").html('Intro Page');
            
			$(".list-group-item").on("click", function(){
				$(".sub-title").html( $(this).text() );
			});
			
			
			// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
		    var key = getCookie("key");
		    $("#LoginEmail").val(key); 
		     
		    if($("#LoginEmail").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
		        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
		    }
		     
		    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
		            setCookie("key", $("#LoginEmail").val(), 7); // 7일 동안 쿠키 보관
		        }else{ // ID 저장하기 체크 해제 시,
		            deleteCookie("key");
		        }
		    });
		     
		    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
		    $("#LoginEmail").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
		            setCookie("key", $("#LoginEmail").val(), 7); // 7일 동안 쿠키 보관
		        }
		    });	
        });
	    
        
        //이메일중복체크 
        function mailCheck(){
        	
        	var UserId = $("#userEmail").val();
        	var textCk = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

        	if( UserId == null || UserId == '' ){
        		alert("이메일을 입력해주세요!");
        		return;
        	}else if( textCk.test(UserId) == false ){
        		alert("이메일 형식이 올바르지 않습니다.");
        		return;
        	}
        	
        	var data = {
    				"userEmail" : UserId
    		}

        	
			$.ajax({
        		
        		url: '<c:url value="/member/mailCheck.do" />',
        		data : data ,
        		success : function (data, textStatus, XMLHttpRequest) {
        		
        		if(data == 1){
       	       		 alert("등록 가능한 회원입니다");
       	       		 $("#mail-check").text("수정");
       	       		 $('#userEmail').attr("readOnly",true);
       	       		 $('#userEmail').attr("disabled",true);
       	       		 $("#mailOverOk").val("Y"); //메일중복확인
       	       		 var html ='<button type="button" onclick="mailReset()" class="btn btn-primary col-xs-4" id="mail-check">'+'수정'+'</button>';
       	       			$(".mailWrap").html(html);

       	       	 }else if ( data == -1){
       	       		 alert("이미 가입한 회원입니다");
       	       		 $("#userMail").val("");
       	       		 return;
       	       	 }else{
       	       		 
       	       		alert("잠시후에 시도해 주시기 바랍니다.\n접속량이 많아 원할하지 않을수 있습니다.\n지속적으로 발생시 브라우저를 모두종료후 재접속해 보시기바랍니다.");
       	       		 $("#userMail").val("");
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
        
        function mailReset(){ //이메일재설정 
        	
        	$('#userEmail').attr("readOnly",false); 
        	$('#userEmail').removeAttr('disabled'); 
        	
        	$("#mailOverOk").val("N"); //메일중복확인
        	$("#mailEndOk").val("NO"); //메일인증완료 
        	$("#mailSendOk").val("NO"); //메일보내기여부
        	$("#checkEmail").val(""); //메일인증번호 디폴트
        	
        	$('#certMsg').css('display','none');
        	$('#certCode').removeAttr('disabled'); //메일인증번호
			$('#certCode').val();
			
        	var html ='<button type="button" onclick="mailCheck()" class="btn btn-primary col-xs-4" id="mail-check">'+'중복확인'+'</button>';
        	$(".mailWrap").html(html);
        	$("#userEmail").val("");
        	
        }
        
      	//인증메일 발송
        function mailOk(){ 
        	
        	if( $("#mailEndOk").val() == "OK" ){ //인증을 완료했다면 인증메일발송 x
				alert('이미 인증을 완료하셨습니다.\n회원가입을 진행해주세요.');
				return;
			}else{
				$('#certCode').removeAttr('disabled');
				$('#certCode').val('');
			}
        	
        	if($("#userEmail").val() == null || $("#userEmail") == ''){
        		alert('이메일 을 입력해주세요');
        		return;
        	}
        	
        	if( $("#mailOverOk").val() != "Y" ){
        		alert('이메일 중복확인을 진행해주세요.');
        		return;
        	}
        	     	
            //작성한 이메일 가져오기
       		var receiver = $("#userEmail").val();
       		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
       		
       		if(exptext.test(receiver) == true){ //회원이메일 형식체크
       			
       			var data = {
       			     'receiver' : receiver,
       			     'mailOverOk' : $("#mailOverOk").val()
       			}
       			
       			postAjax("<c:url value='/mail/addEmail.do' />", data, AddmailAfter);
       			
       		}else{
       			
       			alert("올바른 메일 형식으로 작성해주세요");
       			return;
       		}
           	

       }
      	
       //메일보내기 완료후
       function AddmailAfter(data){
    	   
    	   if( data.resultCode > 0 ){
				alert("메일보내기성공");
				$("#mailSendOk").val("OK");
				$("#checkEmail").val(data.authNum);
				$('#certMsg').css('display','block');
				return;
			}else {
				alert("메일을 다시보내주세요");
				return;
			}
    	   
       }
            
        
        //인증완료버튼
        function mailEnd(){
        	
        	if( $("#mailEndOk").val() == "OK" ){
        		alert("이미 인증을 완료하셨습니다.");
        		return;
        	}
        	
        	if( $("#mailOverOk").val() == "Y" && $("#mailSendOk").val() == "OK" ){
				if( $("#checkEmail").val() == $('#certCode').val() ){ //인증완료
					alert("이메일 인증이 완료되었습니다.");
					$('#certCode').attr( 'disabled', true );
					$("#mailEndOk").val("OK");
					return;
				}else if($('#certCode').val() != null && $('#certCode').val() != ""){
					if($("#checkEmail").val() != $('#certCode').val()){
						alert("이메일 인증 번호가 다릅니다.");
						return;
					}
				}else if( $('#certCode').val() == null || $('#certCode').val() == "" ){
					alert("인증코드를 입력해주세요.");
					return;
				}
        	}else if( $("#mailOverOk").val() != "Y" ){
        		alert("메일중복확인을해주세요.");
        		return;
        	}else if( $("#mailSendOk").val() != "OK" ){
        		alert("이메일 인증을 진행해주세요.");
        		return;
        	}	
        	
        }
        
       
       //회원가입
       function JoinUs(){
        	
        	var res ="";
        	
        	if( $("#mailEndOk").val() == "OK" ){
        		if( $('#userNm').val() == null || $('#userNm').val() == "" ){
        			alert("닉네임을 작성해주세요.");
        			return;
        		}
        		if( $('#userPwd').val() == null || $('#userPwd').val() == "" ){
        			alert("비밀번호 를 작성해주세요.");
        			return;
        		}
        		if( $('#userPwdCheck').val() == null || $('#userPwdCheck').val() == "" ){
        			alert("비밀번호 재확인을 작성해주세요.");
        			return;
        		}
        		if( $('#userPwd').val() != $('#userPwdCheck').val() ){
        			alert("작성한 비밀번호가 서로 다릅니다. 다시 확인해주세요.");
        			return;
        		}
        		if( $('#userPwd').val() == $('#userPwdCheck').val() ){
        			
        			var pwCheck = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/;
        			
        			if(pwCheck.test($('#userPwd').val()) == false ){
        				alert("비밀번호를 영문숫자 포함 8~16자리로 입력해주세요 ");
        				$('#userPwd').val('');
        				$('#userPwdCheck').val('');
        				return;
        			}
        			
        			var data = {
        		    		 "userName" : $('#userNm').val(),
        		    		 "userPassword" : $('#userPwd').val(),
        		    		 "userEmail" : $('#userEmail').val()
        		     }
        			
        			
        			$.ajax({
                		
                		url: '<c:url value="/member/joinUs.do" />',
                		data : data ,
                		success : function (data, textStatus, XMLHttpRequest) {
                		
                			if(data.resultCode > 0){
                				alert("회원가입이 정상적으로 처리되었습니다.");
                				$('#JoinModal').modal('hide');
                				location.reload();
                			}else{
                				alert("다시 회원가입을 진행해주세요.");
                				$('#JoinModal').modal('hide');
                				location.reload();
                			}
                		
                		},
                		//컨트롤러에서 보낸 result값이 false인경우
                		error : function (XMLHttpRequest, textStatus, errorThrown) {
                			console.log(XMLHttpRequest.responseText);
                			alert(XMLHttpRequest.responseText);
                		}
                	});
        		     
        		    
        			
        		}
        	}else {
        		alert("메일 인증을 진행해주세요.");
        		return;
        	}
        }
            
      //로그인  
      function LoginUs(){
        	
        	var LoginEmail = $('#LoginEmail').val();
        	var LoginPw = $('#LoginPw').val();
        	//alert(LoginEmail);
        	//alert(LoginPw);
        	
        	if( LoginEmail == null || LoginEmail == "" ){
        		alert("이메일을 입력해주세요");
        		return;
        	}
        	
        	if( LoginPw == null || LoginPw == "" ){
        		alert("비밀번호를 입력해주세요");
        		return;
        	}
        	
        	
        	
        	var data = {
        			"userEmail" : LoginEmail,
        			"userPassword" : LoginPw
        	}
        	
        	postAjax("<c:url value='/member/LoginUs.do' />", data, LoginUsAfter);
        	
        	
        }
      
       //로그인 완료후
       function LoginUsAfter(data){
    	   
    	   if(data.resultCode == 1 ){
				$('#LoginModal').modal('hide');
				location.reload();
			}
			if(data.resultCode == 0 ){
				alert("등록된 이메일이 없습니다.");
				return;
			}
			if(data.resultCode == -1 ){
				alert("등록된 비밀번호가 아닙니다.");
				return;
			}
			
       }
      
       //엔터 클릭시 로그인
        function popenter() { 
            if (event.keyCode == 13) {
            	LoginUs();
            }
        }
        
        //로그아웃
        function loginOut() {
        	postAjax("<c:url value='/member/logOut.do' />", "", loginOutAfter);
        }
        
        //로그아웃 이후
        function loginOutAfter(data){
        	location.reload();
        }
        
        
        function ShowLogin(){
        	$('#LoginModal').modal('show');
        }
        
        //비밀번호찾기
        function resetPw(){
        	
        	var userEmail = $("#LoginEmail").val();
        	var textCk = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

        	if( userEmail == null || userEmail == '' ){
        		alert("이메일을 입력해주세요!");
        		return;
        	}else if( textCk.test(userEmail) == false ){
        		alert("이메일 형식이 올바르지 않습니다.");
        		return;
        	}
        	
        	var data = {
        			"userEmail" : userEmail
        	}
        	
			$.ajax({
        		
        		url: '<c:url value="/member/resetPwGo.do" />',
        		data : data ,
        		success : function (data, textStatus, XMLHttpRequest) {
        			if(data.resultCode > 0){
                		
                		var data = {
                    			"receiver" : data.userEmail,
                    			"resetPwYn" : "Y"
                    	}
                		
                		postAjax("<c:url value='/mail/addEmail.do' />", data, resetPwMailAfter);
                		
                	}else{
                		alert("등록된 이메일이 아닙니다.");
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

        function resetPwMailAfter(data){
        	
        	if(data.resultCode > 0 ){
        		alert("이메일 로 인증번호 를 보냈습니다. 인증번호 를 확인해주세요.");
				
        		var userEmail = data.userEmail;
        		
        		var popUrl = '/WebPortfolio/member/resetPw.do?userEmail='+userEmail;
        		
        		var windowW = 400;  // 창의 가로 길이
                var windowH = 420;  // 창의 세로 길이
                var left = Math.ceil((window.screen.width - windowW)/2);
                var top = Math.ceil((window.screen.height - windowH)/2);

                window.open(popUrl,"","top="+top+", left="+left+", height="+windowH+", width="+windowW);

        	}
        }

</script>
</head>
<body>
<div id="wrap" class="frm">
	<form name="bbsForm" method="post">
		<input type="hidden" name="mailOverOk" id="mailOverOk" value=""><!-- 메일중복확인여부 -->
		<input type="hidden" name="mailEndOk" id="mailEndOk" value=""><!-- 인증번호확인여부 -->
		<input type="hidden" name="mailSendOk" id="mailSendOk" value=""><!-- 메일보내기여부 -->
		<input type="hidden" name="checkEmail" id="checkEmail" value=""><!-- 메일인증번호 -->
	</form>	
		<div class="top-title" >KimSuHyeon Web Project&nbsp;&nbsp;::&nbsp;&nbsp;<span class="sub-title" style="font-size: medium"></span>
		<ul class="mypage">
			<c:choose>
				<c:when test="${sessionScope.isLogin == true}">	
					<li class="MyInfo">${sessionScope.LoginName} 님의 방문을 환영합니다.</li>
					<li class="loginOut" onclick="loginOut()"><span class ="glyphicon glyphicon-off"></span> 로그아웃</li>
				</c:when>
				<c:otherwise>
					<li class="login" data-toggle="modal" data-target="#LoginModal" ><span class ="glyphicon glyphicon-off"></span> 로그인</li>
					<li class="join" data-toggle="modal" data-target="#JoinModal"><span class ="glyphicon glyphicon-user"></span> 회원가입</li>
				</c:otherwise>
			</c:choose>
		</ul>
		</div>
		<!--{ Login modal -->
		<div class="modal fade" id="LoginModal" tabindex="-1" role="dialog"  aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h3 class="modal-title text-center" id="myModalLabel">Login</h3>
		      </div>
		      <div class="modal-body">
		        <input type="email" class="col-xs-12" id="LoginEmail" placeholder="이메일" maxlength="50">
		        <input type="password" class="col-xs-12" id="LoginPw"  placeholder="비밀번호" onkeydown="popenter();">
		        <br>
		        <input type="checkbox" id="idSaveCheck">아이디 기억하기
		        <button type="button" class="btn btn-default pull-right" onclick="resetPw()">비밀번호찾기</button>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary btn-lg btn-block" onclick="LoginUs()">로그인</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!--} Login modal -->
		<!--{ Join modal -->
		<div class="modal fade" id="JoinModal" tabindex="-1" role="dialog"  aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h3 class="modal-title text-center" id="myModalLabel">Join</h3>
		      </div>
		      <div class="modal-body">
		        <input type="email" class="col-xs-8" id="userEmail" placeholder="이메일" maxlength="50">
		        <span class="mailWrap"><button type="button" onclick="mailCheck()" class="btn btn-primary col-xs-4" id="mail-check">중복확인</button></span>
		        <ul class="listDot">
					<li>중복확인 한 이메일로 인증 메일이 발송됩니다.</li>
					<li>메일 확인 후 [인증번호] 를 입력하신후 인증확인 버튼을 눌러주시면 이메일 인증이 완료됩니다.</li>
					<li>메일확인이 안될 경우 스펨메일함을 확인해주세요.</li>
				</ul>
				<p id="certMsg" style="display:none;"><input type="text" class="col-xs-12" id="certCode" placeholder="인증번호를 입력해주세요" ></p>
		        <button type="button" class="btn btn-success col-xs-6" id="mailOk" onclick="mailOk()">이메일인증</button>
		        <button type="button" class="btn btn-danger col-xs-6" id="mailEnd" onclick="mailEnd()">인증확인</button>
		        <input type="text" class="col-xs-12" id="userNm" placeholder="닉네임" >
		        <input type="password" class="col-xs-12" id="userPwd" placeholder="비밀번호" >
		        <input type="password" class="col-xs-12" id="userPwdCheck" placeholder="비밀번호 재확인" >
		      </div>
		      <div class="modal-footer">
		        <button type="button" onclick="JoinUs()" class="btn btn-primary btn-lg btn-block">회원가입</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!--} Join modal -->
	
    <!--{ Top nav -->
	<div class="btn-group btn-group-justified" role="group" style="margin-bottom:25px;">
		<div class="btn-group" role="group">
			<a class="btn btn-default list-group-item" href='<c:url value="/home.do" />' target="demoFrame" ><span class ="glyphicon glyphicon-home"></span> HOME </a>
		</div>
		<div class="btn-group" role="group">
			<a class="btn btn-default list-group-item" href='<c:url value="/mail/profile.do" />' target="demoFrame" >  개인프로필</a>
		</div>
		<div class="btn-group" role="group">
			<a class="btn btn-default list-group-item" href='<c:url value="/note/makenote.do"/>' target="demoFrame">  제작노트</a>
		</div>
	</div>
	<!--} Top nav -->
    <!--{ Content -->
     <table cellspacing="10" cellpadding="10">
         <tr>
         	<!--{ left content -->
             <td class="left-wrap">
				<div class="panel-group" id="accordion">
					<!-- 왼쪽 메뉴 그룹(게시판) -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#collapse1">게시판</a>
							</h4>
						</div>
						<div id="collapse1" class="panel-collapse collapse in">
							<div class="panel-body">
								<div class="examples list-group">
									<a href='<c:url value="/notice/noticeList.do" />' class="list-group-item" target="demoFrame">
										익명게시판
									</a>
									
								</div>
							</div>
						</div>
					</div>
					<!-- 왼쪽 메뉴 그룹(조직정보) -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#collapse2">조직 정보</a>
							</h4>
						</div>
						<div id="collapse2" class="panel-collapse collapse in">
							<div class="panel-body">
								<c:choose>
								<c:when test="${sessionScope.isLogin == true}">	
									<div class="examples list-group">
										<a href='<c:url value="/emp/empList.do" />' class="list-group-item" target="demoFrame">
											직원정보
										</a>
										<a href='<c:url value="/dept/deptEdit.do" />' class="list-group-item" target="demoFrame">
											부서정보
										</a>
									</div>	
								</c:when>
								<c:otherwise>
									<div class="examples list-group">
										<a href='javascript:ShowLogin();' class="list-group-item" target="demoFrame">
											직원정보
										</a>
										<a href='javascript:ShowLogin();' class="list-group-item" target="demoFrame">
											부서정보
										</a>
									</div>
								</c:otherwise>
							</c:choose>
							</div>
						</div>
					</div>
					<!--}  panel panel-default-->
					<%-- <div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#collapse3">갤러리</a>
							</h4>
						</div>
						<div id="collapse3" class="panel-collapse collapse in">
							<div class="panel-body">
								<div class="examples list-group">
									<a href="<c:url value='#'/>" class="list-group-item" target="demoFrame">갤러리1</sup></a>
									<a href="<c:url value='/emp/deptList.do'/>" class="list-group-item" target="demoFrame">부서장 정보 <sup style="color:red">New</sup></a>
								</div>
							</div>
						</div>
					</div> --%>
					<!--}  panel panel-default-->
				</div>
              </td>
              <!--} left content -->
              <!--{ right content -->
              <td class="right-wrap">
                 <iframe id="demoFrame" name="demoFrame"></iframe>
             </td>
             <!--} right content -->
         </tr>
     </table>
 </div>  
 <c:import url="/WEB-INF/views/inc_footer.jsp" charEncoding="utf-8" />
</body>
</html>