<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" /><!-- mvc:resource를 찾아간다. -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/jqgrid/css/ui.jqgrid.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/css/common.css" />" />
<style>
#diagDeptNos,#gender { width:100%;}

</style>
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script> <!-- c:url 자동으로 컨테스트루트 를 불러온다. -->
<script type="text/javascript" src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/jquery.jqGrid.src.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqgrid/js/i18n/grid.locale-kr.js" />"></script> <!-- 한글번역 -->
<script type="text/javascript" src="<c:url value="/resources/common/js/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery.number.js" />"></script>
<script type="text/javascript">

/* 전체부서 회원정보조회 */
$(document).ready(function(){
	
	// [List] jqGrid
	var empGrid = jQuery("#empGrid").jqGrid({ // jQuery == $
		url : '/WebPortfolio/emp/list.do', //grid:컨텍스트루트
		mtype: "POST",
	    data : {}, //파라미터들어가는곳(name:value)
	    datatype: "json", //데이터타입:제이슨
	    colNames: ['hidden','hidden','hidden',"사원번호", "성명", "성별", "나이", "입사일", "근무부서",'직함', "착임일", "연봉"], //th태그
	    colModel: [
	    		   { name: "deptNo", index:'deptNo', hidden:true },
	    		   { name: "SfromDate", index:'SfromDate', hidden:true },
	    		   { name: "TitlesfromDate", index:'TfromDate', hidden:true },
	    		   { name: "empNo", index:'empNo', width: 80, align:'center' },
	               { name: "fullName", index:'fullName', width: 150, align:'center' },
	               { name: "gender", index:'gender', width: 50, align:'center' },
	               { name: "birthDate", index:'birthDate', width: 50, align:'center' },
	               { name: "hireDate", index:'hireDate', width: 110, align:'center' },
	               { name: "deptName", index:'deptName', width: 150, align:'center' },
	               { name: "title", index:'title', width: 150, align:'center' },
	               { name: "fromDate", index:'fromDate', width: 110, align:'center' },
	               { name: "salary", index:'salary', width: 90, align:'center', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalSeparator:".", decimalPlaces:0} }
	    ],//배열안 오브젝트형식 
	    jsonReader : { //중괄호이기때문에 오브젝트 를 받는다. 대괄호:배열  중괄호:오브젝트 , 찾아간다.
          	root: "rows", //제이슨페이지에 설정한 메소드들  (JsonResponse.java)
          	page: "page", //page 는 page영역을 찾아간다(제이슨페이지에있는)
          	total: "total",
          	records: "records",
          	repeatitems: false,
          	cell: "cell",
          	id: "empNo"
      	},
	    autowidth: false,
	    width:500,
	    height: 480,
	    rowNum: 20,
	    rownumbers: false, //true:숫자가붙여서나온다.
	    sortname: "empNo", //기본정렬 dept_name, dept_no 중
	    sortorder: "desc", //오름차순
	    scrollrows : true,
	    viewrecords: true,
	    gridview: true,
	    autoencode: true,
	    pager: '#empGrid-pager',
	    altRows: true,
	    caption: "사원 정보",
	    loadComplete : function() {
	    	// 크기 조정
	    	gridResize('empGrid');	
		},
		onCellSelect: function (rowId, colIdx, value) {
		},
		onSelectRow: function(rowId){
			
			var rowData = $(this).jqGrid("getRowData",rowId);
			return;
        }
	});
	// }List 끝
	
	// [List] navButtons
	jQuery(empGrid).jqGrid('navGrid', "#empGrid-pager",
		{ 	//navbar options
			edit: false,
			add: false,
			del: false,
			search: false,
			refresh: true,
			view: false
		}
	);
	
	// [List] Tab 나타내기
	$("#tabs").tabs();
	
	
	///////////////////////////////////////////////////////////////////////////////////////////// List 
	
	
	// [검색] 부서 셀렉트 박스 생성을 위한 ajax 호출
	$.ajax({
		url: '<c:url value="/dept/getSelectBoxData.do" />',
		data : { },
		success : function (depts, textStatus, XMLHttpRequest) {
			// depts : controller에서 return 해준 값 = 부서정보 
			
			var select = $('#deptNos');
			var option = null;
			option = $('<option>').attr({'name' : 'deptNo', 'value' :  ''}).text("제목");
			// <option name="deptNo" vlaue="">선택하세요</option>
			//.attr(속성값추가)
			
			$(select).append(option);
			//each문 밖에 append 하면 for문이 돌지 않아(계속적용이 안되고) 처음 한번만 작성되게된다.
			
			$.each(depts, function(key, dept){
				//depts를 반복한다(list) key는 list안에 갯수만큼 반복한다. dept는 선택된것 즉 depts의값
				//key:반복횟수 / dept:대상
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
	
	// [검색] 검색버튼
	$('#btnSearch').click(function(){
		var deptNo = $('#deptNos option:selected').val(); //부서번호값을가져온다
		var Name = $('#name').val(); //입력한 이름 값을 가져온다.
		$("#empGrid").jqGrid('setGridParam', {
		     postData: { 
				deptNo : deptNo,
				Name : Name
			 }, 
			 page : 1 }
		).trigger("reloadGrid");
	});
	
	
	///////////////////////////////////////////////////////////////////////////////////////////// search
	
	
	//처음 document.ready를 할때 처음 새값인 html코드를 제이쿼리로 저장해놓는다 변수로
	//그리고 .dialog 가 close할때 다시 새값으로 만들어줘서 다시 추가버튼 눌러도 기존값이 나오지않게한다.
	var newpopup = $('#dialogPopUp').html();
	
	// datepicker 언어 설정
	$.datepicker.setDefaults( $.datepicker.regional['ko'] );
	
	// [직원추가] 직원추가 버튼
	$('#btnAddEmpInfo').click(function(){
		
		var divHeight = 320;
		var divWidth = 400;
		
		//.dialog(다이알로그로 보여주는 function)
		$("#dialogPopUp").dialog( { 
			height: divHeight,
	        width: divWidth,
	        title: "신규 직원 입력",
	        autoOpen: true, //false로 변경시 open되지 않음
	        modal: true,
	        resizable: false,
	        autoResize: true,
	        position : ['center',100],
	    
	        // 열리면 실행되는일
	        open: function(){
	        	
	        	 // [직원추가 부서 셀렉트 박스] 생성을 위한 ajax 호출
	        	$.ajax({
	        		url: '<c:url value="/dept/getSelectBoxData.do" />',
	        		data : { },
	        		success : function (depts, textStatus, XMLHttpRequest) {
	        			// depts : controller에서 return 해준 값 = 부서정보 
	        			var dialogSelect = $('#diagDeptNos');
	        			var option = $('<option>').attr({'name' : 'deptNo', 'value' : ''}).text("선택하세요");
	        			$(dialogSelect).append(option);
	        			
	        			$.each(depts, function(key, dept){ //가져온 부서정보 값에서(depts) 에서 이벤트(function) 를한다 map 형태의 집합을 다루게 되면 key와 value의 쌍으로 동작합니다.

	        				// $('<option>') 로 태그 생성
	        				// attr : attribute (속성) 지정
	        				// text 화면에 보여줄 텍스트 
	        				option = $('<option>').attr({'name' : 'deptNo', 'value' : dept.deptNo}).text(dept.deptName);
	        				// <option name="deptNo" value="d001"> Finance </option> 
	        				// value 값 dept.deptNo인 이유?
	        				// function(key, dept) 에서 부서정보(depts) 의 value값(dept) 중 {#depnNo} 를 가져오겠다  "dept.deptNo"  
	        				// key 는 dept_no?
	        				$(dialogSelect).append(option);
	        			});
	        		},
	        		error : function (XMLHttpRequest, textStatus, errorThrown) {
	        			alert('에러 \n'+XMLHttpRequest);
	        		}
	        	});
				// ajax 끝
	        	 
	        	// 생년월일 , .datepicker(달력플러그인)
	        	$( "#birthDate" ).datepicker(
	        			{
	        				defaultDate : "+1w",
	        				changeMonth : true,
	        				changeYear : true,
	        				maxDate : '0', //현재날짜이후는선택이되지않음(일)
	        				yearRange : '-50:+0',	// 50년 전 부터 현재
	        				dateFormat : "yy-mm-dd",
	        				onClose:function(selectedDate){ //datepicker 닫힐때
	        					//selectedDate : 선택된값, 즉 날짜를 착임일 datepicker 최소값으로 ..
	        					
	        					//착임일데이터피커가열리고 실행되는 코드
	        					$("#hireDate").datepicker("option","minDate",selectedDate);
	        				}
	        			}
	        	);
	        	// 입사일
	        	$( "#hireDate" ).datepicker(
	        			{
	        				//defaultDate : "+1w",
	        				changeMonth : true,
	        				changeYear : true,
	        				//maxDate : '0', //0일때는 오늘 이후 년도 는 선택이 안됨
	        				yearRange : '-50:+0',	// 20년 전 부터 현재
	        				dateFormat : "yy-mm-dd",
	        				//입사일 선택후 착임일 에서 입사일 부터 입시일 이후 날짜만 선택가능하게 수정(착임일 에서 입사일 불러오기)
	        				onClose:function(selectedDate){ //datepicker 닫힐때
	        					//selectedDate : 선택된값, 즉 날짜를 착임일 datepicker 최소값으로 ..
	        					
	        					//착임일데이터피커가열리고 실행되는 코드
	        					$("#fromDate").datepicker("option","minDate",selectedDate);
	        				}
	        			}
	        	);
	        	// 착임일
	        	$( "#fromDate" ).datepicker(
	        			{
	        				defaultDate : "+1w",
	        				changeMonth : true,
	        				changeYear : true,
	        				dateFormat : "yy-mm-dd"
	        			}
	        	);
	        	
	        	
	        	/* //연봉입력
	    		$("#salary").keyup(function(a){
	    			
	    			
	    			
	    			var salary = Number($('#dialogPopUp input#salary').val());
	    			
	    			
	    			// 유효성
	    			//숫자입력 - 자동으로 콤마생성 - 콤마가들어간값 적용됨 - 숫자더입력안됨
	    			
	    			
	    			
	    			if(!/^[0-9.]*$/.test(salary)){
	    				alert("숫자만 입력 가능합니다.");
	    				$('#dialogPopUp input#salary').val(null);
	    			}else{
	    				//var newSalary = Number($('#dialogPopUp input#salary').val())
	    				$('#dialogPopUp input#salary').val(salary.toLocaleString());
	    				if(!/^[0-9,]*$/.test(salary)) {
	    					
	    					$('#dialogPopUp input#salary').val(l);
	    				}
	    				
	    				
	    			}
	    			
	    			
	    		});  */
	    		
	    		/* $('#deptForm').on("keypress keyup blur", 'salary', function (e) {

	    	        $(this).val($(this).val().replace(/[^0-9\.]/g,''));

	    	        if ((e.which != 46 || $(this).val().indexOf('.') != -1) && (e.which < 48 || e.which > 57)) {

	    	            e.preventDefault();

	    	        }

	    		}); */
	    		
	        	$("#salary").number(true);
	        	
	        	
	        },
	        
	        overlay: {
	            opacity: 0.5,
	            background: "black"
	        },
	        close: function(){
 	        	//닫힐때 마다 새로운 html코드값을 가져온다.
	        	$('#dialogPopUp').html(newpopup);
	        	
			}
	    }).width(divWidth-8).height(divHeight); //-8 : padding값
	});
	// }직원추가 끝
	
	// [직원추가] 저장버튼
 	$('#btnSaveInfo').click(function(){
		
		//alert('유효성 검사 / ajax 호출 구현하세요');
		//유효성검사 모든필드 not null
		
		var lastName = $('#lastName').val();
		var firstName = $('#firstName').val();
		var gender = $('#gender option:selected').val();
		var birthDate = $('#birthDate').val();
		var hireDate = $('#hireDate').val();
		var deptNo = $('#diagDeptNos option:selected').val();
		var fromDate = $('#fromDate').val();
		var salary = $('#salary').val();
		var title = $('#title').val();
		
		
		if(lastName == ''){
			alert('성을 입력하세요.');
			return;
		}
		else if(lastName.length > 17){
			alert('성은 16자 내로 입력하세요.');
			return;
		}
		
		if(firstName == ''){
			alert('이름을 입력하세요.');
			return;
		}
		else if(firstName.length > 15){
			alert('이름은 14자 내로 입력하세요.');
			return;
		}
		
		if(gender == ''){
			alert('성별을 입력하세요.');
			return;
		}
		
		if(birthDate == ''){
			alert('생년월일을 입력하세요.');
			return;
		}
		
		if(hireDate == ''){
			alert('착임일을 입력하세요.');
			return;
		}
		
		if(deptNo == ''){
			alert('부서를 입력하세요.');
			return;
		}
		
		if(fromDate == ''){
			alert('착임일를 입력하세요.');
			return;
		}
		
		if(salary == ''){
			alert('연봉을 입력하세요.');
			return;
		}
		/* else if(/^[0-9.]*$/.test(salary)){
			alert("숫자 만 입력 해주세요.");
			return;
		} */
		
		
		
		
		
		
		
		if(title == ''){
			alert('직함을 입력하세요.');
			return;
		}
		else if(title.length > 20){
			alert('직함은 20자 내로 입력하세요.');
			return;
		}
		
		// 유효성 검사 끝, 저장
		$.ajax({
			url : '<c:url value="/emp/addEmpInfo.do" />',
			data: { 
		    	'lastName' : lastName,
		    	'firstName' : firstName,
		    	'gender' : gender,
		    	'birthDate' : birthDate,
		    	'hireDate' : hireDate,
		    	'deptNo' : deptNo,
		    	'fromDate' : fromDate, //dept_emp,salary,title,dept_manager 와 연결되어있기때문에 from_date값이 들어간다.
		    	'salaries' : salary,
		    	'title':title
	 		},
	 		type: 'POST',
	 		async: false, 
	 		//Ajax 호출이 인터넷 망을 타고 서버로 전달되는데, 반드시 첫번째 호출한 것이 두번째 호출한 것보다 먼저 도착한다고 장담할 수 없습니다.
	 		//비동기 방식이므로 ajax의 결과를 기다리지 않고, 바로 하단의 코드가 실행되어 현재의 페이지가 다음 메인 페이지로 이동해버리기 때문입니다.
			//async 는 비동기방식을 사용하지않겠다(동기방식) 는 의미이다.
	 		success: function(data) {	 
	 			alert("정보가 입력 되었습니다.");
		        $('#dialogPopUp').dialog('close');
		        $("#empGrid").trigger("reloadGrid");
		        
	  		},
			error: function(a, b, c){
				alert("입력실패");
				console.log(a);
				console.log(b);
				console.log(c);
			}
		});
		// 저장 끝	
	});
	//저장버튼 끝
	
	
	///////////////////////////////////////////////////////////////////////////////////////////// employees add
	
	
	// [부서 변경]  부서변경 버튼
	$('#btnChngDeptInfo').click(function(){
		// 선택한 row의 id 가져오기
		// 그리드에서 하나의 셀을 누르고 그줄의 데이터를 가져와야하므로(rowid)
		var rowId = $("#empGrid").jqGrid('getGridParam', 'selrow');
		console.log("rowId >> "+rowId);
		
		if(rowId == null || rowId == ''){
			alert('직원을 선택하세요!');
		}
		
		else{
			
			// rowId로 row 값 가져오기 : return type = Object
			// 셀 한줄의 값을 가지고있다.
			var rowData = $("#empGrid").jqGrid('getRowData', rowId);
			console.log("rowDate >> "+rowData);
			// 팝업 열기
			$.ajax({//changeDeptEmpPopup.jsp 불러오기위해 ajax호출
				url: '<c:url value="/dept/chagneDeptInfo.do"/>', //컨트롤러 호출1
				type : 'post',
				cache : false,
				dataType: 'html',
				success: function(html){ //컨트롤러에서 리턴한값을(changeDeptEmpPopup.jsp)  변수 html로 쓰겟다는 의미.
					// 빈 껍데기만 있는 div에 html 덮어 씌우기 .html(변수html)
					$('#dialogMessage').html(html);
					
					$('#dialogMessage').dialog( { 
						height: 380,
				        width: 450,
				        title: '직원 부서 변경(발령)',
				        autoOpen: true,
				        modal: true,
				        resizable: false,
				        autoResize: true,
				        position : { 
				        	'my' : 'top center',
				        	'at' : 'center'
				        	
				        },
				        open: function(){
				        	// dialog 화면에 값 표시하기(changeDeptEmpPopup.jsp)
				        	$('#dialogMessage input#empNo').val(rowData.empNo); //.val(값) : 값을 넣어주거나 , /.val()찾아준다. 
				        	// dialogMessage다이얼로그 안 input태그의 아이디가 empNo인것을찾는다.
				        	
				        	$('#dialogMessage input#oldDeptNo').val(rowData.deptNo);
				        	
				        	//입사일,성명,착임일 넣어주기
				        	$('#dialogMessage input#fullName').val(rowData.fullName);
				        	$('#dialogMessage input#hireDate2').val(rowData.hireDate);
							
				        	//prevFromDate (부서변경 jsp : 현 부서 착임일) 에 rowDate 의 fromDate값을 넣어준다.
				        	$('#dialogMessage input#prevFromDate').val(rowData.fromDate);
				        	
				        	
				        	// 부서
				        	$('#dialogMessage input#deptName').val(rowData.deptName);
				        	
				        	// 부서변경
				        	// 셀렉트 박스 생성을 위한 ajax 호출
				        	
				        	// [직원추가 부서 셀렉트 박스] 생성을 위한 ajax 호출 / 발령부서 셀렉트박스
				        	
				        	$.ajax({
				        		url: '<c:url value="/dept/getSelectBoxData.do" />',
				        		data : {},
				        		success : function (depts, textStatus, XMLHttpRequest) {
				        			// depts : controller에서 return 해준 값 = 부서정보 
				        			var dialogSelect = $('#dialogMessage select#diagDeptNos2');
				        			var option = $('<option>').attr({'name' : 'deptNo', 'value' : ''}).text("선택하세요");
				        			$(dialogSelect).append(option);
				        			
				        			$.each(depts, function(key, dept){
				        				// $('<option>') 로 태그 생성
				        				// attr : attribute (속성) 지정
				        				// text 화면에 보여줄 텍스트 
				        				option = $('<option>').attr({'name' : 'deptNo', 'value' : dept.deptNo}).text(dept.deptName);
				        				// <option name="deptNo" value="d001"> Finance </option> 
				        				// function(key, dept)
				        				
				        				$(dialogSelect).append(option);
				        			});
				        		},
				        		error : function (XMLHttpRequest, textStatus, errorThrown) {
				        			alert('에러 \n'+XMLHttpRequest);
				        		}
				        	}); 
				        	// ajax 끝
				        	
				        	// 발령부서 착임일
				        	$( "#newFromDate" ).datepicker(
				        			{
				        				defaultDate : "0+1",
				        				changeMonth : true,
				        				changeYear : true,
				        				dateFormat : "yy-mm-dd",
				        				minDate: new Date(Date.parse(rowData.TitlesfromDate) + 1 * 1000 * 60 * 60 * 24).toISOString().slice(0,10)
				        				
				        			}
				        	);
				        	
				        	
				        	
							// open 태그안에 저장 내용이 있다...?  이 영역에서는 저장버튼이 없으므로 이벤트설정하면 제대로 되지않는다 따라서 changeDeptEmpPopup.jsp 에서 불러온다.
							$("#dialogMessage button#btnSaveInfo").click(function(){
								// 새로운 부서 select-box 값 가져오기
								var deptNo = $("#dialogMessage select#diagDeptNos2 option:selected").val(); //option:selected 옵션에서 선택된값을 가져와라 .val() : value값가져오기
								var oldDeptNo = $("#dialogMessage input#oldDeptNo").val(); //input#oldDeptNo : 부서변경 다이얼로그가 열리면 기존 부서번호 를 oldDeptNo 로 변수선언했다.
								console.log("deptNo"+deptNo);
								console.log("oldDeptNo"+oldDeptNo);
								
								// 발령부서 착임일 ()
								var fromDate = $('#dialogMessage input#newFromDate').val();
								// 현부서 착임일
								var oldFromDate = $('#dialogMessage input#prevFromDate').val();
								console.log("prevFromDate >> "+oldFromDate);
								
								var empNo = $('#dialogMessage input#empNo').val();
								
								
								// 기존 부서와 새로운 부서가 같을 경우 alert
								if(deptNo == oldDeptNo){
									alert("발령 부서는 현재 부서와 동일 할 수 없습니다!");
									return;
								}else if(deptNo == null || deptNo == ''){
									alert("발령부서를 선택해주세요");
									return;
								}
								else if(fromDate == null || fromDate == ''){
									alert("발령 착임일을 선택해주세요");
									return;
								}else{
									// 다를 경우 ajax 호출을 통해 부서 변경 수행
									$.ajax({
						        		url: '<c:url value="/dept/changeDept.do" />',
						        		data :{ 'oldDeptNo' : oldDeptNo, 
						        			     'deptNo' : deptNo,
						        			     'empNo' : empNo,
						        			     'fromDate' : fromDate,
						        			     'oldFromDate' : oldFromDate
					        					 },
						        		success : function (depts, textStatus, XMLHttpRequest) {
						        			alert(depts.msg);
						        	        $('#dialogMessage').dialog('close');
						        	        $("#empGrid").trigger("reloadGrid");
						        		},
						        		error : function (XMLHttpRequest, textStatus, errorThrown) {
						        			alert('에러 \n'+XMLHttpRequest);
						        		}
						        	}); 
									
								}
								
							});
							
							// 다이얼로그 닫기
							$("#dialogMessage button#btnClose").click(function(){
								$('#dialogMessage').dialog('close');
							});
				        },
				        // open 끝
				        overlay: {
				            opacity: 1,
				            background: "black"
				        },
				        close: function(){
				        	
						}
				    });
					// 다이얼로그 끝
				},
				//success 끝
				error : function(a, b, c){
					console.log(a);
					console.log(b);
					console.log(c);
				}
			});
			// 팝업열기 ajax 끝
		}
		// else 끝
	});
	// 부서 변경 버튼 끝
	
	
	///////////////////////////////////////////////////////////////////////////////////////////// depart modify
	
	
	// [연봉 변경]  연봉변경 버튼 클릭
	$('#btnChngSalariesInfo').click(function(){
		
		//rowid 가져오기
		var rowId = $("#empGrid").jqGrid('getGridParam', 'selrow');
		
		if(rowId == null || rowId == ''){
			alert('직원을 선택하세요!');
		}else{
			
			console.log("rowId >> "+rowId);
			//rowDate 가져오기
			var rowData = $("#empGrid").jqGrid('getRowData', rowId);
			console.log("rowDate >> "+rowData);
			
			//팝업열기
			$.ajax({
					url:'<c:url value="/salaries/changeSalaryInfo.do"/>',
					type:'post',
					cache:false,
					dataType:'html',
					// url 이 성공적으로 간다면
					// 컨트롤러에서 리턴값(changeSalariesPopup.jsp) 를 변수(html) 에 담아 쓰겠다.
					success:function(html){
						//#dialogSalaries 의 html 값을  리턴값(changeSalariesPopup.jsp) 로 쓰겠다.
						$('#dialogSalaries').html(html);
						
						// #dialogSalaries 을 다이얼로그로 불러오겠다.
						$('#dialogSalaries').dialog({
							// 다이얼로그 설정 끝
							height: 380,
					        width: 450,
					        title: '직원 연봉 변경',
					        autoOpen: true,
					        modal: true,
					        resizable: false,
					        autoResize: true,
					        
					        // 다이얼로그 가 open되면 실행된다.
							open:function(){
								// dialog 화면에 값 표시하기(changeSalariesPopup.jsp)
								
								
								// rowDate에 있는 사용자입력을 받지 않아도 되는값 해당 input태그에 넣어주기
								
								//성명
								$('#dialogSalaries input#fullName2').val(rowData.fullName);
								//사원번호
								$('#dialogSalaries input#empNo2').val(rowData.empNo);
								//입사일
								$('#dialogSalaries input#hireDate3').val(rowData.hireDate);
								//현부서
								$('#dialogSalaries input#deptName2').val(rowData.deptName);
								//기존적용일
								var test=$('#dialogSalaries input#oldFromDate').val(rowData.SfromDate);
								console.log("oldFromDate >> "+test);
								//현연봉
								//$('#dialogSalaries input#oldSalaries').val(rowData.salary);
								//console.log("oldSalaries >> "+rowData.salary);
								
								
								//현연봉 콤마 찍기 
								//String 값 -> 숫자로 형변한후 .toLocaleString()사용 -> 숫자값에 콤마 찍히면서 String으로 다시 형변환
								var salary = rowData.salary;
	                             console.log(salary);
	                             salary = Number(salary).toLocaleString("en-US");
	                             console.log(salary);
	
	                             $('#dialogSalaries input#oldSalaries').val(salary); //콤마 찍힌 String 값 넣어주기
									
								
								
								// 사용자 입력을 받아와야 되는값
	
								
								
								// 적용일
								// 적용일 설정시 기존 사원번호가 가지고있는 연봉변경 from_date값 이전값은 선택될수 없게 설정해야한다.
								// ? 
							    // ex) from_date   to_date
							    //      12월5일         9999   -> 12월9일
							    //      12월10일       9999
					        	//      12월10일       9999   ->  에러 ?  기존 from_date에 값이있다.
					        	// 따라서 fromdate 선택시 mindate가 기존변경한 from_date 포함 이전 값은 포함되어서는 안된다.
					        	// from_date는 0+1  오늘이후로 설정되어있지만 변경한 from_date 가 오늘(11월29일)   ->  from_date:12월1일    --(변경)-->  from_date:11월30일  하면  에러가나야한다.
					        	
								
					        	
					        	
					        	$( "#SalariesFromDate" ).datepicker(
					        			{
					        				defaultDate : "+1w", //달력 기본 출력될때 기준일
					        				changeMonth : true,
					        				changeYear : true,
					        				dateFormat : "yy-mm-dd",
					        				minDate: new Date(Date.parse(rowData.SfromDate) + 1 * 1000 * 60 * 60 * 24).toISOString().slice(0,10)
					        				//최소선택날짜는 : rowData에서 가져온 타이틀 fromDate에서 + 1 -> 타이틀에서 가져온 fromDate 이후부터(fromDate값포함 x) 선택되게 하며
					        				// 이값을 Date객체로 만든뒤 Date공식으로 만들어준후(시/분/초 100*60*60*24) 로 해준뒤 
					        				//.toISOString 국제 표준 으로 Date를 만들어주고
					        				//yyy-mm-dd 만 나올수있게 (시분초를 자른다) slice 10 해준다.
					        				
					        				
					        				//연봉변경 from_date 선택시
					        				//minDate 에 기존 추가한 from_date 포함 이전값은 아예 선택이 되지않게 수정해준다.
					        				//따라서 
					        				//1)연봉변경시 기존from_date랑 같은값이 들어갈수없게 유효성검사하는 코드가 필요하지않는다.
											//2)적용일 설정시 기존 사원번호가 가지고있는 연봉변경 from_date값 이전값은 선택되는 오류가 발생하지 않는다.					        			
					        			}
					        	);
								
								
								
					        	//.keyup : 키를 눌르고나서 실행되는이벤트 / .keydown : 키를 눌를때 실행되는 이벤트
								
								// 인상률 을 입력할때 % 입력하기
								// 제약조건 1.숫자만 입력가능 2.인상률 이 적혀있을 경우 인상률을 반영한 연봉이 자동계산되어 나타난다 3.인상률 없을경우 수기입력도 가능 4.인상률이 0이하 20% 이상일수없다.
								$('#addSalaries').keyup(function (a) {
									   
									
									/* 
									"인상률 backspace 구현"
									
								    이벤트 ( 키가 올라갈때(keyup) {

								    만약에( 키가 '백스페이스' 이면) {
								
								
								   if인상률 인풋 데이터가 2자리 미만이면 {
								      한자리기때문에 섭스트링(자르기) 0,0 데이터=0
								      새로운 연봉이 없어지게 하기위해서 = null
								      
								
								    }
								    if인상률 인풋 데이터가 2자리 이상일때{
								     인상률 가져오기 => 데이터자르기 ( 오르쪽, 왼쪽)
								     오른쪽좌표 (인풋데이터 길이 -1 )  --> 소수점 을 위해 -1작성 
								     왼쪽좌표 ( 0 )
						        	*/
						        	
						        	
									if(a.keyCode == 8){ //사용자가 입력한 값이 backspace(8)일 경우 
											
										 
										 //% 만 남았을경우
	                                     if($('#dialogSalaries input#addSalaries').val().length < 2){ 
	                                        $('#dialogSalaries input#addSalaries').val(null);   //인상률
	                                        $('#dialogSalaries input#newSalaries').val(null); //조정연봉
	                                        return; //유효성검사 pass
	                                     }
	                                     
										 //ex) 숫자1개입력 경우제외하고 모든경우(소수점,숫자1개 이상) 
	                                     else{ 
	                                    	 
	                                    	 //인상률값넣어주기  -->  작성한인상률값.잘라준다(오른쪽(작성한인상률길이-1),0);
	                                    	 //-1은 소수점 계산을 위해 넣어주었다? ex)    1.3444.substring(1,0)  ->  1    addSalaries:1 
	                                    	 //ex)
	                                    	 //인상률값넣어주기  -->  20.substring(1,0)
	                                    	 //인상률값 : 2 를 넣어준다 즉 addSalaries input 태그에 값이 설정된다.
	                                    	 // 그리고 esle문을 빠져나가 아래 변수선언 코드 및 유효성검사 실행 해서 조건에 해당될경우 %를 붙이고 아니면 유효성검사중에 걸려 alert값 반환
	                                    	 //즉 20작성후 -> 20% -> 한번 지우기 -> 2% -> 유효성검사 -> 맞으면 newsalaries값 나타남
	                                    	 // 처음부터 0이상20이하 값을 작성하지 않으면 alert값 반환해준다. -> 0이하값이나 20이상값은 아예 적을수 없음
	                                    	 
	                                    	 
	                                        $('#dialogSalaries input#addSalaries').val($('#dialogSalaries input#addSalaries').val().substring($('#dialogSalaries input#addSalaries').val().length-1,0));
	                                     
	                                     } 
										
									   }
									
									
										//변수로 선언한 값에 div id="" 값을 가져온다.
									   
									   //현연봉 꺼내오기    String(,) 넣어준값 -> Number 꺼내오기 -> String으로 넣어주기
									   var oldSalary = Number(rowData.salary);
									   
									   //인상률 꺼내오기 Number  >> 제약조건중에 number로만 입력되게 설정해놈 
		                               //.replace(/%/g, '') 사용이유? 값입력시 숫자가 0에서20이하이면 자동으로 %가 붙는다 따라서 숫자 한글자씩 0보다크고 20보다 작은수를 작성하면
		                               //그 한글자한글자에 %가 붙는다 따라서 input창에 처음 적힐때 는 %를 '' 즉 공백으로 replace해놓고 
		                               //20보다작은수가 완전히 들어가고나면(유효성검사 if문) %를 그때서야 붙여준다.
									   var incRatio = $('#dialogSalaries input#addSalaries').val().replace(/%/g, ''); 
	                                   //새로운 연봉 계산식
									   var newSalary = oldSalary + parseInt(oldSalary / 100 * incRatio); 
									   console.log("newSalary >> "+newSalary);
									   //기존연봉+소수점버린다(기존연봉/100*인상률)
						        	   //parseInt : 소수점버리기
	                                   
	                                   
						        	   
						        	   
									   
									   
	                                  //유효성검사하기
	                                  
	                                  
									 //인상률이 0이상 20이하로 작성된다면
						        	if(0<incRatio && incRatio<=20){
						        		//새로운값 넣어주기 .val에 값이있다   숫자인newSalary 에 콤마 찍어주기
						        		$('#dialogSalaries input#newSalaries').val(newSalary.toLocaleString());
						        		//인상률에 %넣어주기 .val에 값이있다
						        		$('#dialogSalaries input#addSalaries').val(incRatio+'%');
						        		//인상률 숫자+소수정 으로만 받기	
						        	}else if(!/^[0-9.]*$/.test(incRatio)){
		                                alert('인상률은 숫자만 입력할 수 있습니다.');
		                                 //잘못입력시 새로운값에 찍히는값 null처리
		                                 $('#dialogSalaries input#newSalaries').val(null);
		                                 //잘못입력시 인상률에 찍히는값 null처리
		                                 $('#dialogSalaries input#addSalaries').val(null);
		                            }else{ 
		                                 alert('인상률은 0초과 20이하가 되어야 합니다.');
		                                 // 잘못입력시 새로운값에 찍히는값 null처리
		                                 $('#dialogSalaries input#newSalaries').val(null);
		                                 // 잘못입력시 인상률에 찍히는값 null처리
		                                 $('#dialogSalaries input#addSalaries').val(null);
		                            }
	                                  
	                                  
						
					        		
								});
								
								
								// 새로운연봉
								// 제약조건 1.숫자만 입력가능  2.인상률 없을경우 수기입력도 가능 2.새로운연봉 이  현재 연봉의 0이하 20% 이상일수없다.
								// .blur : 해당 영역을 벗어나면 실행되는코드
								 $("#newSalaries").blur(function(){
	                                   
									
									 	
								 	//현연봉 꺼내오기 Number
									var oldSalary = Number(rowData.salary);
									//새로운연봉 꺼내오기 Number
									// .replace(/,/g, '') : 콤마를 공백으로바꿔주기 ?
									// 새로운연봉을 입력할때 (숫자입력 ex)13333) 입력하고나서 input 을 벗어나면 .blur(콤마가찍히면서 String값으로 변경 ex)NaN 값이됨) 되고 다시 input박스에 들어오게 되면
									// 새로운연봉에 있는값이 콤마 때문에 스트링 값으로 인식이되서 
									// 유효성검사 에 걸려서 alert('인상률은 0%초과 20%이하가 되어야 합니다.') 값이 계속 출력됨
									// 따라서 1)입력을다하고 0이상20이하이면 콤마를찍어주고  2)그냥 현연봉에는 .bulr로 인해 나갓다가 다시 들어오면 그대로 있는 콤마값 을 없애주어야 하기때문에
									// .replace 사용해서 /,/g : 콤마값을 '' 공백으로 바꿔준다.
									
									
								 	var newSalary = Number($('#dialogSalaries input#newSalaries').val().replace(/,/g, ''));
		                            //인상률 계산식 Number   
		                            //toFixed : 소수점을 2자리까지 표시한다.
									var incRatio = ((newSalary-oldSalary) / (oldSalary / 100)).toFixed(2) ;
									//14444-12444 / 12444/100
									//2000/124
									//16
									console.log("newSalary >> "+newSalary);
		                                
									//유효성검사하기
						        	//인상률이 0이상 20이하로 작성된다면
									if(0 < incRatio && incRatio <=20){
										//인상률에 %넣어주기 .val에 값이있다 
	                                    $('#dialogSalaries input#addSalaries').val(incRatio+'%');
										//새로운값 넣어주기 .val에 값이있다   숫자인newSalary 에 콤마 찍어주기 
	                                    $('#dialogSalaries input#newSalaries').val( newSalary.toLocaleString());
		                                
										//새로운값이 null 일경우 아무것도 하지않음
			                        }else if(newSalary == null || newSalary == ''){
		                                	 
		                            }else{
		                             	alert('인상률은 0%초과 20%이하가 되어야 합니다.');
		                                $('#dialogSalaries input#newSalaries').val(null);
		                                $('#dialogSalaries input#addSalaries').val(null);
		                            }

	                               });
	                               
								
														

								// 저장버튼구현
								$("#dialogSalaries button#btnSaveInfo2").click(function(){
									
									
									
									// 저장될때 넘어가는값  newSalaries,oldSalary,SalariesFromDate,empNo
									
									var empNo = $('#dialogSalaries input#empNo2').val();
									//.replace(/,/g, '') 저장할때 콤마 삭제
									var oldSalary = $('#dialogSalaries input#oldSalaries').val().replace(/,/g, '');
									//.replace(/,/g, '') 저장할때 콤마 삭제
									var newSalaries = $('#dialogSalaries input#newSalaries').val().replace(/,/g, '');
									
									var SalariesFromDate = $('#dialogSalaries input#SalariesFromDate').val();
									var oldFromDate = $('#dialogSalaries input#oldFromDate').val();
									
									
									
									
									
									if(oldSalary == newSalaries){ // 연봉 제약조건 
										alert("연봉이 변경되지 않았습니다.");
										return;
									}else if(newSalaries == '' || newSalaries == null){
										alert("새로운 연봉값을 작성해주세요");
										return;
									}
									else if(SalariesFromDate == '' || SalariesFromDate== null ){ // 적용일 제약조건 1.not null
										alert("적용일 을 작성해주세요");
										return;
									}else{
										//연봉변경 저장할때 update쿼리에서 to_date를 now()로 쓴다면...
										//만약 기존연봉의 to_date(11월29일)는 오늘(now)이고 연봉변경 의 적용일이 12월2일 로 한다면..
										// 11월29일~12월2일 사이에 날짜에는 연봉 을 받을수없게되버린다..
										//그래서 기존연봉의 to_date는  연봉변경할때 입력하는 적용일(from_date) 하루 이전으로 적용되게하면 중간에 비는 날짜가 없어지게된다.
										
										var toDate = new Date(Date.parse($('#dialogSalaries input#SalariesFromDate').val()) - 1 * 1000 * 60 * 60 * 24).toISOString().slice(0,10);
										
										//기존연봉의 toDate는 = 데이터로변환한다(적용일데이터피커에서값을가져온다) 하루전구하는공식).날짜로변경하는공식(date) 하게되면 시분초 까지나오게된다.잘라준다 10자리까지 yyy-mm-dd (10개) 
										//하누전구하는공식을 데이터로 변환후 표준규격string 으로 값변경되 yyy-mm-dd 형식으로나오게 수정
										console.log("toDate >> "+toDate);
										//else문 안에 넣어주는 이유?
										//유효성검사할때 이코드를 밖에다 빼주면 에러가발생? 즉 유효성검사를할때 to_date를 못불러오기때에 저장이될때 넣어준다.
								
										$.ajax({
							        		url: '<c:url value="/salaries/changeSalaries.do" />',
							        		data :{ 'salaries' : newSalaries, 
							        			     'oldSalary' : oldSalary,
							        			     'fromDate' : SalariesFromDate,
							        			     'empNo':empNo,
							        			     'oldFromDate':oldFromDate,
							        			     'toDate':toDate,
						        					 },
							        		success : function (depts, textStatus, XMLHttpRequest) {
							        			alert(depts.msg);
							        	        $('#dialogSalaries').dialog('close');
							        	        $("#empGrid").trigger("reloadGrid");
							        		},
							        		error : function (XMLHttpRequest, textStatus, errorThrown) {
							        			alert('에러 \n'+XMLHttpRequest);
							        		}
							        	}); 
									}
									
								});
								// 저장버튼 끝
								// 다이얼로그 닫기
								$("#dialogSalaries button#btnClose2").click(function(){
									$('#dialogSalaries').dialog('close');
								});
							},
							// #dialogSalaries 다이얼로그 open 끝
							overlay: {
					            opacity: 1,
					            background: "black"
					        },
					        // overlay 끝
					        close: function(){
					        	
							}
					        // close 끝
						});
						// 다이얼로그 끝
					},
					error:function(a,b,c){
						console.log(a);
						console.log(b);
						console.log(c);
						
					}
			}); 
			//팝업열기 ajax 끝
		} 
		//else문 끝
	}); 
	//연봉 변경 버튼 끝
	
	
	///////////////////////////////////////////////////////////////////////////////////////////// salaries modify
	
	
	// [타이틀 변경]  타이틀변경 버튼 클릭
	$('#btnChngTitlesInfo').click(function(){
		
		//rowid 가져오기
		var rowId = $("#empGrid").jqGrid('getGridParam', 'selrow');
		
		if(rowId == null || rowId == ''){
			alert('직원을 선택하세요!');
		}else{
			
			console.log("rowId >> "+rowId);
			//rowDate 가져오기
			var rowData = $("#empGrid").jqGrid('getRowData', rowId);
			
			console.log("rowDate >> "+rowData);
			
			//팝업열기
			$.ajax({
					url:'<c:url value="/titles/changeTitlesInfo.do"/>',
					type:'post',
					cache:false,
					dataType:'html',
					// url 이 성공적으로 간다면
					// 컨트롤러에서 리턴값(changeSalariesPopup.jsp) 를 변수(html) 에 담아 쓰겠다.
					success:function(html){
						//#dialogSalaries 의 html 값을  리턴값(changeSalariesPopup.jsp) 로 쓰겠다.
						$('#dialogTitles').html(html);
						
						// #dialogSalaries 을 다이얼로그로 불러오겠다.
						$('#dialogTitles').dialog({
							// 다이얼로그 설정 끝
							height: 380,
					        width: 450,
					        title: '직원 타이틀 변경',
					        autoOpen: true,
					        modal: true,
					        resizable: false,
					        autoResize: true,
					        
					        // 다이얼로그 가 open되면 실행된다.
							open:function(){
								// dialog 화면에 값 표시하기(changeSalariesPopup.jsp)
								
								
								// rowDate에 있는 사용자입력을 받지 않아도 되는값 해당 input태그에 넣어주기
								
								//성명
								$('#dialogTitles input#fullName3').val(rowData.fullName);
								//사원번호
								$('#dialogTitles input#empNo3').val(rowData.empNo);
								//입사일
								$('#dialogTitles input#hireDate4').val(rowData.hireDate);
								//현직함
								$('#dialogTitles input#oldTitle').val(rowData.title);
								//기존 적용일
								$('#dialogTitles input#oldFromDate').val(rowData.TitlesfromDate);
								//새직함
								
								var newTitle = $('#dialogTitles input#newTitle').val();
								
								if(newTitle>50){
									$('#dialogTitles input#newTitle').val($('#dialogTitles input#newTitle').val().substring(50,0))
								}
								
								// 사용자 입력을 받아와야 되는값
					        	
					        	$( "#TitleFromDate" ).datepicker(
					        			{
					        				defaultDate : "+1w", //달력 기본 출력될때 기준일
					        				changeMonth : true,
					        				changeYear : true,
					        				dateFormat : "yy-mm-dd",
					        				minDate: new Date(Date.parse(rowData.TitlesfromDate) + 1 * 1000 * 60 * 60 * 24).toISOString().slice(0,10)
					        				//최소선택날짜는 : rowData에서 가져온 타이틀 fromDate에서 + 1 -> 타이틀에서 가져온 fromDate 이후부터(fromDate값포함 x) 선택되게 하며
					        				// 이값을 Date객체로 만든뒤 Date공식으로 만들어준후(시/분/초 100*60*60*24) 로 해준뒤 
					        				//.toISOString 국제 표준 으로 Date를 만들어주고
					        				//yyy-mm-dd 만 나올수있게 (시분초를 자른다) slice 10 해준다.
					        				
					        				
					        				//연봉변경 from_date 선택시
					        				//minDate 에 기존 추가한 from_date 포함 이전값은 아예 선택이 되지않게 수정해준다.
					        				//따라서 
					        				//1)연봉변경시 기존from_date랑 같은값이 들어갈수없게 유효성검사하는 코드가 필요하지않는다.
											//2)적용일 설정시 기존 사원번호가 가지고있는 연봉변경 from_date값 이전값은 선택되는 오류가 발생하지 않는다.					        			
					        			}
					        	);
								
								
								// 저장버튼구현
								$("#dialogTitles button#btnSaveInfo3").click(function(){
									
									
									
									
									//기존 적용일
									$('#dialogTitles input#oldFromDate').val(rowData.TitlesfromDate);
									
									
									// 저장될때 넘어가는값  newSalaries,oldSalary,SalariesFromDate,empNo
									
									var empNo = $('#dialogTitles input#empNo3').val();
									
									var oldTitle = $('#dialogTitles input#oldTitle').val();

									var fromDate = $('#dialogTitles input#TitleFromDate').val();

									var oldFromDate = $('#dialogTitles input#oldFromDate').val();
									
									var title = $('#dialogTitles input#newTitle').val();
									
									
									
									//유효성검사
									
								
									if(oldTitle == title || title==''){ // 연봉 제약조건 
										alert("직함이 변경되지 않았습니다.");
										return;
									}else if(title == null || title ==''){
										alert("변경될 직함을 작성해주세요")
									}
									else if(fromDate == '' || fromDate== null ){ // 적용일 제약조건 1.not null
										alert("적용일 을 작성해주세요");
										return;
									}else{
										
										//연봉변경 저장할때 update쿼리에서 to_date를 now()로 쓴다면...
										//만약 기존연봉의 to_date(11월29일)는 오늘(now)이고 연봉변경 의 적용일이 12월2일 로 한다면..
										// 11월29일~12월2일 사이에 날짜에는 연봉 을 받을수없게되버린다..
										//그래서 기존연봉의 to_date는  연봉변경할때 입력하는 적용일(from_date) 하루 이전으로 적용되게하면 중간에 비는 날짜가 없어지게된다.
										
										var toDate = new Date(Date.parse($('#dialogTitles input#TitleFromDate').val()) - 1 * 1000 * 60 * 60 * 24).toISOString().slice(0,10);
										
										//기존연봉의 toDate는 = 데이터로변환한다(적용일데이터피커에서값을가져온다) 하루전구하는공식).날짜로변경하는공식(date) 하게되면 시분초 까지나오게된다.잘라준다 10자리까지 yyy-mm-dd (10개) 
										//하누전구하는공식을 데이터로 변환후 표준규격string 으로 값변경되 yyy-mm-dd 형식으로나오게 수정
										console.log("toDate >> "+toDate);
										
										
										
										$.ajax({
							        		url: '<c:url value="/titles/changetitles.do" />',
							        		data :{ 'empNo':empNo,
							        				   'oldTitle' : oldTitle, 
							        				   'oldFromDate' : oldFromDate,
							        			       'title' : title,
							        			       'fromDate':fromDate,
							        			       'toDate':toDate,
						        					 },
							        		success : function (depts, textStatus, XMLHttpRequest) {
							        			alert(depts.msg);
							        	        $('#dialogTitles').dialog('close');
							        	        $("#empGrid").trigger("reloadGrid");
							        		},
							        		error : function (XMLHttpRequest, textStatus, errorThrown) {
							        			alert('에러 \n'+XMLHttpRequest);
							        		}
							        	}); 
									}
									
								});
								// 저장버튼 끝
								// 다이얼로그 닫기
								$("#dialogTitles button#btnClose3").click(function(){
									$('#dialogTitles').dialog('close');
								});
							},
							// #dialogSalaries 다이얼로그 open 끝
							overlay: {
					            opacity: 1,
					            background: "black"
					        },
					        // overlay 끝
					        close: function(){
					        	
							}
					        // close 끝
						});
						// 다이얼로그 끝
					},
					error:function(a,b,c){
						console.log(a);
						console.log(b);
						console.log(c);
						
					}
			}); 
			//팝업열기 ajax 끝
		} 
		//else문 끝
	}); 
	//타이틀 변경 버튼 끝
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////// titles modify
	
	// 삭제 버튼 클릭
	$('#btnDelEmpInfo').click(function(){
	      var empNo = $("#empGrid").jqGrid('getGridParam', 'selrow');
	      var data =$("#empGrid").jqGrid('getRowData',empNo);
	  	  console.log(data);
	  	
	  	  var result = data.empNo;
	  	  console.log(result);
	      if(empNo == null || empNo == ''){
	           alert('직원을 선택하세요!');
	      }
	      else{
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
	                      // 삭제 수행 ajax
	                      
	                     $.ajax({
	              	            url: '<c:url value="/emp/delEmpInfo.do" />',
	              	            data : {'empNo':result}, //요청후(url에서)return 하는값
	              	            success : function (depts, textStatus, XMLHttpRequest) {
	              	            	
	              	            	$(div).dialog('close');
	              	            	$("#empGrid").trigger("reloadGrid");
	              	            },
	              	            error : function (XMLHttpRequest, textStatus, errorThrown) {
	              	    			alert('에러 \n'+XMLHttpRequest);
	              	    		},
	              	            type: "POST",
	              	            beforeSend:function(){
	              	              console.log("삭제중입니다.");
	              	            }
	              	        }).done(function(){
	              	          console.log("삭제되었습니다.");
	              	       
	              	    });
	              		
	                      
	                      // ajax 끝
	                      },
	                      "취소": function() {
	                            $( this ).dialog( "close" );
	                      }
	                 }
	           });
     // 삭제 다이얼로그 끝
      }
});
// 삭제 버튼 클릭 끝



///////////////////////////////////////////////////////////////////////////////////////////// btnDelEmpInfo
	
});

// [직원추가] 닫기버튼
function btnClose(){
	$('#dialogPopUp').dialog('close');
	//닫기버튼을 클릭할 경우 닫기 메소드가 실행되면서 1)닫기버튼은 다이얼로그 자체내에 있는 close메소드를 
	//실행하면서 2)다이얼로그 안에있는 close메소드 안에있는 기존값이 없어지고 새로운 html이 생성되는 
	//메소드를 실행한다.
}


/* function inputNumberFormat(obj) { 
    obj.value = comma(uncomma(obj.value)); 
} 

function comma(str) { 
    str = String(str); 
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'); 
} 

function uncomma(str) { 
    str = String(str); 
    return str.replace(/[^\d]+/g, ''); 
} */



// [직원삭제] 직원삭제버튼
/* function btnDelEmpInfo(){
	
	
	var rowid = $("#empGrid").jqGrid('getGridParam','selrow');
	console.log(rowid);
	
	var data =$("#empGrid").jqGrid('getRowData',rowid);
	console.log(data);
	
	var result = data.empNo;
	console.log(result);
	
	if(rowid != null){
		if(confirm("정말 삭제하시겠습니까?") == true){
	        $.ajax({
	            url: '<c:url value="/emp/delEmpInfo.do" />',
	            data : {'empNo':result}, //요청후(url에서)return 하는값
	            success : function (depts, textStatus, XMLHttpRequest) {
	            	alert("삭제 성공");
	            	$("#empGrid").trigger("reloadGrid");
	            },
	            error : function (XMLHttpRequest, textStatus, errorThrown) {
	    			alert('에러 \n'+XMLHttpRequest);
	    		},
	            type: "POST",
	            beforeSend:function(){
	              console.log("삭제중입니다.");
	            }
	        }).done(function(){
	          console.log("삭제되었습니다.");
	        });
		}
	}else{
		alert("삭제할 회원을 선택하세요");
	}
    
} */
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
	  		employees 테이블의 정보를 가져와 기본적인 정보를 화면에 출력한다. 
		</p>
		<!-- 검색 -->
		<form name="deptForm">
			<fieldset>
			    <legend>조건</legend>
			    <label>부서 : </label>
				<select id="deptNos" name="deptNos"></select>
			    &nbsp;&nbsp;
			    <label>이름 : </label>
			    <input type="text" name="name" id="name" size="30" maxlength="30" />
			    <button type="button" id="btnSearch" >조회</button>
			</fieldset>
			<!-- 버튼 -->
			<div align="right" style="margin-bottom:10px;">
				<button type="button" id="btnChngTitlesInfo">직함변경</button>
				<button type="button" id="btnChngSalariesInfo">연봉변경</button>
				<button type="button" id="btnChngDeptInfo">부서변경</button>
				<button type="button" id="btnAddEmpInfo">직원추가</button>
				<button type="button" id="btnDelEmpInfo">직원삭제</button>
			</div>
		</form>
		<!-- List Grid -->
		<table id="empGrid"></table>
		<div id="empGrid-pager"></div>
	</div>
	<div id="tabs-2">
		<p></p>
	</div>
</div>

<!-- 직함번경 컨트롤러에서 리턴해준 div를 뿌려주는곳 -->
<div id="dialogTitles"></div>

<!-- 연봉번경 컨트롤러에서 리턴해준 div를 뿌려주는곳 -->
<div id="dialogSalaries"></div>

<!-- 부서번경 컨트롤러에서 리턴해준 div를 뿌려주는곳 -->
<div id="dialogMessage"></div>

<form id="test">
<!-- 직원추가 -->
<div id="dialogPopUp" style="display: none;">
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
				<td>성별</td>
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
				    <input type="text" name="birthDate" id="birthDate" size="20" maxlength="10" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>입사일</td>
				<td>
				    <input type="text" name="hireDate" id="hireDate" size="20" maxlength="10" readonly="readonly"  />
				</td>
			</tr>
			<tr>
				<td>부서</td>
				<td>
					<!-- 바뀔수있는 값들을 ajax로 불러온다. -->
				    <select id="diagDeptNos"></select>
				</td>
			</tr>
			<tr>
				<td>직함</td>
				<td>
				    <input type="text" name="title" id="title" size="20" maxlength="40" />
				</td>
			</tr>
			<tr>
				<td>착임일</td>
				<td>
				    <input type="text" name="fromDate" id="fromDate" size="20" maxlength="10" readonly="readonly"  />
				</td>
			</tr>
			<tr>
				<td>연봉</td>
				<td>
				    <input type="text" name="salary" id="salary" size="20" maxlength="12"  />
				</td>
			</tr>
		</table>
		<button type="button" id="btnSaveInfo">저장</button>
		<button type="button" onclick="btnClose()" id="dialogPopUp">닫기</button>
	</fieldset>
</div>
</form>
</body>
</html>