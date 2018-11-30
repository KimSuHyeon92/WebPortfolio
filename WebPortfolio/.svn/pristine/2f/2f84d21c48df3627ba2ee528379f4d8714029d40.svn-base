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
/* 전체 부서 정보조회 */
$(document).ready(function(){
	
	// 셀렉트 박스 생성을 위한 ajax 호출
	$.ajax({
		url: '<c:url value="/dept/getSelectBoxData.do" />',
		data : { },
		success : function (depts, textStatus, XMLHttpRequest) {
			// depts : controller에서 return 해준 값 = 부서정보 
			
			var select = $('#deptNos');
			var option = null;
			option = $('<option>').attr({'name' : 'deptNo', 'value' :  ''}).text("선택하세요");
			// <option name="deptNo" vlaue="">선택하세요</option>
			//.attr(속성값추가)
			
			$(select).append(option);
			//each문 밖에 append 하면 for문이 돌지 않아(계속적용이 안되고) 처음 한번만 작성되게된다.
			
			$.each(depts, function(key, dept){
				// $('<option>') 로 태그 생성
				// attr : attribute (속성) 지정
				// text 화면에 보여줄 텍스트 
				
				option = $('<option>').attr({'name' : 'deptNo', 'value' : dept.deptNo}).text(dept.deptName);
				// <option name="deptNo" value="d001"> Finance </option> 
				
				
				 
				
				$(select).append(option);
				
			});
		},
		error : function (XMLHttpRequest, textStatus, errorThrown) {
			alert('에러 \n'+XMLHttpRequest);
		}
	});
	// ajax 끝
	
	
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
	
	//검색 그리드에선언된url에 검색할 파라미터만 붙여 새페이지를열어준다  setGridParam(파라미터셋팅)
	//아이디로 제이쿼리에서 핸들링할경우 버튼에 onclick 은 필요없다.
	//onclick 을 쓸 경우 function사용해서 만들어준다.
	$('#btnSearch').click(function(){
		var deptNo = $('#deptNos option:selected').val();
		var deptName = $('#name').val();
		$("#deptGrid").jqGrid('setGridParam', {
		     postData: { 
				deptNo : deptNo,
				deptName : deptName
			 }, 
			 page : 1 }
		).trigger("reloadGrid");
	});
	
	
});

function excelDownload(){
	
	// bbsForm을 찾아서 frm 변수에 대입
	var frm = document.deptForm;	// $("form[name='bbsForm']")[0]
	frm.action = '<c:url value="/dept/deptListExcel.do" />';
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
	  		departments 테이블의 정보를 가져와 기본적인 정보를 화면에 출력한다. 
		</p>
		<form name="deptForm">
			<fieldset>
		    <legend>조건</legend>
		    <label>부서 : </label>
			<select id="deptNos" name="deptNos"></select>
		    &nbsp;&nbsp;
		    <label>이름 : </label>
		    <input type="text" name="name" id="name" size="40" maxlength="40" />
		    <button type="button" id="btnSearch" >검색</button>
		</fieldset>
		</form>
		<br>
		<button type="button" id="btnExcel" onclick="excelDownload()">EXCEL</button>
		
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