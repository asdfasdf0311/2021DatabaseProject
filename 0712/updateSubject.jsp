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
		String sub_name = request.getParameter("sub_name").trim();
		String sub_ename = request.getParameter("sub_ename").trim();
		String create_year = request.getParameter("create_year").trim();
		SubjectDTO dto = new SubjectDTO(sub_code, sub_name, sub_ename, create_year);
		
		SubjectDAO dao = new SubjectDAO();
		int result;
		result = dao.updateSubject(dto);
		if (result == 1) {
			out.println("성공적으로 업데이트되었습니다.");
		}
		else {
			out.println("업데이트에 실패했습니다!");
		}
	%>
	<a href="NewFile.jsp">뒤로 돌아가기</a>
</body>
</html>