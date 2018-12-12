<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jqgrid/css/ui.jqgrid.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />
<style>
button {     
	background: #007fff;
    border: none;
    color: #fff;
    padding: 5px 10px;
    margin-left: 15px;
    cursor:pointer; }

</style>

<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/jquery.jqGrid.src.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/i18n/grid.locale-kr.js" />"></script>

<script type="text/javascript">

$(document).ready(function(){
	//Tab
	$( "#tabs" ).tabs();
});
</script>
<style>
li{margin:15px 0;}
</style>
<title></title>
</head>
<body>

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">제작노트</a></li>
		<li><a href="#tabs-2">모델링노트</a></li>
	</ul>
	<div id="tabs-1">
		<ul>
			<%-- <li>[샘플 DB import 및 데이터 확인]&nbsp;<a href='<c:url value="https://goo.gl/jb1k8L" />' target="blank"><button type="button" >이동</button></a></li> --%>
			<li>[이메일 보내기 버튼 구현]&nbsp;<a href='<c:url value="https://www.evernote.com/l/AXDvNYscuahP6JKlyh9sey2VNe0HS310NrE/" />' target="blank"><button type="button" >이동</button></a></li>
			<li>[리눅스 Svn설치 및 셋팅방법]&nbsp;<a href='<c:url value="https://www.evernote.com/l/AXA_8wQ-B2NNlLINMK0LiuWPGCc0dB-FwUo/" />' target="blank"><button type="button" >이동</button></a></li>
			<li>[리눅스 Mysql설치 및 셋팅방법]&nbsp;<a href='<c:url value="https://www.evernote.com/l/AXA0BuyPIOtGN5kpIP9PybkSB0996vYEGSE/" />' target="blank"><button type="button" >이동</button></a></li>
			<li>[직원정보 추가버튼 구현정리]&nbsp;<a href='<c:url value="http://www.evernote.com/l/AXBakYL74khFjYSuF0yvdtpElCLTVVS_dpE/" />' target="blank"><button type="button" >이동</button></a></li>
			<li>[input box 에 숫자만,숫자 뒤 % 자동으로 입력구현]&nbsp;<a href='<c:url value="https://www.evernote.com/l/AXDnw6BZUtZDRYAzNauG2QTfJD-7FIM8N5Y/" />' target="blank"><button type="button" >이동</button></a></li>
		</ul>
	</div>
	<div id="tabs-2">
		<ul>
			<li>직원정보 DB 모델링 (JPG)&nbsp;<a href='<c:url value="/note/empdownModelingImg.do" />' target="blank"><button type="button" >다운로드</button></a></li>
			<%-- <li>직원정보 DB 모델링 파일 (MVB)&nbsp;<a href='<c:url value="/note/empdownModelingmvb.do" />' target="blank"><button type="button" >다운로드</button></a></li> --%>
			<li>익명게시판 DB 모델링 (JPG)&nbsp;<a href='<c:url value="/note/brddownModelingImg.do" />' target="blank"><button type="button" >다운로드</button></a></li>
			<%-- <li>익명게시판 DB 모델링 파일 (MVB)&nbsp;<a href='<c:url value="/note/brddownModelingmvb.do" />' target="blank"><button type="button" >다운로드</button></a></li> --%>
			<li>회원정보 DB 모델링 (JPG)&nbsp;<a href='<c:url value="/note/memdownModelingImg.do" />' target="blank"><button type="button" >다운로드</button></a></li>
			<li>이메일 DB 모델링 (JPG)&nbsp;<a href='<c:url value="/note/maildownModelingImg.do" />' target="blank"><button type="button" >다운로드</button></a></li>
		</ul>
	</div>
</div>

</body>
</html>