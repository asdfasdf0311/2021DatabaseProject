<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.net.*"%>
<%@ page import="test.planeDTO"  %>
<%@ page import="test.planeSelect" %> 
    
    


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/background.css">
<style>
 img {
 	display: flex;
	height: 80px;
	margin-right: auto;
}
</style>
<style>
		div { 
			padding-left: 20px;    
		}
		div.pricesort
		{
			display: flex;
			justify-content: flex-end;
			text-align:right;
			padding-right: 150px;
		}
</style>
<meta charset="UTF-8">
<title>가격순 정렬</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
   java.sql.Connection conn = null;
   java.sql.Statement stmt = null;
   java.sql.ResultSet rs = null;
   PreparedStatement pstmt = null;
   String dburl = "jdbc:mysql://localhost:3306/reserve_plane?useSSL=false";
   String dbuser = "root", dbpass = "hunter5268";
   String arrival=request.getParameter("arrival");
   String departure=request.getParameter("departure");
   String id=request.getParameter("user_id");
   String sql_query=new String();
   String query=new String();
   query="desc plane";
   sql_query="select * from plane where ((departure_date=curdate() and departing_hour>=hour(curtime())) or departure_date>curdate()) and departure='"+departure+"' and arrival='"+arrival+"' order by price, departure_date, departing_hour, departing_minute";
   int j=0;

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
   %>
<%   rs=stmt.executeQuery(query);
		   %>
		   
		   <div class="print" align="center" >
		    <a href="mainpage.jsp"><img src="homelogo.png" > </a>
		    <br> <h2>비행기편 현황 (가격순 정렬)</h2>  <br> <br> </div>
		     <form name="form4" action="seat_print.jsp" method="post">
		   <div  class="print" >
		   <table  border="1" cellspacing="0" cellpadding="5" bgcolor="white" style="margin: auto; text-align: center; width: 90%; ">
		   <tr>
		   <th> 선택 </th>
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
			   j++;
%>			<tr>
			 	<td>
			 	<INPUT TYPE="radio" NAME="selected" VALUE="<%=j%>"  />
			 	 </td>
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
					<td align="right" >
				<%
				out.println(rs.getString(10)+"원");
				 %>
				 	</td>
			</tr>
			<%
		   }
		   %>
		   </table> <br> 
		   </div> <br> <br>
		   <div class="pricesort">
		    <input type="hidden" name="transfer_page"  value="price_sort" />
		    <input type="hidden" name="user_id" value=<%=id%> />
		    <input type="hidden" name="departure" value=<%=departure%> />
		    <input type="hidden" name="arrival" value=<%=arrival%> />
		    <input type="submit" value="예약하기" />
		    </div> 
		    </form>
		   <br>  
		   <div align="center">
  <!--   <form action="" method="post"> -->
   <form name="form1" action="price_sort.jsp" method="post">
		   <select name="user_id">
		   <option value=<%=id%>> user_id : <%=id%></option>
		   </select>
		   <h4> 출발지 : <input type="text" size=15 name="departure" value=<%=departure%> required /></h4><br>
		   <h4> 도착지 : <input type="text" size=15 name="arrival" value=<%=arrival%> required /></h4><br>
	    
		    <input type="submit" value="검색" />
   </form>
	<!--  	    <input type="submit" value="가격순 정렬" /> -->
		<!--    </form> -->
		  <form name="form2" action="info_print.jsp" method="post">
		  <input type="hidden" name="user_id" value=<%=id%> >
		   
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   <input type="hidden" size=13 name="reserve_list" value="reserving" /> <br><br>
		     <h3>   원하는 비행기가 없을 시 눌러주세요. </h3>
		   <input type=submit value="예약 페이지" onclick="location.href = 'info_print.jsp'">
		   
		   </form>
		   
		   <%
		   out.println("<br><br> user_id  =>  "+id);
		   %>
		   </div>
		   <br><br>
		   <%
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