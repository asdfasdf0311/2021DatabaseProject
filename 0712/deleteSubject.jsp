<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.SubjectDTO" %>
<%@ page import="test.SubjectDAO" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String sub_code = request.getParameter("sub_code").trim();
		
		SubjectDAO dao = new SubjectDAO();
		int result = dao.deleteSubject(sub_code);
		out.println(result);
	%>
	<a href="NewFile.jsp">뒤로 돌아가기</a>
</body>
</html>