<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" /><!-- mvc:resource를 찾아간다. -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jqgrid/css/ui.jqgrid.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />

<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script> <!-- c:url 자동으로 컨테스트루트 를 불러온다. -->
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/jquery.jqGrid.src.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/i18n/grid.locale-kr.js" />"></script> <!-- 한글번역 -->
<script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>

<script type="text/javascript">
/*전체부서 부서장정보 조회*/
$(document).ready(function(){
	
	var managerGrid = jQuery("#managerGrid").jqGrid({ // jQuery == $
		url : '/WebPortfolio/emp/deptPage.do', //grid:컨텍스트루트
		mtype: "POST",
	    data : {}, //파라미터들어가는곳(name:value)
	    datatype: "json", //데이터타입:제이슨
	    colNames: ["부서코드", "부서명", "이름", "착임일", "현재연봉"], //th태그
	    colModel: [
	    		   { name: "deptNo", index:'deptNo', width: 150, align:'center' },
	               { name: "deptName", index:'deptName', width: 150, align:'center' },
	               { name: "fullName", index:'fullName', width: 150, align:'center' },	        
	               { name: "fromDate", index:'fromDate', width: 150, align:'center' },
	               { name: "salary", index:'salary', width: 150, align:'center' }
	    ],//배열안 오브젝트형식 
	    jsonReader : { //중괄호이기때문에 오브젝트 를 받는다. 대괄호:배열  중괄호:오브젝트 , 찾아간다.
          	root: "rows", //제이슨페이지에 설정한 메소드들  (JsonResponse.java)
          	page: "page", //page 는 page영역을 찾아간다(제이슨페이지에있는)
          	total: "total",
          	records: "records",
          	repeatitems: false,
          	cell: "cell",
          	id: "deptNo"
      	},
	    autowidth: false,
	    width:500,
	    height: 400,
	    rowNum: 20,
	    rownumbers: true, //true:숫자가붙여서나온다.
	    sortname: "deptNo", //기본정렬 dept_name, dept_no 중
	    sortorder: "asc", //오름차순
	    scrollrows : true,
	    viewrecords: true,
	    gridview: true,
	    autoencode: true,
	    pager: '#managerGrid-pager',
	    altRows: true,
	    caption: "부서장 정보",
	    loadComplete : function() {
	    	// 크기 조정
	    	gridResize('managerGrid');
		},
		onCellSelect: function (rowId, colIdx, value) {
		},
		onSelectRow: function(id){
      		return;
        }
	});
	// Tab
	$("#tabs").tabs();
});

function DownloadExcel(){
	
	var frm = document.deptmForm;
	
	frm.action="<c:url value='/emp/deptmListExcel.do'/>";
	
	frm.submit();
	
}
</script>
<title>jqGrid example</title>
</head>
<body>
<div id="tabs">
	<ul>
		<li><a href="#tabs-1">결과</a></li>
		<li><a href="#tabs-2">기타</a></li>
	</ul>
	<div id="tabs-1">
	    <p class="page_desc">
	  		dept_manager 테이블의 정보를 가져와 기본적인 정보를 화면에 출력한다. 
		</p>
		<form name="deptmForm">
		<button id="btnExcel" onclick="DownloadExcel()">Excel</button>
		</form>
		<table id="managerGrid"></table>
		<div id="managerGrid-pager"></div>
	</div>
	<div id="tabs-2">
		<p></p>
	</div>
</div>
</body>
</html>