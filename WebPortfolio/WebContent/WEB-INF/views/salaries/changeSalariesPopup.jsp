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
				    <input type="text" id="fullName2" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>사원번호</td>
				<td>
				    <input type="text" name="empNo2" id="empNo2" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>입사일</td>
				<td>
				    <input type="text" name="hireDate3" id="hireDate3" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>현 부서</td>
				<td>
				    <input type="text" name="deptName2" id="deptName2" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>현 연봉</td>
				<td>
				    <input style="text-align:right;" type="text" name="oldSalaries" id="oldSalaries" readonly="readonly" size="20" />
				</td>
			</tr>
			<tr>
				<td>인상률</td>
				<td>
				    <input style="text-align:right;" type="text" name="addSalaries" id="addSalaries" size="20" />
				</td>
			</tr>
			<tr>
				<td>조정 연봉</td>
				<td>
				    <input style="text-align:right;" type="text" name="newSalaries" id="newSalaries" size="20"  />
				</td>
			</tr>
			<tr>
				<td>적용일</td>
				<td>
					<input type="hidden" name="oldFromDate" id="oldFromDate" size="20" />
				    <input type="text" name="SalariesFromDate" id="SalariesFromDate" size="20" />
				</td>
			</tr>
		</table>
		
		<button type="button" id="btnSaveInfo2">저장</button>
		<button type="button" id="btnClose2">닫기</button>
	</fieldset>
</body>
</html>