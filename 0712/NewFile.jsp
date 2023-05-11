<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.SubjectDAO" %>
<%@ page import="test.SubjectDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<style>
		div {
			border: solid 1px;
			padding: 5px;
			background-color: #f5d682;
		}
	</style>
	
	<%
		SubjectDAO subjectDAO = new SubjectDAO();
		ArrayList<SubjectDTO> dtos = subjectDAO.subjectSelect();
	%>
	
</head>
<body>
	<div>
		<h1>과목 리스트</h1>
	</div>
	
	<div>
		<%
			for (int i = 0; i < dtos.size(); i++) {
				SubjectDTO dto = dtos.get(i);
				String sub_code = dto.getSub_code();
				String sub_name = dto.getSub_name();
				String sub_ename = dto.getSub_ename();
				String create_year = dto.getCreate_year();
				%> <div> <%= sub_code + " " + sub_name + " " + sub_ename + " " + create_year %> </div> <%
			}
		%>
	</div>
	
	<div>
		<form action="insertSubject.jsp" method="post">
			<h2>새로 등록할 과목 정보를 입력하세요.</h2>
			<h3>과목 코드</h3><input type="text" name="sub_code"/>
			<h3>과목 이름</h3><input type="text" name="sub_name"/>
			<h3>과목 영어이름</h3><input type="text" name="sub_ename"/>
			<h3>개설년도</h3><input type="text" name="create_year"/>
			<input type="submit" value="등록"/>
		</form>
	</div>
	
	<div>
		<form action="updateSubject.jsp" method="post">
			<h2>업데이트할 과목 정보를 입력하세요.</h2>
			<h3>과목 코드</h3>
			<select name="sub_code">
			<% 
				for (int i = 0; i < dtos.size(); i++) {
					SubjectDTO dto = dtos.get(i);
					String sub_code = dto.getSub_code();
					String sub_name = dto.getSub_name();

					%> <option value=<%=sub_code%>> <%= sub_code + ": " + sub_name %> </option> <%	
				}
			%>
			</select>
			<h3>과목 이름</h3><input type="text" name="sub_name"/>
			<h3>과목 영어이름</h3><input type="text" name="sub_ename"/>
			<h3>개설년도</h3><input type="text" name="create_year"/>
			<input type="submit" value="업데이트"/>
		</form>
	</div>
	
	<div>
		<form action="deleteSubject.jsp" method="post">
			<h2>삭제할 과목을 선택하세요.</h2>
			<select id="updateSelect" name="sub_code">
			<% 
				for (int i = 0; i < dtos.size(); i++) {
					SubjectDTO dto = dtos.get(i);
					String sub_code = dto.getSub_code();
					String sub_name = dto.getSub_name();

					%> <option value=<%=sub_code%>> <%= sub_code + ": " + sub_name %> </option> <%	
				}
			%>
			</select>
			<input type="submit" value="삭제"/>
		</form>
		<br>
		<br>
	</div>
</body>
</html>