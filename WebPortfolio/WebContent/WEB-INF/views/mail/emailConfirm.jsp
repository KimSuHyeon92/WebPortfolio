<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>김수현 포트폴리오 회원인증완료</title>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
</head>
<body>
	<script type="text/javascript">
	
	
	
	
		//alert("여기도타야지");
		var userEmail = '${userEmail}';
		var authNum = '${authNum}';
		alert(userEmail);
		alert(authNum);
		
		
		
	

	var userEmail = '${userEmail}';
	
	alert(userEmail + '님 회원가입을 축하합니다. 이제 로그인이 가능 합니다.');

	window.open('', '_self', ''); // 브라우저창 닫기
	window.close(); // 브라우저 창 닫기
	
	
	</script>
</body>
</html>