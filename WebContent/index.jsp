<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.sql.*" import="redis.clients.jedis.JedisShardInfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search</title>
<style type="text/css">
.center {
	margin: auto;
	width: 50%;
	border: 3px solid green;
	padding: 10px;
}

body {
	background-color: lightblue;
}

input {
	width: 100%;
}
</style>
</head>
<body>
<h1>wassup</h1>
<form action="display.jsp" method="post">

Enter the lat:  <input type="text" id="myFile" name="lat1">
Enter the lat : <input type="text" id="myFile" name="lat2">
<input type="submit" value="Pull out records">

</form>
</body>
</html>