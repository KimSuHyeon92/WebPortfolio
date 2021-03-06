<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jqgrid/css/ui.jqgrid.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />


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
.page_desc li{margin:5px 0 10px;} 
</style>
<title></title>
</head>
<body>

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">HOME</a></li>
	</ul>
	<div id="tabs-1">
			이 페이지는 아래 항목을 이용하여 구현하였습니다.<br/>
	  		<ul class="page_desc">
	  			<li>Server OS : Windows10 64bit</li>
	  			<li>Framework : Spring Framework 4.3.18.RELEASE</li>
				<li>WAS Server : Tomcat 8.5</li>
				<li>WEB Server : Apache</li>
				<li>DB : MySQL 5.7</li>
				<li>형상관리도구 : svn , git</li>
			</ul>
			
		<table id="deptGrid"></table>
		<div id="deptGrid-pager"></div>
	</div>
</div>

</body>
</html>