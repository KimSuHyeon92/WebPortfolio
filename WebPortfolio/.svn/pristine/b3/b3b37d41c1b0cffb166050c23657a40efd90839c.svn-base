<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jqgrid/css/ui.jqgrid.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />

<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/jquery.jqGrid.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/i18n/grid.locale-kr.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />"></script>

<script type="text/javascript">

$(document).ready(function(){
	//그리드가 불러지기전엔 버튼이 보이지 않도록 숨겨둔다.
	$('#dialogPopUp').hide();
	$('#btnChngDeptInfo').hide();
	$('#btnChngTitlesInfo').hide();
	$('#btnChngSalaryInfo').hide();
	$('#btnAddEmpInfo').hide();
	$('#btnDelEmp').hide();
	
	
	//dialogPopup창에 데이터를 입력 후 닫고 다시 열었을 때 데이터가 안지워졌을 경우 해결 방법
    //보여 줄  html을 변수로 저장해 놓은 뒤 dialog close function에 .html(dialogHtml);로 덮어씌운다
	var dialogHtml = null;
	
	
	// datepicker 언어 설정
	$.datepicker.setDefaults( $.datepicker.regional['ko'] );
	
	//셀렉트박스에 부서이름을 뿌려주기 위해 비동기로 작업 (보여지는건 부서이름이지만 설정은 부서번호)
	//검색조건을 가져오기 위한 작업
	$.ajax({
		url: '<c:url value="/dept/getSelectBoxData.do" />', //1이 url을 호출하면 돌아와야 할 데이터는 부서정보 전체가 와야 한다.
		data : { },	//2여기 오브젝트안에 이름:값 을 넣어주면 파라미터로 넘어온다
		success : function (depts, textStatus, XMLHttpRequest) {	//통신이 성공하면 여기로 온다
			// depts : controller에서 return 해준 값 = 부서정보 
			console.log(depts);	//첫번째 매개변수 : 컨트롤러에서 리턴시킨값을 확인한다
			//F12 개발자모드 console에 부서정보가 찍혀있다.
		
			var select = $('#deptNos');
			var dialogSelect = $('#diagDeptNos');
			
			var option1 = $('<option>').attr({'name' : 'deptNo', value : ''}).text("제목")
			var option2 = $('<option>').attr({'name' : 'deptNo', value : ''}).text("(부서)")
			
			// <option name="deptNo" value=""> 선택하세요</option>			
			
			$(select).append(option1);	//셀렉트박스 맨 위에 출력하기 위해 each문 위해 적어준다.	선택하세요 출력
			$(dialogSelect).append(option2);	//셀렉트박스 맨 위에 출력하기 위해 each문 위해 적어준다.	선택하세요 출력
			
			$.each(depts, function(key, dept){
// 여러개의 dept가 오브젝트로 묶여서 여러개가 나오는데 그게 depts
				// $('<option>') 로 태그 생성
				// attr : attribute (속성) 지정
				// text 화면에 보여줄 텍스트                                                  컨트롤러에서 리턴한 10개의 값 하나하나가 dept
				option1 = $('<option>').attr({'deptName' : 'deptNo', 'value' : dept.deptNo}).text(dept.deptName);
				option2 = $('<option>').attr({'deptName' : 'deptNo', 'value' : dept.deptNo}).text(dept.deptName);
				
				// <option deptName="deptNo" value="dept.deptNo"> dept.deptName </option>			<< 이 태그를 제이쿼리를 통해 만든다. 
				
				$(select).append(option1);	//위에서만든 옵션을 셀렉트태그(deptNos)안에 추가한다.
				$(dialogSelect).append(option2);	//위에서만든 옵션을 셀렉트태그(deptNos)안에 추가한다.
			});
			dialogHtml = $('#dialogPopUp').html();
		},
		error : function (XMLHttpRequest, textStatus, errorThrown) {
			alert('에러 \n'+XMLHttpRequest);
		}
	});
	// ajax 끝
	//비동기라 위 코드가 실행되자마자 결과 상관없이 다음 코드가 실행된다.

	
	
	
	
	
	//                          div ID
	var employeesGrid = jQuery("#employeesGrid").jqGrid({	//#페이지이동4
		url : '/jq/emp/employeesList.do',	
		mtype: "POST",
	    data : {},
	    datatype: "json",
	    page : $('#currentPageNo').val(),
	    colNames: ["hidden","hidden","hidden","hidden","사원번호","이름","성별","나이","입사일","근무부서","착임일", "연봉"],
	    colModel: [	//배열로 되어있고, 오브젝트로 구성
	    		   { name: "title", index:'title', hidden:true },
	    		   { name: "deptNo", index:'deptNo', hidden:true },
	    		   { name: "salariesFromDate", index:'salariesFromDate', hidden:true },
	    		   { name: "titlesFromDate", index:'titlesFromDate', hidden:true },
	    		   { name: "empNo", index:'empNo', width: 70, align:'center', editable:true, editoptions:{disabled : true} },
//editable:true 추가수정을 할 때 이 항목이 다이얼로그에 나타난다(수정/추가를 가능하게하겠단 의미), editoptions{옵션} //{}<오브젝트         필수값이냐         사이즈        최대길이는 몇자인지																				               
	               { name: "fullName", index:'fullName', width: 150, align:'center', editable:true, editoptions:{required:true, size:"20", maxlength:"30"} },
//                                                                                             false: 수정버튼을 누를 때 이 항목은 아예 출력이 안된다.	    
	               { name: "gender", index:'gender', width: 60, align:'center', editable:true, edittype:'select', editoptions:{value: {'M':'남', 'F':'여'}}  },
	               { name: "birthDate", index:'birthDate', width: 60, align:'center', editable:true, editoptions:{disabled : true} },
	               { name: "hireDate", index:'hireDate', width: 90, align:'center', editable:true, editoptions:{required:true, size:"20"} },
	               { name: "deptName", index:'deptName', width: 190, align:'center', editable:true, editoptions:{required:true, size:"20", maxlength:"40"} },
	               { name: "fromDate", index:'fromDate', width: 130, align:'center', editable:true, editoptions:{required:true, size:"20"} },
	               { name: "salary", index:'salary', width: 100, align:'center', editable:true, editoptions:{required:true, size:"20", maxlength:"11"} }
	              ],
	    jsonReader : {
          	root: "rows",
          	page: "page",
          	total: "total",
          	records: "records",
          	repeatitems: false,
          	cell: "cell",
          	id: "empNo"	//pk값을 가지고 있는 컬럼	(colModel에 있는 값을 넣어줘야 한다.)
      	},
	    autowidth: false,
	    width:500,
	    height: 260,
	    rowNum: 10,
	    rownumbers: true,	//자동으로 생성되는 테이블 row번호 출력 여부
	    sortname: "empNo",
	    sortorder: "desc",
	    scrollrows : true,
	    viewrecords: true,
	    gridview: true,
	    autoencode: true,
	    altRows: true,
	    pager: '#employeesGrid-pager',	//div ID
        caption: "사원 정보", // set caption to any string you wish and it will appear on top of the grid
	  
      	//
        loadComplete : function() {
	    	// 크기 조정,  크기 조절 무조건 작성해줘야 한다. 그래야 화면이 이쁘게 출력
	    	gridResize('employeesGrid');
	    	
	    	//그리드load가 성공하면 직원추가 버튼을 보여준다.
	    
	    	$('#btnChngDeptInfo').show();
	    	$('#btnChngTitlesInfo').show();
	    	$('#btnChngSalaryInfo').show();
	    	$('#btnAddEmpInfo').show();
	    	$('#btnDelEmp').show();
		},
		onCellSelect: function (rowId, colIdx, value) {
		},
		onSelectRow: function(empNo){
//		 jsonReader에서 설정한 id ↑ , row를 클릭하면 jqGrid는 클릭한 걸 식별해야하는데 id를 통해 식별			
			return;
		//row를 클릭 시 발생 하는 이벤트가 없기때문에 비워둔다.	
        }
	}); // 리스트 보여주는거 끝
	
	//navButtons
//           ↓ Script상단에 작성한 페이지화면 구성한 정보가 담겨있는 변수
	jQuery(employeesGrid).jqGrid('navGrid', "#employeesGrid-pager",
		{ 	//navbar options  네비게이션약자      어떤코드에넣어줄지
			edit: false,	//수정, true하면 버튼이 나오고 false하면 버튼이 안나온다
			add: false,	//추가
			del: false,	//삭제
			search: false,	//검색
			refresh: true,	//새로고침
			view: true	//개별보기
		}
		
	);//nav버튼 끝
	
	// Tab
	$( "#tabs" ).tabs();
	

	$('#btnSearch').click(function(){
		search();	
	});
	
	
	
	
	// 직원추가 버튼 클릭
	$('#btnAddEmpInfo').click(function(){	//2. 
//     찾을아이디                               클릭         펑션(){실행될 내용}		
		
		var divHeight = 430;
		var divWidth = 400;
		
		$("#dialogPopUp").dialog( { 	
//          divID         다이얼로그로 보여주겠단 펑션		

			//기본옵션이기때문에 내 맘대로변경할수 있다
			height: divHeight,	//높이
	        width: divWidth,	//넓이
	        title: "직원 정보 추가",	
	        autoOpen: true,	
	        modal: true,	//
	        resizable: false,	
	        autoResize: true,
	        position : ['center',100],	//창이 뜰 위치, [x,y] 위에서부터 100아래로 창 오픈
	      	
	        //다이얼로그가 열렸을 때 
	        open: function(){
	        
	        	// 생년월일
	        	$( "#birthDate" ).datepicker(	
	        	//  id            , 옵션은 오브젝트형으로 이름표:값으로 넣어준다		
	       			{
	       				defaultDate : "-19Y",
	       				changeMonth : false,
	       				changeYear : true,
	       				maxDate : '0',	//0이 현재(일, day), 오늘이후는 선택이 안된다.
	       				yearRange : '-50:+0',	// 50년 전 부터 현재년도까지, 범위설정
	       				dateFormat : "yy-mm-dd",	//datepicker는 yy두개 , mySQL은 y가 1개
      					dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],	//해당 요일의 tooltip에 나타나는 Text
      			        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],//날짜선택기에 표시하는 요일의 약자를 설정
      			        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    				onClose: function( selectedDate ) {	// datepicker 닫힐 때
	   			        	// selectedDate : 선택된값, 즉 날짜를 입사일 datepicker의 최소값으로 설정해준다
	   			        	$( '#hireDate' ).datepicker("option", "minDate", selectedDate);
	        				}	       			
	       			
	       			}
	        	);
	        	// 입사일
	        	$( "#dialogPopUp #hireDate" ).datepicker(
        			{
        				defaultDate : "0",
        				changeMonth : false,
        				changeYear : true,
        				maxDate : '0',
        				yearRange : '-20:+0',	// 20년 전 부터 현재
        				dateFormat : "yy-mm-dd",
       					dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],	//해당 요일의 tooltip에 나타나는 Text
       			        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],//날짜선택기에 표시하는 요일의 약자를 설정
       			        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        				onClose: function( selectedDate ) {	// datepicker 닫힐 때
   			        	// selectedDate : 선택된값, 즉 날짜를 착임일 datepicker의 최소값으로 설정해준다
   			        	$( '#fromDate' ).datepicker("option", "minDate", selectedDate);
        				}
        			}
	        	);
	        	// 착임일
	        	$( "#fromDate" ).datepicker(
        			{
        				defaultDate : "0",
        				yearRange : '-50:+0',
        				changeMonth : false,
        				changeYear : true,
        				dateFormat : "yy-mm-dd",
       					dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],	//해당 요일의 tooltip에 나타나는 Text
       			        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],//날짜선택기에 표시하는 요일의 약자를 설정
       			        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       			        minDate : '0'	//착임일은 입사일 이후로 선택이 가능하도록 제약을 걸어둔다.
        			}
	        	);
	        },
	        overlay: {
	            opacity: 0.5,
	            background: "black"
	        },
	        close: function(){
	        	$('#dialogPopUp').html(dialogHtml);
			}
	    });
		
	});	//dialog이벤트 끝
	
	
	
	
	//부서 변경 클릭 시작
	$('#btnChngDeptInfo').click(function(){

		//특정 직원을 클릭 후 부서변경을 하기위해 선택한 row의 id 가져오기
		var rowId = $("#employeesGrid").jqGrid('getGridParam', 'selrow');
		
		//rowId가 없다면 직원을 선택 안한게 된다.
		if(rowId == null || rowId == ''){
			alert('직원을 선택하세요!');
		}
		else{
			// rowId로 row 값 가져오기 >> 자바스크립트에서 return type = Object형으로 반환
			// rowData는 colModel이 들어있다. 오브젝트는 이름표:값 , 이름표는 콜모델에 있는 네임을 따라간다.
			var rowData = $("#employeesGrid").jqGrid('getRowData', rowId);
			
			//팝업 열기
			//changeDeptEmpPopup을 불러오기 위해 ajax로 controller호출
			$.ajax({
				url: '<c:url value="/dept/chagneDeptInfo.do"/>',
				type : 'post',
				cache : false,
				dataType: 'html',
				
				//컨트롤러에서 리턴시킨 값을 html이란 이름으로 사용
				//내가 보여줄 팝업에 대한 html이 ajax 호출에 대한 응답으로 리턴된다
				success: function(html){
					// 빈 껍데기만 있는 div에 html 덮어 씌우기(.html : html코드를 덮어씌우는 함수)
					$('#dialogMessage').html(html);
//---------------------------------------------------- 여기까지했을 경우 popup창 구조만 생성 완료

					$('#dialogMessage').dialog( { 
						height: 380,
				        width: 450,
				        title: '직원 부서 변경',
				        autoOpen: true,
				        modal: true,
				        resizable: false,
				        autoResize: true,
				        position : { 
				        	'my' : 'top center',
				        	'at' : 'center'
				        },
				        open: function(){
				        	// dialog 화면에 값 표시하기
							$('#dialogMessage input#fullName').val(rowData.fullName);	
				        	$('#dialogMessage input#empNo').val(rowData.empNo);	//.val(매개변수)값을 넣거나 찾을 때 사용, .val()찾을 떄
				        	//div껍대기id 안에 inputId가empNo를 찾는다 .val(클릭한 직원의 empNo)
				        	$('#dialogMessage input#hireDate').val(rowData.hireDate);	
				        	$('#dialogMessage input#deptName').val(rowData.deptName);	
				        	$('#dialogMessage input#prevFromDate').val(rowData.fromDate);	
				      
				        	// 부서선택을 하기 위해 셀렉트 박스 생성_ajax 호출
				        	$.ajax({
								url: '<c:url value="/dept/getSelectBoxData.do" />',
								data : { },	
								success : function (depts, textStatus, XMLHttpRequest) {	
									// depts : controller에서 return 해준 값 = 부서정보 
									console.log(depts);	//첫번째 매개변수 : 컨트롤러에서 리턴시킨값을 확인한다
									//F12 개발자모드 console에 부서정보가 찍혀있다.
								
									var deptEmpSelect = $('#dialogMessage #diagDeptNos');
									var option = $('<option>').attr({'name' : 'deptNo', value : ''}).text("선택하세요")
									
									$(deptEmpSelect).append(option);	//셀렉트박스 맨 위에 출력하기 위해 each문 위해 적어준다.	선택하세요 출력
									
									$.each(depts, function(key, dept){
										// 여러개의 dept가 오브젝트로 묶여서 여러개가 나오는데 그게 depts
										// $('<option>') 로 태그 생성
										// attr : attribute (속성) 지정
										// text 화면에 보여줄 텍스트                                                  컨트롤러에서 리턴한 10개의 값 하나하나가 dept
										option = $('<option>').attr({'deptName' : 'deptNo', 'value' : dept.deptNo}).text(dept.deptName);
										
										$(deptEmpSelect).append(option);	//위에서만든 옵션을 셀렉트태그(deptNos)안에 추가한다.
									});
								},
								error : function (XMLHttpRequest, textStatus, errorThrown) {
									alert('에러 \n'+XMLHttpRequest);
								}
							});	//ajax 끝	
	
				        	// 착임일 datepicker
							$( "#dialogMessage #newFromDate" ).datepicker(
			        			{
			        				defaultDate : "0",
			        				changeMonth : false,
			        				changeYear : true,
			        				dateFormat : "yy-mm-dd",
		        					dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],	//해당 요일의 tooltip에 나타나는 Text
		        			        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],//날짜선택기에 표시하는 요일의 약자를 설정
		        			        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			        				minDate : '0+1'	//내일부터 선택이 가능하도록 제약을 걸어둔다. 오늘0 내일부터+1
			        			}
				        	);
							// 저장_ 저장버튼은 부서변경이라는 버튼을 클릭 후 open되는 dialogPopup창에서 보여진다
							//dialog open: function()에 작성해준다. (이벤트시점에 맞춰서 작성해줘야 된다.)
							$("#dialogMessage button#btnSaveInfo").click(function(){
								//선택한 row의 데이터를 가져온다.
								var rowData = $("#employeesGrid").jqGrid('getRowData', rowId);
								var empNo = $('#dialogMessage input#empNo').val();
								
								//기존부서번호
								var oldDeptNo = rowData.deptNo;
								//기존부서이름
								var oldDeptName = rowData.deptName;
								//기존착임일
								var oldFromDate = rowData.fromDate;

								// 새로운 부서 select-box 부서번호 가져오기_ ":" 속성
								var deptNo = $("#dialogMessage select#diagDeptNos option:selected").val();
								// 새로운 부서 select-box 부서이름 가져오기
								var deptName = $("#dialogMessage select#diagDeptNos option:selected").text();
								//새로운 부서의 착임일
								var fromDate = $('#dialogMessage input#newFromDate').val();
								
								
								if(deptNo==''||deptNo==null){
									alert("부서를 선택해주세요");
									return;
								}
								
								if(fromDate==''){
									alert('착임일을 선택해주세요.');
									return;
								}
								
								if(oldDeptNo==deptNo){
									alert("기존부서와 변경 될 부서가 동일합니다. 변경 될 부서를 확인해주세요.")
									return;								
								}else{
									//기존부서와 변경될 부서가 다를 시 데이터 저장
									$.ajax({
										url : '<c:url value="/dept/updateDeptEmp.do" />',	//이 데이터를 받아 줄 컨트롤러의 메서드 주소
										data : {
												'empNo':empNo,
											    'deptNo':deptNo,
												'oldDeptNo':oldDeptNo,
												'fromDate':fromDate,
												'oldFromDate':oldFromDate
										},	//파라미터가 들어간다
								    //콜백(비동기방식에서 일이끝나면 실행되는 함수)
									success : function (result, textStatus, XMLHttpRequest) {
									// result : 컨트롤러에서리턴 
									// textStatus : http요청이 제대로 되면 200/ 페이지가 없으면 404. 그런값들이 들어가있다.  
									// XMLHttpRequest : http리퀘스트를 자세히보여주는 오브젝트 // 주로 result만 사용해도 문제는 없다
											
											if(result){								
												alert("기존부서  "+oldDeptName+" 에서 "+ deptName+" 로 변경되었습니다.");
												$('#dialogMessage').dialog('close');
												$("#employeesGrid").trigger("reloadGrid");	//저장 후 그리드만 다시 불러온다
												return;
											}	
										},
										//실패했을 경우 위 success를 안타고 error로 바로온다. 사용자가 작성한 데이터는 화면에 그대로 남아있다.
										error : function (XMLHttpRequest, textStatus, errorThrown) {
											alert('작성 에러 \n'+XMLHttpRequest.responseText);
										}
									});	//저장 ajax끝
									
								}
							});	//저장버튼 끝

							// 닫기_ 닫기버튼은 부서변경이라는 버튼을 클릭 후 open되는 dialogPopup창에서 보여진다
							$("#dialogMessage button#btnClose").click(function(){
								$('#dialogMessage').dialog('close');
							});
				        },
				        overlay: {
				            opacity: 1,
				            background: "black"
				        },
				        close: function(){
				        	
				        	
						}
				    });
				},
				error : function(a, b, c){
					console.log(a);
					console.log(b);
					console.log(c);
				}
			});
		}
	});	// 부서 변경 버튼 끝

	

	
	//연봉 변경 클릭 시작
	$('#btnChngSalaryInfo').click(function(){

		//특정 직원을 클릭 후 부서변경을 하기위해 선택한 row의 id 가져오기
		var rowId = $("#employeesGrid").jqGrid('getGridParam', 'selrow');
		
		//rowId가 없다면 직원을 선택 안한게 된다.
		if(rowId == null || rowId == ''){
			alert('직원을 선택하세요!');
		}
		else{
			// rowId로 row 값 가져오기 >> 자바스크립트에서 return type = Object형으로 반환
			// rowData는 colModel이 들어있다. 오브젝트는 이름표:값 , 이름표는 콜모델에 있는 네임을 따라간다.
			var rowData = $("#employeesGrid").jqGrid('getRowData', rowId);
			
			//팝업 열기
			//changeDeptEmpPopup을 불러오기 위해 ajax로 controller호출
			$.ajax({
				url: '<c:url value="/sala/chagneSalaryInfo.do"/>',
				type : 'post',
				cache : false,
				dataType: 'html',
				
				//컨트롤러에서 리턴시킨 값을 html이란 이름으로 사용
				//내가 보여줄 팝업에 대한 html이 ajax 호출에 대한 응답으로 리턴된다
				success: function(html){
					// 빈 껍데기만 있는 div에 html 덮어 씌우기(.html : html코드를 덮어씌우는 함수)
					$('#dialogSalaries').html(html);
//---------------------------------------------------- 여기까지했을 경우 popup창 구조만 생성 완료

					$('#dialogSalaries').dialog( { 
						height: 400,
				        width: 430,
				        title: '직원 연봉 변경',
				        autoOpen: true,
				        modal: true,
				        resizable: false,
				        autoResize: true,
				        position : { 
				        	'my' : 'top center',
				        	'at' : 'center'
				        },
				        //pupup창이 열리면 실행
				        open: function(){
				        	// dialog 화면에 값 표시하기
							$('#dialogSalaries input#fullName').val(rowData.fullName);	
				        	$('#dialogSalaries input#empNo').val(rowData.empNo);	//.val(매개변수)값을 넣거나 찾을 때 사용, .val()찾을 떄
				        	//div껍대기id 안에 inputId가empNo를 찾는다 .val(클릭한 직원의 empNo)
				        	$('#dialogSalaries input#oldSalary').val(rowData.salary);	
				        	$('#dialogSalaries input#salariesHireDate').val(rowData.hireDate);	
				        	$('#dialogSalaries input#deptName').val(rowData.deptName);	

				        	
/*				        	
							//-------- datepicker에서 minDate설정 (내일부터 선택가능하게)-------------//      
				        	//가져온Date를 String으로 변환-----------------------
				        	//기존착임일 이전은 선택 할 수 없도록 기존FromDate날짜+1 해준다.
				        	var oldFromDate = rowData.sFromDate;
				        	//가져온 fromDate를 - 기준으로 자른다  ex >> (0000, 00, 00)
				        	var oldDateArr = oldFromDate.split('-');
				        	//자른 년,월,일은 배열로 들어간다. 
				        	// 월은 0월부터 시작하기때문에 가져올때 -1해준다.
				        	console.log(oldDateArr[0]+","+ (Number(oldDateArr[1])-1)+","+ oldDateArr[2] )
				        	
				        	//Date에서 String로 변환된 데이터를 수정 후 다시 Date로 변환---------------------------
				        	// 가져온 년,월,일을 Date객체로 변환해준다. //월은 0월부터 시작하기때문에 date객체에 넣어줄 때 -1해준다.
				        	var editOldDate = new Date(oldDateArr[0],(Number(oldDateArr[1])-1),oldDateArr[2]);
				        		//기존착임일포함해서 선택이 안되게 하기 위해 day에 +1을 해준다.
				        		editOldDate.setDate(editOldDate.getDate() +1); 
							console.log("더하기+1날짜        "+editOldDate.getDate())
							
							//변경작업이 끝난 date를 다시 string로 변환해준다.
							//현재 날짜를 보여주기 위해 다시 string로 변환할때는 월에 +1을 해준다(0월부터 시작)
						    var curr_date = editOldDate.getDate();
						    var curr_month = editOldDate.getMonth()+1;
						    var curr_year = editOldDate.getFullYear();
						    oldFromDate = curr_year + "-" + curr_month + "-" + curr_date;
						    console.log("최종fromDate        "+oldFromDate)
**/					
						    
  	
		        			// 키 누르면 (눌렀으면 = keydown)		
						    //e : 버튼을 누르고있으면 생기는 이벤트
						    //keypress를 하면 생기는 모든 이벤트는 e로 들어온다.
		        			$( '#dialogSalaries input#rise').keypress(function(e){
		        			      
		        				//.which : keycode가 있는 곳
		        				//e(이벤트)에 들어온 값들을 .which를 통해 keycode를 뽑아온다.
		        				var key = e.which;	// 누른 key code
		        			     //아래 해당하는 key값만 받고 그 외 key는 return한다.
		        			     //아래 정의된 key 제외하고 나머지 key는 아무리 눌러도 화면에 출력이 안된다. 
		        			     if((key >= 48 && key <= 57) ||  // 숫자열 0 ~ 9 : 48 ~ 57    
		        			           key == 45 ||               // -
		        			           key == 8 ||                // BackSpace
		        			           key == 46 ||               // Delete
		        			           key == 37 ||               // 좌 화살표
		        			           key == 39 ||               // 우 화살표
		        			           key == 35 ||               // End 키
		        			           key == 36 ||               // Home 키
		        			           key == 9 ){                // Tab 키
		        			     // 이런코드가 들어오면 아무것도 해줄게 없다
		        			     //단, 이런코드 외 다른코드가 들어온다면
		        			      }else {
		        			           //return한다.
		        			           return false;
		        			      }      
		        			});
  
				        	 // 키 눌렀다 떼면
				        	 $( '#dialogSalaries input#rise').keyup(function(e){

				        	       //1을 입력 시 1 %가 출력되고, 5를 추가로 입력 시 1 %5가 된다
				        	       // 현재 입력값에서 공백 제거, % 제거 >> if) 1 %5 > 15
				        	       //this는 $( '#dialogMessage input#sa_incRate').val()를 의미
				        	       var oldValue = $(this).val().replace(/\s/g, '').replace(/\%/g, '');
				        	      //결과값	ex)                           3%3                33
				        	       var inRise;
				        	       
				        	       // back space를 눌렀을 경우 숫자맨뒤에 붙어있는 %를 제거하는게아니라 숫자가 제거되야한다.
				        	       if(e.which == 8){	//8은 백스페이스번호
				        	            // if) 15445 >> 1544로 변경되면 된다.
				        	            //     - 스크립트 상에서 마지막 5 한자리를 지워주는 코드는 없다
				        	            //     - 앞에서부터 substr을 통해 마지막숫자를 제외한 나머지를 가져온다. 
				        	            //     - subsrt(시작,어디까지)
				        	            inRise = oldValue.substr(0, oldValue.length - 1);
				        	       }
				        	       else {
				        	            // 숫자만 가지고 있는 값
				        	            inRise = oldValue;
				        	       }
/*
				        	      input박스의 커서는 항상 맨 뒤에 위치한다 
				        	      - 1%에서 5 추가로 입력 시 1%5 > 15% 
				        	      - 5의 위치가 이동된다.  
*/
				        	       if(inRise > 20 || inRise < -20){
				        	            alert('연봉 인상률은 -20% ~ 20% 입니다!');
				        	            $(this).val('');
				        	            $('#dialogSalaries input#rise').val('');
				        	            $('#dialogSalaries input#salary').val('');
				        	            
				        	            return;
				        	       }

					        	      inRise = (inRise == '' || inRise == null)         // if) 5 %에서 백스페이스 누른 경우 rate 값은 빈 string
					        	                  ? ''                 // 화면에 공백 보여주고
					        	                  : inRise + ' %';     // if) 15 %에서 백스페이스 누른 경우 rate 값은 5이므로 % 붙여준다.
					        	                                       // 입력창에 숫자가 1자 이상 있을 경우만 %를 붙여준다.
				        	        
				        	       $(this).val(inRise);
 //----------------------------------------------------------------------------- 여까지하면 화면에 출력은 된다.
				        	       
				        	       // 조정연봉 계산하기 위해 화면에 넣어준 값을 그대로 사용, 공백 제거 % 제거
				        	       inRise = inRise.replace(/\s/g, '').replace(/\%/g, '');
				        	       // 숫자면true
				        	       if(!isNaN(inRise)){
				        	            // [%] 떼고 [,]떼고
				        	            var oldSalary = rowData.salary;
		        	            			oldSalary = Number(oldSalary.replace(/\,/g, ''));
				        	            var newSalary = Math.floor(oldSalary + (oldSalary * (inRise / 100)));
				        	            	$('#dialogSalaries input#salary').val(newSalary.toLocaleString());        
				        														   // 숫자에 자동으로 콤마를 추가해준다.                                
				        	       }
				        	 });

				        	
				        	//조정연봉을 수기입력 시 인상률이 계산되어 자동으로 나타난다.
				        	$('#dialogSalaries input#salary').keyup(function(){
				        	//화면출력을 위한 입력값수정
				        		//조정연봉입력값에서 콤마 제거 한 값을 숫자로 변환하여 가져온다.
				        		//숫자가 길어졌을 경우(입력값: 1,000) 쉼표가 자동으로 추가되기때문에 연산하기위해선 쉼표를 제거해준다
				        		//조정연봉 입력 시 String으로 인식되어 Number로 변환해준다.
				                var aa = Number($(this).val().replace(/\,/g, ""))
				                //조정연봉 입력 값에서 화면에 출력되는 값은 콤마를 추가해준다.
				        		var newSalary = Number(aa).toLocaleString('en');
				        		//내가입력한값에 콤마추가한 값을 넣어준다.
			        			$(this).val(newSalary)
				                	
				        		var oldSalary = rowData.salary;
				        			
			        		//인상률계산을 위한 입력값수정	
			        				// comma제거후기존연봉가져오기, number안해줄시 string으로가져온다
				        			oldSalary = Number(oldSalary.replace(/\,/g,""));	
				        			// comma제거후새로입력한연봉가져오기, 위에 선언했다
			        				newSalary = Number(newSalary.replace(/\,/g,""));	
			        				
			        				//인상률구하는식
				        			var newRise = (newSalary-oldSalary)/oldSalary*100	
				        			newRise = Math.floor(newRise);	//소수점절삭
				        			//인상률에 계산된 값 넣어주기
			        			$('#dialogSalaries input#rise').val(newRise+'%');	
				        	});
	
				        	// 적용일 datepicker
				        	$( "#dialogSalaries #newSaFromDate" ).datepicker(
				       			{	
				       				defaultDate : "0",
				       				changeMonth : true,
				       				changeYear : true,
				       				yearRange : '0:+5',	// 50년 전 부터 현재년도까지, 범위설정
				       				dateFormat : "yy-mm-dd",	//datepicker는 yy두개 , mySQL은 y가 1개
			      					dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],	//해당 요일의 tooltip에 나타나는 Text
			      			        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],//날짜선택기에 표시하는 요일의 약자를 설정
			      			   	    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				       				minDate : '0+1'
				       			}
				        	);
				        	
							// 저장_ 저장버튼은 연봉변경이라는 버튼을 클릭 후 open되는 dialogPopup창에서 보여진다
							//dialog open: function()에 작성해준다. (이벤트시점에 맞춰서 작성해줘야 된다.)
							$("#dialogSalaries button#btnSaveInfo").click(function(){
								//선택한 row의 데이터를 가져온다.
								var rowData = $("#employeesGrid").jqGrid('getRowData', rowId);
								//사원번호가져오기
								var empNo = $('#dialogSalaries input#empNo').val();
								//기존fromData
								var oldFromDate = rowData.salariesFromDate;
								//새로운연봉
								var salary = $('#dialogSalaries input#salary').val();
								    salary = Number(salary.replace(/\,/g,""));
								//연봉인상 적용일
								var newFromDate = $('#dialogSalaries input#newSaFromDate').val();
								//연봉인상율
								var rise = $('#dialogSalaries input#rise').val();
									rise = Number(rise.replace(/\%/g,""));
									
								
									console.log("rise                 "+rise)
								
								//유효성체크
								//인상률이 0% 이하라면
								if(rise <= 0 ){
									alert('조정연봉은 0이하 일 수 없습니다.');
									//인상률과 조정연봉 입력칸을 초기화 시킨다.
									$('#dialogSalaries input#rise').val('');
									$('#dialogSalaries input#salary').val('');
									return;
								}	
																
								//인상률이 20% 이상일경우
								if(rise >= 20){
									alert('조정연봉은 20% 이상 인상 될 수 없습니다.');
									//인상률과 조정연봉 입력칸을 초기화 시킨다.
									$('#dialogSalaries input#rise').val('');
									$('#dialogSalaries input#salary').val('');
									return;
								}
								
								if(salary=='' || newFromDate==''){
									alert('공백없이 입력해주세요.');
									return;
								}else{
									//모든데이터가 정상적으로 입력이 되었을 시 저장
									$.ajax({
										url : '<c:url value="/sala/updateSalaries.do" />',	//이 데이터를 받아 줄 컨트롤러의 메서드 주소
										data : {
											'empNo':empNo,
										    'oldFromDate':oldFromDate,
											'fromDate':newFromDate,
											'salary':salary
										},	//파라미터가 들어간다
								    //콜백(비동기방식에서 일이끝나면 실행되는 함수)
									success : function (result, textStatus, XMLHttpRequest) {
									// result : 컨트롤러에서리턴 
									// textStatus : http요청이 제대로 되면 200/ 페이지가 없으면 404. 그런값들이 들어가있다.  
									// XMLHttpRequest : http리퀘스트를 자세히보여주는 오브젝트 // 주로 result만 사용해도 문제는 없다
											
											if(result){								
												alert("연봉이 조정되었습니다");
												$('#dialogSalaries').dialog('close');
												$("#employeesGrid").trigger("reloadGrid");	//저장 후 그리드만 다시 불러온다
												return;
											}	
										},
										//실패했을 경우 위 success를 안타고 error로 바로온다. 사용자가 작성한 데이터는 화면에 그대로 남아있다.
										error : function (XMLHttpRequest, textStatus, errorThrown) {
											alert('작성 에러 \n'+XMLHttpRequest.responseText);
										}
									});	//저장 ajax끝
								}	
							});	//저장버튼 끝

							// 닫기_ 닫기버튼은 부서변경이라는 버튼을 클릭 후 open되는 dialogPopup창에서 보여진다
							$("#dialogSalaries button#btnClose").click(function(){
								$('#dialogSalaries').dialog('close');
							});
				        },
				        overlay: {
				            opacity: 1,
				            background: "black"
				        },
				        close: function(){
				        	
				        	
						}
				    });
				},
				error : function(a, b, c){
					console.log(a);
					console.log(b);
					console.log(c);
				}
			});
		}
	});	// 연봉 변경 버튼 끝

	
	
	
	
	
	
	
	
	//직함 변경 클릭 시작
	$('#btnChngTitlesInfo').click(function(){

		//특정 직원을 클릭 후 부서변경을 하기위해 선택한 row의 id 가져오기
		var rowId = $("#employeesGrid").jqGrid('getGridParam', 'selrow');
		
		//rowId가 없다면 직원을 선택 안한게 된다.
		if(rowId == null || rowId == ''){
			alert('직원을 선택하세요!');
		}
		else{
			// rowId로 row 값 가져오기 >> 자바스크립트에서 return type = Object형으로 반환
			// rowData는 colModel이 들어있다. 오브젝트는 이름표:값 , 이름표는 콜모델에 있는 네임을 따라간다.
			var rowData = $("#employeesGrid").jqGrid('getRowData', rowId);
			
			//팝업 열기
			//changeTitlesPopup을 불러오기 위해 ajax로 controller호출
			$.ajax({
				url: '<c:url value="/title/chagneTitleInfo.do"/>',
				type : 'post',
				cache : false,
				dataType: 'html',
				
				//컨트롤러에서 리턴시킨 값을 html이란 이름으로 사용
				//내가 보여줄 팝업에 대한 html이 ajax 호출에 대한 응답으로 리턴된다
				success: function(html){
					// 빈 껍데기만 있는 div에 html 덮어 씌우기(.html : html코드를 덮어씌우는 함수)
					$('#dialogTitles').html(html);
//---------------------------------------------------- 여기까지했을 경우 popup창 구조만 생성 완료

					$('#dialogTitles').dialog( { 
						height: 350,
				        width: 400,
				        title: '직원 직함 변경',
				        autoOpen: true,
				        modal: true,
				        resizable: false,
				        autoResize: true,
				        position : { 
				        	'my' : 'top center',
				        	'at' : 'center'
				        },
				        open: function(){
				        	// dialog 화면에 값 표시하기
							$('#dialogTitles input#fullName').val(rowData.fullName);	
				        	$('#dialogTitles input#empNo').val(rowData.empNo);	//.val(매개변수)값을 넣거나 찾을 때 사용, .val()찾을 떄
				        	//div껍대기id 안에 inputId가empNo를 찾는다 .val(클릭한 직원의 empNo)
				        	$('#dialogTitles input#hireDate').val(rowData.hireDate);	
				        	$('#dialogTitles input#oldTitle').val(rowData.title);	
				      
				        	
				        	// 적용일 datepicker
							$( "#dialogTitles #newTiFromDate" ).datepicker(
			        			{
			        				defaultDate : "0",
			        				yearRange : '-50:+0',
			        				changeMonth : false,
			        				changeYear : true,
			        				dateFormat : "yy-mm-dd",
		        					dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],	//해당 요일의 tooltip에 나타나는 Text
		        			        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],//날짜선택기에 표시하는 요일의 약자를 설정
		        			        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			        				minDate : '0+1'
		        					//새로운착임일을 설정할 때 기존착임일+1 부터 선택 가능하도록 하는 코드
		        					//new Date(Date.parse(rowData.titlesFromDate) + 1 * 1000 * 60 * 60 * 24).toISOString().slice(0,10)
			        			}
			        			
			        			
				        	);
							// 저장_ 저장버튼은 부서변경이라는 버튼을 클릭 후 open되는 dialogPopup창에서 보여진다
							//dialog open: function()에 작성해준다. (이벤트시점에 맞춰서 작성해줘야 된다.)
							$("#dialogTitles button#btnSaveInfo").click(function(){
								//선택한 row의 데이터를 가져온다.
								var rowData = $("#employeesGrid").jqGrid('getRowData', rowId);
								var empNo = rowData.empNo;
								var oldTitle = rowData.title;
								var oldFromDate = rowData.titlesFromDate;
								
								var title =  $("#dialogTitles input#title").val();
								var fromDate = $('#dialogTitles input#newTiFromDate').val();
								
								
				        	
								
								if ( oldTitle == title){
									alert("변경될 직함은 기존직함과 동일합니다.");
									return;
								}
								
								if( title.length > 50 ){
									alert("직함은 50자를 초과 할 수 없습니다.");
									$("#dialogTitles input#title").val('')
									return;
								}
								if(title == '' || fromDate==''){
									alert("모든 항목을 입력해주세요.")
									return;
								}
									//기존부서와 변경될 부서가 다를 시 데이터 저장
									$.ajax({
										url : '<c:url value="/title/updateTitles.do" />',	//이 데이터를 받아 줄 컨트롤러의 메서드 주소
										data : {
												'empNo':empNo,
												'fromDate':fromDate,
												'oldFromDate':oldFromDate,
												'oldTitle':oldTitle,
												'title':title,
										},	//파라미터가 들어간다
								    //콜백(비동기방식에서 일이끝나면 실행되는 함수)
									success : function (result, textStatus, XMLHttpRequest) {
									// result : 컨트롤러에서리턴 
									// textStatus : http요청이 제대로 되면 200/ 페이지가 없으면 404. 그런값들이 들어가있다.  
									// XMLHttpRequest : http리퀘스트를 자세히보여주는 오브젝트 // 주로 result만 사용해도 문제는 없다
											
											if(result){								
												alert("기존직함  "+oldTitle+" 에서 "+ title+" 로 변경되었습니다.");
												$('#dialogTitles').dialog('close');
												$("#employeesGrid").trigger("reloadGrid");	//저장 후 그리드만 다시 불러온다
												return;
											}	
										},
										//실패했을 경우 위 success를 안타고 error로 바로온다. 사용자가 작성한 데이터는 화면에 그대로 남아있다.
										error : function (XMLHttpRequest, textStatus, errorThrown) {
											alert('작성 에러 \n'+XMLHttpRequest.responseText);
										}
									});	//저장 ajax끝
							});	//저장버튼 끝

							// 닫기_ 닫기버튼은 부서변경이라는 버튼을 클릭 후 open되는 dialogPopup창에서 보여진다
							$("#dialogTitles button#btnClose").click(function(){
								$('#dialogTitles').dialog('close');
							});
				        },
				        overlay: {
				            opacity: 1,
				            background: "black"
				        },
				        close: function(){
				        	
				        	
						}
				    });
				},
				error : function(a, b, c){
					console.log(a);
					console.log(b);
					console.log(c);
				}
			});
		}
	});	// 직함 변경 버튼 끝

	
	

	

	//삭제
	$('#btnDelEmp').click(function(){
		//선택한 row의 id가져오기
		//json에 rowId가 empNo로 되어있어서 empNo가 반환된다.
		var empNo = $('#employeesGrid').jqGrid('getGridParam', 'selrow');
		var data = $('#employeesGrid').jqGrid('getRowData', empNo);                                           
		var empName = data.fullName;
		if(empNo==null || empNo==''){
			alert("삭제할사람을선택하세요.")
		}else{
	           // 삭제 다이얼로그
	           var div = $('<div>').attr({id : 'dialog-confirm', title : '직원 삭제'})
	           var p = $('<p>').append('<span style="float:left; margin:12px 12px 20px 0;">').text("정말 삭제하시겠습니까?");
	           $(div).append(p);
	           // 사용자 확인 dialog
	           $(div).dialog({
	                 resizable: false,
	                 height: "auto",
	                 width: 400,
	                 modal: true,
	                 buttons: {
	                      "삭제": function() {
								$.ajax({
									url : '<c:url value="/emp/deleteEmployees.do" />',	//이 데이터를 받아 줄 컨트롤러의 메서드 주소
									data : {
											'empNo':empNo
									},	//파라미터가 들어간다
							    //콜백(비동기방식에서 일이끝나면 실행되는 함수)
								success : function (result, textStatus, XMLHttpRequest) {
								// result : 컨트롤러에서리턴 
								// textStatus : http요청이 제대로 되면 200/ 페이지가 없으면 404. 그런값들이 들어가있다.  
								// XMLHttpRequest : http리퀘스트를 자세히보여주는 오브젝트 // 주로 result만 사용해도 문제는 없다
										
										if(result){								
											alert(empNo+" "+empName+"님의 정보가 삭제되었습니다.");
											$(div).dialog('close');
											$("#employeesGrid").trigger("reloadGrid");	//저장 후 그리드만 다시 불러온다
											return;
										}	
									},
									//실패했을 경우 위 success를 안타고 error로 바로온다. 사용자가 작성한 데이터는 화면에 그대로 남아있다.
									error : function (XMLHttpRequest, textStatus, errorThrown) {
										alert('작성 에러 \n'+XMLHttpRequest.responseText);
									}
								});	//저장 ajax끝
	                      },
	                      "취소": function() {
	                            $( this ).dialog( "close" );
	                      }
	                 }
				});	//삭제dialog끝
		}
	});	//삭제버튼끝
	
});	//ready끝


	
	
	
	// 저장
	function btnSaveInfo(){	//ready안에 function을 정의할수 없기때문에 ready밖으로 뺀다.
		
		// 유효성 검사 필수!
		var lastName = $('#lastName').val();
		if(lastName.length == 0){ 	// 입력 했는지
			alert("이름을 입력하세요.");
			return;
		}
		if(lastName.length > 16){	// 컬럼 데이터 타입에 맞는지
			alert('영문기준 최대 16자 입력 가능합니다. 확인 후 다시 입력하세요.')
			return;
		}
		
		var firstName = $('#firstName').val();
		if(firstName.length == 0){ 	// 입력 했는지
			alert("이름을 입력하세요.");
			return;
		}
		if(firstName.length > 14){	// 컬럼 데이터 타입에 맞는지
			alert('영문기준 최대 14자 입력 가능합니다. 확인 후 다시 입력하세요.')
			return;
		}
		
		var gender = $('#gender option:selected').val();
		if(gender==''){
			alert('성별을 입력하세요');
			return;
		}
		
		var birthDate = $('#birthDate').val();
		if(birthDate.length == 0){ 	// 입력 했는지
			alert("생년월일을 선택하세요.");
			return;
		}
		
		var hireDate = $('#hireDate').val();
		if(hireDate.length == 0){ 	// 입력 했는지
			alert("입사일을 선택하세요.");
			return;
		}
		
		var diagDeptNos = $('#diagDeptNos option:selected').val();
		if(diagDeptNos==''){ 	// 입력 했는지
			alert("부서를 선택하세요.");
			return;
		}
		
		var title = $('#emplTitle').val();
		if(title.length == 0){ 	// 입력 했는지
			alert("이름을 입력하세요.");
			return;
		}
		if(title.length > 50){	// 컬럼 데이터 타입에 맞는지
			alert('영문기준 최대 50자 입력 가능')
			return;
		}
		
		var fromDate = $('#fromDate').val();
		if(fromDate.length == 0){ 	// 입력 했는지
			alert("착임일을 선택하세요.");
			return;
		}
		
		var salary = $('#emplSalary').val();
		if(salary.length == 0){ 	// 입력 했는지
			alert("연봉을 입력하세요.");
			return;
		}
		if(salary.length > 11){ 	// 입력 했는지
			alert("11자 미만으로 입력");
			return;
		}
		if(salary > 2100000000){
			alert("연봉은 Max 21억입니다.");
			$('#emplSalary').val('');
			$('#emplSalary').focus();
			return;
		}
		
		//파일이없이 데이터만 넘길때엔 아래방식을사용하지않아도 되지만 파일을 같이 넘길때엔 아래 방식으로 작성한다
		//파일을 전송할땐 아래방식으로 코딩해야 파일이 제대로 넘어간다.
		$.ajax({
			url : '<c:url value="/emp/addEmpInfo.do" />',	//이 데이터를 받아 줄 컨트롤러의 메서드 주소
			data : {
					lastName:lastName,
					firstName:firstName,
					gender:gender,
					birthDate:birthDate,
					hireDate:hireDate,
					deptNo:diagDeptNos,
					title:title,
					fromDate:fromDate,
					salary:salary
					},	//파라미터가 들어간다
			type: 'POST',
	    //콜백(비동기방식에서 일이끝나면 실행되는 함수)
		success : function (result, textStatus, XMLHttpRequest) {
		// result : 컨트롤러에서리턴 
		// textStatus : http요청이 제대로 되면 200/ 페이지가 없으면 404. 그런값들이 들어가있다.  
		// XMLHttpRequest : http리퀘스트를 자세히보여주는 오브젝트 // 주로 result만 사용해도 문제는 없다
	
				// 컨트롤러에서 return 한 값 중 resultCode 가 1이면, 즉 작성했다면 
				if(result){	//자바스크립트는 0이 아니면 true다.
					alert('직원추가 성공');
					
					$("#employeesGrid").trigger("reloadGrid");	//저장 후 그리드만 다시 불러온다
					jQuery('#dialogPopUp').dialog('close');	//저장버튼 클릭 시 dialog팝업창이 닫힌다.
					return;
				}
			},
	//실패했을 경우 위 success를 안타고 error로 바로온다. 사용자가 작성한 데이터는 화면에 그대로 남아있다.
			error : function (XMLHttpRequest, textStatus, errorThrown) {
				alert('작성 에러 \n'+XMLHttpRequest.responseText);
			}
		});	//저장 ajax끝						
	};
	
	
	

	// dalogPop창 닫기버튼 클릭 시 
	function btnClose(){
		$('#dialogPopUp').dialog('close');	//dialogPop창 닫기 실행
	}

	
	
	
	//연봉 입력 시 숫자가 아닌 다른 데이터가 들어가면 자동으로 지워진다.
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}

	

	//#셀렉트박스	이런형식으로 이벤트를 처리할거면 html button에 onClick을 지운다. (온클릭을 먼저 이벤트 인식을 할 수 있기때문) 
	function search(){	//버튼클릭시 이동제이쿼리를통해 버튼을 찾아와 스크립트쪽에서 이벤트를 걸어 줄 수 있다
		var deptNo = $('#deptNos option:selected').val();	//id가 deptNos 하위에 있는 option태그의 selected(선택되어있는)속성을 찾는다.
	//					셀렉트(아래에서지정) 옵션10개중:선택되어있는 .val(값가져오기, 부서번호)
		var fullName = $('#fullName').val();
		$("#employeesGrid").jqGrid('setGridParam', {
		     postData: { 
				'deptNo' : deptNo,	//이름표  :  값 (위에 설정된 var deptNo)
			 	'fullName' : fullName
		     }}
		).trigger("reloadGrid");
	//reload할 때 employeesGrid에 설정된 url을 다시 불러온다. url에 타고 넘어갈 때 위에 설정한 postData를 파라미터에 넣어서 같이 넘긴다
	};


</script>
<title>Insert title here</title>
</head>
<body>
<div id="tabs">	<%--#페이지이동3 --%>
  <ul>
    <li><a href="#tabs-1">직원정보</a></li>
  </ul>
  <div id="tabs-1">
    <p class="page_desc">
	</p>
	<fieldset>
		<legend>검색</legend>
		<label>부서 : </label>
		<select id="deptNos" name="deptNos"></select>
		&nbsp;&nbsp;
		<label for="name">이름 : </label>
		    <input type="text" name="fullName" id="fullName" size="20" maxlength="20" />
		<button type="button" id="btnSearch" >조회</button>
	</fieldset>	
	<br/>
	<div align="right" style="margin-bottom:10px;">
		<%--온클릭이 없을 경우 스크립트쪽에서 이벤트 정의가 되어 있어야  이벤트가 실행된다--%>
		<button type="button" id="btnChngDeptInfo">부서변경</button>	<%--id로 정의한 클릭이벤트는 ready영역에 --%>
		<button type="button" id="btnChngTitlesInfo">직함변경</button>	<%--id로 정의한 클릭이벤트는 ready영역에 --%>
		<button type="button" id="btnChngSalaryInfo">연봉변경</button>	<%--id로 정의한 클릭이벤트는 ready영역에 --%>
		<button type="button" id="btnAddEmpInfo">직원추가</button>
		<button type="button" id="btnDelEmp">직원삭제</button>		<%--1. 버튼 클릭 시 (요구사항따라갓을경우 순서) --%>
	</div>
		<table id="employeesGrid"></table>
		<div id="employeesGrid-pager"></div>
  </div>
</div>
<!-- End of code related to code tabs -->

<%--컨트롤러에서 응답 받은 html을 출력해줄 div(빈 도화지, 이곳에 뿌려준다.) --%>
<div id="dialogMessage"></div>
<div id="dialogSalaries"></div>
<div id="dialogTitles"></div>

<%-- 직원추가 버튼을 클릭 시 보여야 될 팝업창  누르기전엔 숨겨놓기 위해 ↓ 속성지정 --%>
<div id="dialogPopUp" style="display: none;">	<%--버튼을 클릭했을 때만 출력되게 하기 위해서 디스플레이를 none으로 감춰놨다. 안할 시 그리드 아래에 출력된다. --%>
	<fieldset style="display: inline-block;">
	    <legend>정보</legend>
		<table>
			<tr>
				<td>성</td>
				<td>
				    <input type="text" name="lastName" id="lastName" size="20" maxlength="20" />
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>
				    <input type="text" name="firstName" id="firstName" size="20" maxlength="20" />
				</td>
			</tr>
			<tr>
				<td>성별</td>		<%-- 코드성이지만 두개밖에없기때문에 그냥 html에 코딩한다(변경될 가능성이 없기때문에) --%>
				<td>
					<select id="gender" name="gender">
						<option value="">남/여</option>
						<option value="M">남</option>
						<option value="F">여</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td>
				    <input type="text" name="birthDate" id="birthDate" size="14" maxlength="10" />
				</td>
			</tr>
			<tr>
				<td>입사일</td>
				<td>
				    <input type="text" name="hireDate" id="hireDate" size="14" maxlength="10" />
				</td>
			</tr>
			<tr>
				<td>부서</td>		<%-- 코드성테이블이지만 값이 변경될 가능성이 있기때문에 select만 구성하고 ajax로 불러온다--%>
				<td>
				    <select id="diagDeptNos"></select>
				</td>
			</tr>
			<tr>
				<td>직함</td>
				<td>
				    <input type="text" name="emplTitle" id="emplTitle" size="14" maxlength="40" />
				</td>
			</tr>
			<tr>
				<td>착임일</td>
				<td>
				    <input type="text" name="fromDate" id="fromDate" size="14" maxlength="10" />
				</td>
			</tr>
			<tr>
				<td>연봉</td>
				<td>
				    <input type="text" name="emplSalary" id="emplSalary" size="14" maxlength="11" onkeydown="onlyNumber(this)"/>
				</td>
			</tr>
		</table>
		<%--dialogPopup창에 데이터 입력 후 닫기 누르고 다시 입력창을 열었을 경우 데이터삭제가 안되서 close function에 최초 ready상태의 html을 덮어씌워놨기때문에  
		    onclick추가 후 스크립트에서 정의해줘야된다. (jquery에선 안됨) --%>
		<button type="button" id="btnSaveInfo" onclick="btnSaveInfo()">저장</button>
		<button type="button" id="btnClose" onclick="btnClose()">닫기</button>		
	</fieldset>
</div>
</body>
</html>