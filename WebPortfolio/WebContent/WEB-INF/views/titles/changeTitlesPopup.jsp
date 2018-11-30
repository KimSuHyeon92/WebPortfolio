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
				    <input type="text" id="fullName3" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>사원번호</td>
				<td>
				    <input type="text" name="empNo3" id="empNo3" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>입사일</td>
				<td>
				    <input type="text" name="hireDate4" id="hireDate4" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>현 직함</td>
				<td>
				    <input type="text" name="oldTitle" id="oldTitle" readonly="readonly" size="20"/>
				</td>
			</tr>
			<tr>
				<td>새 직함</td>
				<td>
				    <input type="text" name="newTitle" id="newTitle" size="20" />
				</td>
			</tr>
			<tr>
				<td>적용일</td>
				<td>
					<input type="hidden" name="oldFromDate" id="oldFromDate" size="20" />
				    <input type="text" name="TitleFromDate" id="TitleFromDate" size="20" />
				</td>
			</tr>
		</table>
		
		<button type="button" id="btnSaveInfo3">저장</button>
		<button type="button" id="btnClose3">닫기</button>
	</fieldset>
</body>
</html>