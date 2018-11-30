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
/* 전체부서 정보조회(수정,쓰기가능 + 검색가능) */
$(document).ready(function(){
	
	var deptGrid = jQuery("#deptGrid").jqGrid({ // jQuery == $
		url : '/WebPortfolio/dept/list.do', //grid:컨텍스트루트
		mtype: "POST",
	    data : {}, //파라미터들어가는곳(name:value)
	    datatype: "json", //데이터타입:제이슨
	    colNames: ["부서번호", "부서명"], //th태그
	    colModel: [
	               { name: "deptNo", index:'deptNo', width: 150, align:'center' }, //DTO의이름과같게
	               { name: "deptName", index:'deptName', width: 150, align:'center' } //, 마지막줄콤마 크롬에서는 무시 익플에서는 오류발생하므로 삭제 
	    ],//배열안 오브젝트형식 
	    jsonReader : { //중괄호이기때문에 오브젝트 를 받는다. 대괄호:배열  중괄호:오브젝트 , 찾아간다.
          	root: "rows", //제이슨페이지에 설정한 메소드들  (JsonResponse.java)
          	page: "page", //page 는 page영역을 찾아간다(제이슨페이지에있는)
          	total: "total",
          	records: "records",
          	repeatitems: false,
          	cell: "cell",
          	id: "id"
      	},
	    autowidth: false,
	    width:500,
	    height: 240,
	    rowNum: 10,
	    rownumbers: true, //true:숫자가붙여서나온다.
	    sortname: "deptNo", //기본정렬 dept_name, dept_no 중
	    sortorder: "asc", //오름차순
	    scrollrows : true,
	    viewrecords: true,
	    gridview: true,
	    autoencode: true,
	    pager: '#deptGrid-pager',
	    altRows: true,
	    caption: "부서 정보", // set caption to any string you wish and it will appear on top of the grid
	    loadComplete : function() {
	    	// 크기 조정
	    	gridResize('deptGrid');
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
//검색 그리드에선언된url에 검색할 파라미터만 붙여 새페이지를열어준다  setGridParam(파라미터셋팅)
function search(){
	$("#deptGrid").jqGrid('setGridParam', {
	     postData: { 
			deptNo : $('#deptNo').val(), 
			deptName : $("#deptName").val() 
		 }, 
		 page : 1 }
	).trigger("reloadGrid"); //reflush 기능과 같음
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
	  		departments 테이블의 정보를 가져와 기본적인 정보를 화면에 출력한다. 
		</p>
		<fieldset>
		    <legend>조건</legend>
		    <label for="p_deptNo">부서코드 : </label>
		    <input type="text" name="deptNo" id="deptNo" size="4" maxlength="4" />
		    &nbsp;&nbsp;
		    <label for="p_deptName">부서명 : </label>
		    <input type="text" name="deptName" id="deptName" size="20" maxlength="20" />
		    
		    <button type="button" id="btnSearch" onclick="search()">검색</button>
		</fieldset>
		<br>
		<table id="deptGrid"></table>
		<div id="deptGrid-pager"></div>
	</div>
	<div id="tabs-2">
		<p></p>
	</div>
</div>
<!-- End of code related to code tabs -->
</body>
</html>