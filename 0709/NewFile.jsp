<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.SubjectDAO" %>
<%@ page import="test.SubjectDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
		SubjectDAO subjectDAO = new SubjectDAO();
		ArrayList<SubjectDTO> dtos = subjectDAO.subjectSelect();
		
		for (int i = 0; i < dtos.size(); i++) {
			SubjectDTO dto = dtos.get(i);
			String sub_code = dto.getSub_code();
			String sub_name = dto.getSub_name();
			String sub_ename = dto.getSub_ename();
			String create_year = dto.getCreate_year();
			
			out.println(sub_code + sub_name + sub_ename + create_year);
			%> <br> <%
		}
	%>
</body>
</html>