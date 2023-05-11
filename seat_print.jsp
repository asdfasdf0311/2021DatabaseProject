<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.net.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/seatbg.css">
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
div#bg { 
		
		
		padding: 10px;
}
div#indoor {  
		margin: 5px;
		
}
</style>
<meta charset="UTF-8">
<title>좌석 표</title>
</head>

<body  style=" margin: 0;font-family: 'Jeju Gothic', sans-serif; background-repeat: no-repeat; background-size: cover;
		background-image: url('images/seat_bg4.png'); ">
<div id="bg"  style="text-align:center; width: 60%; margin: 0 auto;" >
<%
	int number=1; //seat_no
	request.setCharacterEncoding("utf-8");
   java.sql.Connection conn = null;
   java.sql.Statement stmt = null;
   java.sql.ResultSet rs = null;
   PreparedStatement pstmt = null;
   String dburl = "jdbc:mysql://localhost:3306/reserve_plane?useSSL=false";
   String dbuser = "root", dbpass = "hunter5268";
   
   String arrival=request.getParameter("arrival");// 1. 도착지
   String departure=request.getParameter("departure");// 2. 출발지
   String id=request.getParameter("user_id");// 3. 아이디
   
   String sql_query=new String(); // seattable 로부터 받아올 쿼리
   String query=new String(); // 이전 페이지에서 쓴 쿼리
   
   String transfer_page=request.getParameter("transfer_page");// retrieved or price_sort
   int selected_row=Integer.parseInt(request.getParameter("selected")); // 라디오 버튼으로 선택된 행 수
   String[] seat=new String[30]; //의자 배열 사용 값
   
   if(transfer_page.equals("price_sort"))
   {
	   query="select * from plane where ((departure_date=curdate() and departing_hour>=hour(curtime())) or departure_date>curdate()) and departure='"+departure+"' and arrival='"+arrival+"' order by price, departure_date, departing_hour, departing_minute";
   }
   else if(transfer_page.equals("retrieved"))
   {
	   query="select * from plane where ((departure_date=curdate() and departing_hour>=hour(curtime())) or departure_date>curdate()) and departure='"+departure+"' and arrival='"+arrival+"' order by departure_date, departing_hour, departing_minute";
   
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
	   
	    rs=stmt.executeQuery(query);
	
		for(int j=0;j<selected_row;j++)
		{
			rs.next();
		}
		String plane_no=rs.getString("plane_no"); //비행기명
		String departure_date=rs.getString("departure_date"); // 날짜
		String departing_hour=rs.getString("departing_hour"); // 시간
		sql_query="select * from seattable where plane_no='"+plane_no+"' and departure='"+departure+"' and arrival='"+arrival+"' and departure_date='"+departure_date+"' and departing_hour='"+departing_hour+"'";
		String airline=rs.getString("airline"); // 항공사
		String minutes=rs.getString("departing_minute"); //분
		String gate_no=rs.getString("gate_no"); //게이트 넘버
		String price=rs.getString("price"); //가격 
		
		rs=stmt.executeQuery(sql_query);
		
		if(rs.next())
		{
			for(int k=0;k<30;k++)
			{
				seat[k]=rs.getString(k+7);
			}
		}
		
		
		
	 %>
	 

	 <div style="height: 550px;"> </div>
	 
	<script>
	
	
	function reserve_check(id, airlines, plane, depart, arrive, date, hour ,minute, seat, gate,  cost)
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
		
		var URL = "reserve_chk.jsp?user_id= "+ user_id+"&airline= "+airline+"&plane_no= "+plane_no+"&departure= "+departure+"&arrival= "+arrival+"&departure_date= "+departure_date+"&departing_hour= "+departing_hour+"&departing_minute= "+departing_minute+"&seat_no= "+seat_no+"&gate_no= "+gate_no+"&price= "+price;
		var rtnVal = window.showModalDialog(URL, self, "dialogWidth:400; dialogHeight:100; help:no; status:no;");
	
	}
	
	</script>
	 
	
	 
   <table border="0"  cellspacing="0" cellpadding="2"  style="margin: auto; text-align: center; width:80%; " >
   
   <%
 		for(int i=0;i<5;i++)
 		{
   %>
   <tr>
   <% 			for(int j=0;j<3;j++)
	   			{									%>
  	
  	
  	 <td>	
  			<form name="form5" method="post" action="reserve_chk.jsp" >				
   <%
   					if(seat[number-1].equals("A"))
   					{
   	%>					
   						<input type="hidden" name="user_id" value=<%=id%> />
   						<input type="hidden" name="airline" value=<%=airline%> />
   						<input type="hidden" name="plane_no" value=<%=plane_no%> />
   						<input type="hidden" name="departure" value=<%=departure%> />
   						<input type="hidden" name="arrival" value=<%=arrival%> />
   						<input type="hidden" name="departure_date" value=<%=departure_date%> />
   						<input type="hidden" name="departing_hour" value=<%=departing_hour%> />
   						<input type="hidden" name="departing_minute" value=<%=minutes%> />
   						<input type="hidden" name="seat_no" value=<%=number%> />
   						<input type="hidden" name="gate_no" value=<%=gate_no%> />
   						<input type="hidden" name="price" value=<%=price%> />
   						<input type="image" src="images/seat2/<%=number%>aa.jpg" /> <!--  onclick="reserve_check(<%=id%>, <%=airline%>, <%=plane_no%>, <%=departure%>, <%=arrival%>, <%=departure_date%>, <%=departing_hour%>,<%=minutes%>,<%=number%> , <%=gate_no%>, <%=price%>);"  -->  
   						
	</form>   		
   		<%				
   					}
   					if(seat[number-1].equals("U"))
   					{
   %>
   						<img src="images/seat2/<%=number%>uu.jpg" style="width:50px; height: 50px;" />
   <%						
   					}
   					
   
   %>
   
   </td> 
    
   <%				number++;
   				}  							
   %>
   
   <td>
    &nbsp;  &nbsp; &nbsp; &nbsp;  
   
   </td>
   
   
   
   <% 
   				for(int j=0;j<3;j++)
	   			{									%>
  	
  	 <td>	
  				<form name="form6" method="post" action="reserve_chk.jsp" >	
   <%
   					if(seat[number-1].equals("A"))
   					{
   	%>					<input type="hidden" name="user_id" value=<%=id%> />
   						<input type="hidden" name="airline" value=<%=airline%> />
   						<input type="hidden" name="plane_no" value=<%=plane_no%> />
   						<input type="hidden" name="departure" value=<%=departure%> />
   						<input type="hidden" name="arrival" value=<%=arrival%> />
   						<input type="hidden" name="departure_date" value=<%=departure_date%> />
   						<input type="hidden" name="departing_hour" value=<%=departing_hour%> />
   						<input type="hidden" name="departing_minute" value=<%=minutes%> />
   						<input type="hidden" name="seat_no" value=<%=number%> />
   						<input type="hidden" name="gate_no" value=<%=gate_no%> />
   						<input type="hidden" name="price" value=<%=price%> />
   						<input type="image" src="images/seat2/<%=number%>aa.jpg"  /> <!-- onclick="reserve_check(<%=id%>, <%=airline%>, <%=plane_no%>, <%=departure%>, <%=arrival%>, <%=departure_date%>, <%=departing_hour%>,<%=minutes%>,<%=number%> , <%=gate_no%>, <%=price%>);"   --> 
   		
   		</form>  
   		<%				
   					}
   					if(seat[number-1].equals("U"))
   					{
   %>
   						<img src="images/seat2/<%=number%>uu.jpg" style="width:50px; height: 50px;" />
   <%						
   					}
   					
   
  %>
   
   </td> 
    
   <%				number++;
   				}  							
   %>
   </tr>
   <%
   		} 
   %>
   </table>
   <!-- 우리에게 필요한 것
   plane- airline, plane_no, departure, arrival, date, hour ,minute, avail_seat, gate_no, price
                                          
reserved-   user_id, airline, plane_no, departure, arrival, date, hour ,minute, seat_no, gate_no,  price
                v       v          v            v      v      v    v      v     v(number)     v    v
                       --> 
   </div>
</body>
</html>