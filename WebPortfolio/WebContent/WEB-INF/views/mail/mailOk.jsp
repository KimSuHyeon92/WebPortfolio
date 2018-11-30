<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jqgrid/css/ui.jqgrid.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />
<style>
#mailpost { background: #007fff; margin: 0 20px; color: #fff; padding: 5px 10px;border: none; cursor:pointer;}
#tabs { height:480px; }
</style>

<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/jquery.jqGrid.src.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/i18n/grid.locale-kr.js" />"></script>

<script type="text/javascript">
//스크립트 시작 부분 (document ready function)


$(document).ready(function(){
	//Ioading background opacity
	$("#loading-div-background").css({ opacity: 0.9 });
	//Tab
	$( "#tabs" ).tabs();
	
	
	//메일보내기
	$('#mailpost').click(function(){
		//팝업열기
		$.ajax({
			url:'<c:url value="mailpost.do"/>',
			type:'post',
			cache:false,
			dataType:'html',
			success:function(html){
				$("#dialogMail").html(html);
				$("#dialogMail").dialog({
					height: 200,
			        width: 300,
			        title: '프로필 요청',
			        autoOpen: true,
			        modal: true,
			        resizable: false,
			        autoResize: true,
			        position: { 
			            my : 'center top', 
			            at : 'center top'
			            
			        },
			        open:function(){
			        	
			        	$("#dialogMail button#mailsave").click(function(){
			        		
			        		//작성한 이메일 가져오기
			        		var receiver = $('#dialogMail input#mailtext').val();
			        		var sender = "kimsuhyeon1027@gmail.com";
			        		var subject = "신입 웹개발자 김수현 이력서 입니다.";
			        		var content = "안녕하세요? 신입 웹개발자 김수현이력서 를 받아주셔서 감사합니다.";
			        		//var filename = "";
			        		//var fileSize = ;
			        		
			        		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			        		
			        		//ajax 호출 직전
			        		// overlay 보이기
			        		$("#loading-div-background").css({'z-index' : '9999'}).show();
			        		
			        		if(exptext.test(receiver) == true){
			        			
			        			$.ajax({
			        				url: '<c:url value="addEmail.do" />',
					        		data :{ 'sender' : sender, 
					        			     'receiver' : receiver,
					        			     'subject' : subject,
					        			     'content':content
				        					 },
					        		success : function (depts, textStatus, XMLHttpRequest) {
					        			alert("메일보내기 성공");
					        			$("#loading-div-background").hide();
					        	        $('#dialogMail').dialog('close');
					        	     	// overlay 숨기기
					        	        
					        		},
					        		error : function (XMLHttpRequest, textStatus, errorThrown) {
					        			//alert('에러 \n'+XMLHttpRequest);
					        			alert("메일보내기 실패");
					        		}
			        			});
			        			
			        		}else{
			        			alert("올바른 메일 형식으로 작성해주세요");
			        			return;
			        		}
			        		//if끝
							
						});
						//저장 끝
			        	
			        	//닫기
			        	$("#dialogMail button#mailclose").click(function(){
							$('#dialogMail').dialog('close');
						});
			        },
			        overlay: {
			            opacity: 1,
			            background: "black"
			        },
			     	// overlay 끝
			        close: function(){
			        	
					}
			        // close 끝
				});
				//dialog end
			},
			//success end
			error:function(a,b,c){
				console.log(a);
				console.log(b);
				console.log(c);
			}
			//error end
		});
		//ajax end
		
			  
				
						
		
	
	});
	
	
});



</script>
<title></title>
</head>
<body>

<!-- overlay html start -->
<div id="loading-div-background">
      <div id="loading-div" class="ui-corner-all">
           <img style="height:32px;width:32px;margin:30px;" src="<c:url value='/resources/please_wait.gif'/>" alt="Loading.."/>
           <br>
           PROCESSING. PLEASE WAIT...
      </div>
</div>
<!-- overlay html end -->
<div id="tabs">
	<ul>
		<li><a href="#tabs-1">개인 프로필</a></li>
		
	</ul>

	<div id="tabs-1">
			아래 버튼을 클릭하여 메일 주소를 입력해 주시면<br>메일로 프로필을 받아 보실 수 있습니다.<br><br>
			<span>kimsuhyeonprofile.docx</span><button type="button" id="mailpost" style="margin:0 20px;">요청</button><br><br>
			프로필은 PDF파일입니다.<br>
			프로필 최종 작성일 2017-12-04
		
	</div>

</div>
<!-- 메일보내기 다이얼로그 -->
<div id="dialogMail"></div>

</body>
</html>