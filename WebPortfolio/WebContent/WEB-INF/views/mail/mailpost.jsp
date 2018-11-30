<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.btngroup { float:right; }
input#mailtext {width:100%; }
button#mailsave , button#mailclose {margin-left:6px;}
</style>
</head>
<body>
<p>메일 주소를 입력 해 주세요</p>
<input type="text" id="mailtext"><br><br>
<div class ="btngroup">
<button type="button" id="mailsave">확인</button>
<button type="button" id="mailclose">닫기</button>
</div>
</body>
</html>