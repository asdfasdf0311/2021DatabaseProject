<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.net.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/background.css">
<meta charset="UTF-8">
<title>확인 창</title>
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
String sql_query=new String(); // seattable 로부터 받아올 쿼리
String query=new String(); 
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
	   query="desc reserved";
	    rs=stmt.executeQuery(query);
%>
<script>

function reserve_checking(id, airlines, plane, depart, arrive, date, hour ,minute, seat, gate,  cost)
{
	var user_id=id;
	var airline=airlines;
	var plane_no=plane;
	var departure=depart;
	var arrival=arrive;
	var departure_date=date;
	var departing_hour=hour;
	var departing_minute=minute;
	var seat_no=seat;
	var gate_no=gate;
	var price=cost;
	
	var URL = "reserve_confirm.jsp?user_id= "+ user_id+"&airline= "+airline+"&plane_no= "+plane_no+"&departure= "+departure+"&arrival= "+arrival+"&departure_date= "+departure_date+"&departing_hour= "+departing_hour+"&departing_minute= "+departing_minute+"&seat_no= "+seat_no+"&gate_no= "+gate_no+"&price= "+price;
	var rtnVal = window.showModalDialog(URL, self, "dialogWidth:100; dialogHeight:100; help:no; status:no;");

}
</script>

<div align="center" class="print">
		    <h2>예약 하시겠습니까?</h2> </div>
		   <div align="center" class="print">
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
		   <tr>
		   <td> <%=id%> </td>
		   <td> <%=airline%> </td>
		   <td> <%=plane_no%> </td>
		   <td> <%=departure%> </td>
		   <td> <%=arrival%> </td>
		   <td> <%=departure_date%> </td>
		   <td> <%=departing_hour%>시 </td>
		   <td> <%=departing_minute%>분 </td>
		   <td> <%=seat_no%> </td>
		   <td> <%=gate_no%> </td>
		   <td> <%=price%>원 </td>
		   </tr>
		   </table>
		   </div>
		   <br><br>
		  
		   <div  style="display: flex; justify-content: flex-end; padding-right: 140px;">
		    <form name="form1" method="post" action="reserve_confirm.jsp" >
		   				<input type="hidden" name="user_id" value=<%=id%> />
						<input type="hidden" name="airline" value=<%=airline%> />
						<input type="hidden" name="plane_no" value=<%=plane_no%> />
						<input type="hidden" name="departure" value=<%=departure%> />
						<input type="hidden" name="arrival" value=<%=arrival%> />
						<input type="hidden" name="departure_date" value=<%=departure_date%> />
						<input type="hidden" name="departing_hour" value=<%=departing_hour%> />
						<input type="hidden" name="departing_minute" value=<%=departing_minute%> />
						<input type="hidden" name="seat_no" value=<%=seat_no%> />
						<input type="hidden" name="gate_no" value=<%=gate_no%> />
						<input type="hidden" name="price" value=<%=price%> />
		   <input type="submit" name="confirm" value="확인" /> <!--  onclick="reserve_checking(<%=id%>, <%=airline%>, <%=plane_no%>, <%=departure%>, <%=arrival%>, <%=departure_date%>, <%=departing_hour%>,<%=departing_minute%>,<%=seat_no%> , <%=gate_no%>, <%=price%>);"   -->   
		 </form>
		 &nbsp;&nbsp;&nbsp;
		  <form name="form2" action="info_print.jsp" method="post">
		  <input type="hidden" name="user_id" value=<%=id%> >
		   <input type="hidden" size=13 name="reserve_list" value="reserving" />
		   <input type="submit" name="cancel" value="취소" onclick="location.href = 'info_print.jsp'">
		   </form>
		   </div>


</body>
</html>