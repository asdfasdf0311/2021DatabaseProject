<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body {
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	font-family: 'Jeju Gothic', sans-serif;
	background-image: url('./bg_img.jpg');
	background-repeat: no-repeat;
	background-attachment: scroll;
	background-size: cover;
	margin: 0;
}
div#img {
	
	padding: 15px;
	
	opacity: 0.85;
	
}
div#insert {
	
	padding: 15px;
	border-radius: 15px;
}
<!-- background-color: #c2e5fa; 
opacity: 0.7; -->
</style>
<title>main page</title>
</head>
<body style="font-family: 'Jeju Gothic', sans-serif;
	background-image: url('./bg_img.jpg');
	background-repeat: no-repeat;
	background-size: cover;
	margin: 0;">
<div id="img">
<img src="logo.png" width=100% >
</div>
<form action="info_print.jsp" method="post">


<div id="insert" align="center" >
   <font size="5">  <b>  <br>  ID 입력 <br><br>    </b> </font>
   <select name="reserve_list" >
      <option value="reserveTable">예약 현황 보기</option>
      <option value="reserving">예약 진행</option>
   </select>
   <input type="text" name="user_id" required />
   <input type="submit" value="검색"/>
   <br>
</div>
<div id="img" align="center">
<img src="mainplane1.png" width="100%" height="100%">
</div>
<div id="img" align="center">
<!--  <img src="main_3.png" width="90%" height="35%">  -->
</div>
</form>

<br><br>

<!-- <h1>Main Page^^ </h1>-->


</body>
</html>