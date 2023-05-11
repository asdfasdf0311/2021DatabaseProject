<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.sql.*,java.net.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/background.css">
<title>reserve_page</title>
<style>
 img {
 	display: flex;
	height: 80px;
	margin-right: auto;
}
</style>


</head>
	<!--border: solid 1px; -->  <!-- 실선 1픽셀 -->  <!--여백 5pixel-->
<body>
<%
	request.setCharacterEncoding("utf-8");
   java.sql.Connection conn = null;
   java.sql.Statement stmt = null;
   java.sql.ResultSet rs = null;
   PreparedStatement pstmt = null;
   String dburl = "jdbc:mysql://localhost:3306/reserve_plane?useSSL=false";
   String dbuser = "root", dbpass = "hunter5268";
   String param=request.getParameter("reserve_list");
   String id=request.getParameter("user_id");
   String sql_query=new String();
   String query=new String();
   if(param.equals("reserveTable"))
   {
	   
	   sql_query="select * from reserved where user_id='"+id+"' order by departure_date, departing_hour, departing_minute";
	  query="desc reserved";
	  
   }
   else if(param.equals("reserving"))
   {
	   
	   sql_query="select * from plane where ((departure_date=curdate() and departing_hour>=hour(curtime())) or departure_date>curdate()) order by departure_date, departing_hour, departing_minute";
	   query="desc plane";
   }
   try {
   Class.forName("com.mysql.jdbc.Driver");
   out.println("<br>");
   } catch (ClassNotFoundException e ) {
   out.println("Driver Loading Fail!<br>" + e.getMessage() + "<br>");
   }
   try{
   conn = DriverManager.getConnection(dburl, dbuser, dbpass);
   stmt = conn.createStatement();
   
   
   } catch (SQLException e) {
   out.println("DB Connection Fail!<br>" + e.getMessage() + "<br>");
	}
   
   
   try{
	   if(param.equals("reserveTable"))
	   {
		   rs=stmt.executeQuery(query);
		   %>
		   
		   <div align="center" class="print">
		   <a href="mainpage.jsp"><img src="homelogo.png" > </a>
		    <h2>예약 현황</h2><br> <br> </div>
		   <div class="print">
		   <table  border="1" cellspacing="0" cellpadding="8" bgcolor="white" style="margin: auto; text-align: center; width: 90%;">
		   <tr>
		   <%
		   while(rs.next())
		   {
		  %>
		   <th>
		   <%
		   out.println(rs.getString(1));
		   
		  %>
		    </th>
		  <%
		   
		   }
		  %>
		   </tr>
		   <%
		   try{
				
			   rs=stmt.executeQuery(sql_query);
		   
		   }
		   catch(Exception e)
		   {
			   out.println(sql_query+"<br>"+e.getMessage() );
		   }
		   while(rs.next())
		   {
%>
<tr>
		<%	   for(int i=1;i<=10;i++)
			   {
			%>
			<td>
				   <% 
				   
					  out.println(rs.getString(i));
					  if(i==7)
						  out.println("시");
					  if(i==8)
						  out.println("분");
				    %>
			</td>
			<%
				} 
		%>
			<td align="right" >
		<% out.println(rs.getString(11)+"원");
		 
					 
			
%>
 </td> </tr>
<%		
		   }
 %>
		   </table> 
		   <br>
		   </div>
		   <br><br>
		   <div align="center" >
		   <input type=button value="홈 페이지" onclick="location.href = 'mainpage.jsp'" />
		   <br>
		   <br>
 <%
		   out.println("<br> user_id  => "+id);
 
 %></div><br>
<%	   }
	   else if (param.equals("reserving"))
	   {
		   rs=stmt.executeQuery(query);
		   %>
		   
		  <div class="print" align="center"> 
	 <a href="mainpage.jsp"><img src="homelogo.png" > </a>
		  <br> <h2>비행기편 현황</h2> <br> <br></div>
		   <div class="print">
		   <table  border="1" cellspacing="0" cellpadding="8" bgcolor="white" style="margin: auto; text-align: center; width: 95%;" >
		   <tr>
		   <%
		   while(rs.next())
		   {
		  %>
		   <th>
		   <%
		   
		   out.println(rs.getString(1));
		   
		  %>
		    </th>
		  <%
		   
		   }
		  %>
		   </tr>
		   
<%
		   try{
				
			   rs=stmt.executeQuery(sql_query);
		   
		   }
		   catch(Exception e)
		   {
			   out.println(sql_query+"<br>"+e.getMessage() );
		   }
		   while(rs.next())
		   {
%>
		 <tr>
			<%
			   for(int i=1;i<=9;i++)
			   {
	 %>
	<td>
	
				  <%
				  out.println(rs.getString(i));
				  if(i==6)
					  out.println("시");
				  if(i==7)
					  out.println("분");
				 %>
	</td>
	<%
			   } 
			%>
			<td align="right">
			
			<%
			out.println(rs.getString(10) +"원");
			%>
			</td>
		 </tr>
			<%
		
		   }
		   %>
		   </table>
		   <br>
		   </div>
		   <br>
		    <div align="center" >
		   <form action="retrieved_page.jsp" method="get">
		   <select name="user_id">
		   <option value=<%=id%>> user_id : <%=id%></option>
		   </select>
		   <h4>출발지 : <input type="text" size=15 name="departure" required /></h4><br>
		   <h4>도착지 : <input type="text" size=15 name="arrival" required /></h4><br>
		   <input type="submit" value="검색" />
		   </form> <br> <br>
		   <input type=button value="홈 페이지" onclick="location.href = 'mainpage.jsp'">
		   <%
		   out.println("<br><br> user_id  =>  "+id);
		   %>
		   <br> <br>
		   </div>
		   
	<%	   
	   }
   }
   catch(Exception e){
	   out.println(e.getMessage());
   }
   try {
		if(rs != null) rs.close();
		if(stmt != null) stmt.close();
		if(conn != null) conn.close();
		
	} 
	catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>