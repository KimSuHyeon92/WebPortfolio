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

			
        });
	    
	</script>
	<style>
	.footer_wrp {
		background-color: #2d3341;
	    width: 100%;
	    padding: 20px 0;
	    margin-top:30px;
	}
	
	.footer_wrp .inner {
	    width: 1050px;
	    margin: auto;
	    color: #fff;
	}
	
	</style>
</head>
<body>

<div class="footer_wrp">
	<div class="inner">
		<div class="foot_info">
			<p>KimSuHyeon Web Project</p>
		</div>
		COPYRIGHT KimSuHyeon Web Project Corporation. ALL RIGHTS RESERVED
	</div>
</div>
</body>
</html>