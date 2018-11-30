<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- tag library 선언 : fmt tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" /><!-- mvc:resource를 찾아간다. -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jqgrid/css/ui.jqgrid.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />
<style>

#keywords { width:470px; }
#btnWrite { 
	float:right; 
	margin-bottom:15px;
	background: #007fff;
    border: none;
    color: #fff;
    padding: 5px 10px;
    margin-left: 15px;
    cursor:pointer;}
#gbox_noticeGrid { clear:both;}
#btnSearch { 
	background: #888;
    border: none;
    color: #fff;
    padding: 5px 10px;
    margin-left: 15px;
    cursor:pointer; }

</style>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script> <!-- c:url 자동으로 컨테스트루트 를 불러온다. -->
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/jquery.jqGrid.src.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/i18n/grid.locale-kr.js" />"></script> <!-- 한글번역 -->
<script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	
	$('#btnWrite').hide();
	
	var noticeGrid = jQuery("#noticeGrid").jqGrid({ // jQuery == $
		url : '/WebPortfolio/notice/list.do', //grid:컨텍스트루트
		mtype: "POST",
	    data : {}, //파라미터들어가는곳(name:value)
	    datatype: "json", //데이터타입:제이슨
	    page : $('#currentPageNo').val(),
	    colNames: ["번호", "제목", "작성자", "조회수", "작성일"], //th태그
	    colModel: [
	               { name: "no", index:'no', width: 80, align:'center' }, //DTO의이름과같게
	               { name: "title", index:'title', width: 250, align:'center' }, //, 마지막줄콤마 크롬에서는 무시 익플에서는 오류발생하므로 삭제 
	               { name: "name", index:'name', width: 100, align:'center' },
	               { name: "readCnt", index:'readCnt', width: 50, align:'center' },
	               { name: "createDate", index:'createDate', width: 150, align:'center'}
	    ],//배열안 오브젝트형식 
	    jsonReader : { //중괄호이기때문에 오브젝트 를 받는다. 대괄호:배열  중괄호:오브젝트 , 찾아간다.
          	root: "rows", //제이슨페이지에 설정한 메소드들  (JsonResponse.java)
          	page: "page", //page 는 page영역을 찾아간다(제이슨페이지에있는)
          	total: "total",
          	records: "records",
          	repeatitems: false,
          	cell: "cell",
          	id: "no"
      	},
	    autowidth: false,
	    width:500,
	    height: 480,
	    rowNum: 20,
	    rownumbers: true, //true:숫자가붙여서나온다.
	    sortname: "no", //정렬기준   sord
	    sortorder: "desc", //오름차순 sidx
	    scrollrows : true,
	    viewrecords: true,
	    gridview: true,
	    autoencode: true,
	    pager: '#noticeGrid-pager',
	    altRows: true,
	    caption: "부서 정보", // set caption to any string you wish and it will appear on top of the grid
	    loadComplete : function() {
	    	// 크기 조정
	    	gridResize('noticeGrid');
	    	$('#btnWrite').show();
		},
		// row의 cell클릭했을때
		onCellSelect: function (rowId, colIdx, value) {
			
		},
		// rowq를 클릭했을때 rowId = jsonReader 에서 id컬럼값
		onSelectRow: function(rowId){
			//현재 클릭한 row의 전체 데이터 가져오기
			var rowData = $(this).jqGrid("getRowData",rowId);
			//현재 페이지 번호 가져오기
			var currentPageNo = $(this).jqGrid("getGridParam","page");
			//현재 [글번호] 와 [현재페이지번호]를 파라미터로 넘겨준다.
			window.location.href="/WebPortfolio/notice/read.do?noticeNo="+rowId+"&currentPageNo="+currentPageNo;
			return;
        }
	});
	
	//navButtons
	jQuery(noticeGrid).jqGrid('navGrid', "#noticeGrid-pager",
		{ 	//navbar options
			edit: false,
			add: false,
			del: false,
			search: false,
			refresh: true,
			view: false
		}
	);
	
	// Tab
	$("#tabs").tabs();
	
	//작성버튼을클릭하면(button태그 id #으로 가져옴)
	$('#btnWrite').click(
		function(){
			//뒤로가기 를 실행하기위해
			var currentPageNo = $('#noticeGrid').jqGrid("getGridParam", "page");
			// 현재 [글 번호]와 [현재 페이지 번호]를 파라미터로 넘겨준다.
			window.location.href = "/WebPortfolio/notice/noticeWrite.do?currentPageNo="+currentPageNo;	
		}
	);
	
	$("#keywords").keydown(function(key) {
		
        if(key.keyCode == 13){//엔터키13
        	
        	search();
        }
 
    });

	
	
});


//검색 
function search(){
	var select =  $('#SelectBox option:selected').val();
	console.log(select);
	
	
	
	if(select == "title"){
		var title = $('#keywords').val();
		console.log("title >> "+title);
	}
	if(select == "name"){
		var name = $('#keywords').val();
	}
	
	console.log("title >>" +title+"name >>"+name);
	
	
	
	$("#noticeGrid").jqGrid('setGridParam', {
	     postData: { 
	    	'title' : title,
	    	'name' : name
		 }, 
		 page : 1 }
	).trigger("reloadGrid");
}

</script>
</head>
<body>
<input type="hidden" id="currentPageNo" name="currentPageNo" value="${currentPageNo}" />
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">결과</a></li>
  </ul>
  <div id="tabs-1">
    <p class="page_desc">
    	<span class ="glyphicon glyphicon-hand-right"></span>
	</p>
		<fieldset>
		    <legend>검색</legend>
			<select id="SelectBox" name="SelectBox">
				<option value="title">제목</option>
				<option value="name">작성자</option>
			</select>
			<label for="p_deptNo">검색어 : </label>
		    <input type="text" name="keywords" id="keywords" size="50" maxlength="100" />    
		    <button type="button" id="btnSearch" onclick="search()">조회</button>
		</fieldset>
		<br/>
		<button type="button" id="btnWrite">작성</button>
		<table id="noticeGrid"></table>
		<div id="noticeGrid-pager"></div>
		<br/>
  </div>
  <div id="tabs-2">
		<p></p>
	</div>
</div>
<!-- End of code related to code tabs -->
</body>
</html>