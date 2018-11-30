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
#btnExcel { 
	float:right; 
	margin-bottom:15px;
	background: #007fff;
    border: none;
    color: #fff;
    padding: 5px 10px;
    margin-left: 15px;
    cursor:pointer;}
#gbox_deptGrid { clear:both;}
</style>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/jquery.jqGrid.src.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/i18n/grid.locale-kr.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />"></script>

<script type="text/javascript">
/* 전체부서 정보조회(수정,쓰기가능) */
$(document).ready(function(){
	
	var deptGrid = jQuery("#deptGrid").jqGrid({
		url : '/WebPortfolio/dept/list.do',
		mtype: "POST",
	    data : {},
	    datatype: "json",
	    colNames: ["부서번호", "부서명"],
	    colModel: [/* editable:true 수정,쓰기 를 가능하게 하겠다.   editoptions:required(필수값)  index값을 컬럼명과같게했기때문에 값을 가져올수있다 .  ,  maxlength:인풋박스 에 들어갈 최대글자수 , size:인풋박스 사이즈   */
	               { name: "deptNo", index:'deptNo', width: 150, align:'center', editable:true, editoptions:{required:true} },
	               { name: "deptName", index:'deptName', width: 150, align:'center', editable:true, editoptions:{required:true} }
	    ],
	    jsonReader : {
          	root: "rows",
          	page: "page",
          	total: "total",
          	records: "records",
          	repeatitems: false,
          	cell: "cell",
          	id: "deptNo" //id를 conModel에 없는 값을 쓰면 그냥 행 번호를 불러오기때문에 3페이지에서 3번째행 지우면 1페이지 3번째행이 지워지게된다.
      	},
	    autowidth: false,
	    width:500,
	    height: 240,
	    rowNum: 10,
	    rownumbers: true,
	    sortname: "deptNo", //정렬기준
	    sortorder: "asc",
	    scrollrows : true,
	    viewrecords: true,
	    gridview: true,
	    autoencode: true,
	    altRows: true,
	    pager: '#deptGrid-pager',
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
	
	//navButtons
	jQuery(deptGrid).jqGrid('navGrid', "#deptGrid-pager",
		{ 	//navbar options
			edit: true,
			add: true,
			del: true,
			search: false,
			refresh: true,
			view: false
		},
		{
			// 수정
			editCaption:'부서정보 수정', 
			url : '<c:url value="/dept/editDeptInfo.do" />',
			closeOnEscape: true, 
			closeAfterEdit: true,
			reloadAfterSubmit:true,  
			recreateForm: true,
			viewPagerButtons: false,
			// 버튼클릭시 나오는 폼 조작을 위해(*)
			beforeShowForm : function(form) {
				var form = $(form[0]);
				$(form).find('input#deptNo').attr("readonly",true);
			}, 
			// 유효성체크(*)
			beforeSubmit : function(post, formId){
				if(post.codeName == ''){
					return [false, "코드명을 입력하세요.", ""];
				}else if(post.description == ''){
					return [false, "부서명을 입력하세요.", ""];
				}else if(post.description.length >= 40 ){
					return [false,"부서명은 40자 내로 입력하세요",""];
				}
				return [true, "", ""]; 
			},
			// 데이터가 갔다가 제대로 오면 사용할 코드(*)
			afterComplete : function(response, postdata){ //response(컨트롤러가리턴한값) postdata(컨트롤러 로 전송한값이 다시 넘어옴)
				console.log('editOption - afterComplete');
				console.log(response);
				console.log('-----------------------------');
				// Controller에서 return한 값은 response.responseJSON 로 받을 수 있다.(map으로 넘어온값 responsebody 를 사용햇기때문에 리턴값을 박기 위해서 json을 사용하면 자동파싱해줌)
				var data = response.responseJSON;
				if(data.result == 1){
					alert(data.msg);
				}
			},
			// 전송하고난후 코드
			afterSubmit : function(response, postdata){
				return [true, '', ''];
			}
		},
		{
			// 추가
			addCaption: "부서정보 입력",
			url : '<c:url value="/dept/addDeptInfo.do" />',
			closeOnEscape: true, 
			closeAfterAdd: true,
			reloadAfterSubmit:true, 
			recreateForm: true,
			viewPagerButtons: false,
			beforeShowForm : function(form) {
	            var form = $(form[0]);
	            var inputDeptNo = $(form).find('input#deptNo');
	            var inputDeptName = $(form).find('input#deptName');
	            
	            $(form).find('input#deptNo').keypress(function(e){
	               var key = e.which;
	               if((key >= 48 && key <=57) ||   // 숫자열 0 ~ 9 : 48 ~ 57
	                  key == 46 ||            // Delete
	                  key == 37 ||            // 좌 화살표
	                  key == 39 ||            // 우 화살표
	                  key == 35 ||            // End 키
	                  key == 36 ||            // Home 키
	                  key == 9){               // Tab 키
	               }else{
	            	   
	                  return false;
	               }
	            });
	            
	            $(inputDeptNo).keyup(function(e){
	               //                 사용자가 입력 한 값에서  d를 제거한다. 
	               var inputDeptNo = $(this).val().replace('d',"");
	               // 공백일 시 화면에 공백을 보여주고 숫자가 한자라도 있다면 앞에 'd' 붙여넣기
	               inputDeptNo = (inputDeptNo == '' || inputDeptNo == null)
	                  ? '' : 'd' + inputDeptNo;
	               
	                $(this).val(inputDeptNo);   
	            });
	   
	         }, 
			// 유효성 검사를 여기에서 한다.  ,  post:컨트롤러로넘어가는값들이담겨져있다.
			beforeSubmit : function(post, formId){
				
				if(post.deptNo == ''){ //
					return [false, "부서코드를 입력하세요.", ""];
				}else if(post.deptName == ''){
					return [false, "부서명을 입력하세요.", ""];
				}else if(post.deptName.length > 40 ){
					return [false,"부서명은 40자 내로 입력하세요",""];
				}else if(post.deptNo.length > 4 ){
					return [false,"부서코드는 4자 내로 입력하세요",""];
				}
				return [true, "", ""]; 
			}, 
			// 이벤트 시점의 차이, submit 직후 = afterSubmit, 컨트롤러에서 사용자 요청 처리 후 응답이 온 경우 = afterComplete
			afterSubmit : function(response, postdata){
				return [true, '', ''];
			},
			afterComplete : function(response, postdata){
				console.log('addOption - afterComplete');
				console.log(response);
				console.log('-----------------------------');
				// Controller에서 return한 값은 response.responseJSON 로 받을 수 있다.
				var data = response.responseJSON;
				if(data.result == 1){
					alert(data.msg);
				}
			}
		},
		{
			// 삭제
			caption: '부서정보 삭제',
			msg: "선택한 부서를 삭제 하시겠습니까?", //삭제후경고표시
			recreateForm: true,
			url : '<c:url value="/dept/delDeptInfo.do" />',
			beforeShowForm : function(e) {
				var form = $(e[0]);
			},
			afterComplete : function(response, postdata){
				console.log('delOption - afterComplete');
				console.log(response);
				console.log('-----------------------------');
				// Controller에서 return한 값은 response.responseJSON 로 받을 수 있다.
				var data = response.responseJSON;
				if(data.result == 1){
					alert(data.msg);
				}
			},
			onClick : function(e) {
// 				alert(1);
			}
		}
	);
	// Tab
	$( "#tabs" ).tabs();
});

function excelDownload(){
	
	// bbsForm을 찾아서 frm 변수에 대입
	var frm = document.deptForm;	// $("form[name='bbsForm']")[0]
	frm.action = '<c:url value="/dept/deptEditExcel.do" />';
	frm.submit();
}

</script>
<title>jqGrid example</title>
</head>
<body>
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">부서정보</a></li>

  </ul>
  <div id="tabs-1">
    <p class="page_desc">
    	<span class ="glyphicon glyphicon-hand-right"></span>
  		<span>departments 테이블의 정보를 가져와 화면에 출력하고, <br/> 입력/수정/삭제 기능을 jqGrid의 기본 다이얼로그로 구현한다.</span> 
	</p>
	<form name="deptForm">
	<button type="button" id="btnExcel" onclick="excelDownload()">엑셀 다운로드</button>
	</form>
		<table id="deptGrid"></table>
		<div id="deptGrid-pager"></div>
  </div>
  <div id="tabs-2">
    <p>
    
    </p>
  </div>
</div>
<!-- End of code related to code tabs -->
</body>
</html>