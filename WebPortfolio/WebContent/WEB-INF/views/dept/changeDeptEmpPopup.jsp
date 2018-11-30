<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<fieldset style="display: inline-block;">
	    <legend>정보</legend>
		<table>
			<tr>
				<td>성명</td>
				<td>
				    <input type="text" id="fullName" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>사원번호</td>
				<td>
				    <input type="text" name="empNo" id="empNo" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>입사일</td>
				<td>
				    <input type="text" name="hireDate" id="hireDate2" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>현 부서</td>
				<td>
				    <input type="hidden" name="oldDeptNo" id="oldDeptNo"/>
				    <input type="text" name="deptName" id="deptName" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>현 부서 착임일</td>
				<td>
				    <input type="text" name="prevFromDate" id="prevFromDate" readonly="readonly" size="20" />
				</td>
			</tr>
			<tr>
				<td>발령 부서</td>
				<td>
				    <select id="diagDeptNos2"></select>
				</td>
			</tr>
			<tr>
				<td>착임일</td>
				<td>
				    <input type="text" name="newFromDate" id="newFromDate" size="20" maxlength="10" />
				</td>
			</tr>
		</table>
		
		<button type="button" id="btnSaveInfo">저장</button>
		<button type="button" id="btnClose">닫기</button>
	</fieldset>
</body>
</html>