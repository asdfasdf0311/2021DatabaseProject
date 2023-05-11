<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.net.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 완료</title>
<link rel="stylesheet" type="text/css" href="css/background.css">
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id=request.getParameter("user_id");
String airline=request.getParameter("airline");
String plane_no=request.getParameter("plane_no");
String departure=request.getParameter("departure");
String arrival=request.getParameter("arrival");
String departure_date=request.getParameter("departure_date");
String departing_hour=request.getParameter("departing_hour");
String departing_minute=request.getParameter("departing_minute");
String seat_no=request.getParameter("seat_no");
String gate_no=request.getParameter("gate_no");
String price=request.getParameter("price");

java.sql.Connection conn = null;
java.sql.Statement stmt = null;
java.sql.ResultSet rs = null;
PreparedStatement pstmt = null;
String dburl = "jdbc:mysql://localhost:3306/reserve_plane?useSSL=false";
String dbuser = "root", dbpass = "hunter5268";
String sql_query=new String();
String sql_query2=new String(); 
String query=new String(); 
try {
	   Class.forName("com.mysql.jdbc.Driver");
	   out.println("<br>");
	   }
catch (ClassNotFoundException e ) {
	   out.println("Driver Loading Fail!<br>" + e.getMessage() + "<br>");
}

	   try{
	   conn = DriverManager.getConnection(dburl, dbuser, dbpass);
	   stmt = conn.createStatement();
	   
	   
	   } catch (SQLException e) {
	   out.println("DB Connection Fail!<br>" + e.getMessage() + "<br>");
		}
	  try{ 
	   query = "insert into reserved values(?, ?, ?, ?,?,?,?,?,?,?,?)";
	   pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		pstmt.setString(2, airline);
		pstmt.setString(3, plane_no);
		pstmt.setString(4, departure);	
		pstmt.setString(5, arrival);
		pstmt.setString(6, departure_date);
		pstmt.setString(7, departing_hour);
		pstmt.setString(8, departing_minute);
		pstmt.setString(9, seat_no);
		pstmt.setString(10, gate_no);
		pstmt.setString(11, price);
		pstmt.executeUpdate();
		sql_query="UPDATE plane SET avail_seat=avail_seat-1  WHERE plane_no=? and departure_date=? and departing_hour=?";
		 pstmt = conn.prepareStatement(sql_query);
		 pstmt.setString(1, plane_no);
		pstmt.setString(2, departure_date);
		pstmt.setString(3, departing_hour);
		pstmt.executeUpdate();
		sql_query2="UPDATE seattable SET avail_seat=avail_seat-1, s"+seat_no+"='U'  WHERE plane_no=? and departure=? and arrival=? and departure_date=? and departing_hour=?";	
		 pstmt = conn.prepareStatement(sql_query2);
		pstmt.setString(1, plane_no);
		pstmt.setString(2, departure);
		pstmt.setString(3, arrival);
		pstmt.setString(4, departure_date);
		pstmt.setString(5, departing_hour);
		pstmt.executeUpdate();
%>		
		<div class="print">
<h2> 예약 되었습니다.</h2></div>
<br><br>
<div style="display: flex;
			justify-content: flex-end;
			padding: 10px;    
			padding-left: 20px;
			padding-right: 40px;">
			
<input type="button" value="확인" onclick="location.href = 'mainpage.jsp'" />
</div>
<br>
		
	<%	
	  }	
	  catch(Exception e){
		  %>
		  <div class="print">
		  <h2> 에러 : 같은 비행기를 예약 하실 수 없습니다. </h2> </div>
		  <div style="display: flex;justify-content: flex-end;padding: 10px; padding-left: 20px; padding-right: 40px;">
		  <input type="button" value="확인" "onclick="location.href = 'mainpage.jsp'" />
		</div>
		  <%		  
		  
	  }
			
		pstmt.close();
		conn.close();
%>
<br>
</body>
</html>