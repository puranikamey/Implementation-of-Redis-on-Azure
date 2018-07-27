<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"
	import="redis.clients.jedis.Jedis"
	import="redis.clients.jedis.JedisShardInfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Education data</title>
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
<h1>Amey Jayant Puranik</h1>
<h1>1001451390</h1>
	<%
long startTime = System.currentTimeMillis();

try{
  
   HashMap<String, String> scores = new HashMap<>();
  String Statename =  request.getParameter("state");
 
  boolean dd=true;
 JedisShardInfo shardInfo = new JedisShardInfo("perform.redis.cache.windows.net", 6380, dd);
 shardInfo.setPassword("FHtWVwQCBz41aiE8TXR7imQeswo9AroD2oTFGVDa2L8="); 
 out.println("Connected to Redis cache" + "<br/>");
 Jedis jedis = new Jedis(shardInfo);
 String uniqueid = jedis.get(Statename);
 
  if (uniqueid ==null )
     {
	 out.println("Getting data from the RDB as Cache is empty \r\n" + "<br/>");
	 jedis.set(Statename, Statename);
	 
	 
     try{
	 Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	 String connectionUrl = "jdbc:sqlserver://picsdata.database.windows.net:1433;database=picdataforapp;user=puranikamey@picsdata;password=Ameypuranik1234;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
	 Connection con = DriverManager.getConnection(connectionUrl);
	 out.println("Connected To RDB" + "<br/>");
	 PreparedStatement ps = con.prepareStatement("select OPEID, INSTNM, INSTURL From edu2 Where State= '"+ Statename + "'"  );
	 ResultSet rs = ps.executeQuery();
	
	  while (rs.next())
	    {    
		 int i=0;
		 int instid= rs.getInt("OPEID");
		 
		 String eid= String.valueOf(instid);
		 String Datainhashmap= rs.getString("INSTNM") + "     " + rs.getString("INSTURL") + "     " + String.valueOf(instid);
		 scores.put(Statename,Datainhashmap );
		 jedis.getSet(eid,scores.get(Statename));
		 out.println(Datainhashmap + "<br/>");
		 
	    }
		
	
     }
catch(Exception e){e.printStackTrace();}

 }
  else if (uniqueid !=null ){
	   
	  Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		 String connectionUrl = "jdbc:sqlserver://picsdata.database.windows.net:1433;database=picdataforapp;user=puranikamey@picsdata;password=Ameypuranik1234;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
		 Connection con = DriverManager.getConnection(connectionUrl);
		 out.println("Connected To RDB" + "<br/>");
		 PreparedStatement ps = con.prepareStatement("select OPEID From edu2 Where State= '"+ Statename + "'"  );
		 ResultSet rs = ps.executeQuery();
	  
	  out.println("Getting data from the redis cache "+ "<br/> <br/>");
	 
	  while(rs.next()){
		  int insid= rs.getInt("OPEID");
		String  keyid= String.valueOf(insid);
		  
		String rediscache = jedis.get(keyid);
		
		  out.println(rediscache + "<br/>");
	  }
  } 

}

catch(Exception e){e.printStackTrace();}


long stopTime = System.currentTimeMillis();
long elapsedTime = stopTime - startTime;


%>

<h3><%out.println("Time required to fetch records from the RDB "+ elapsedTime + " ms."); %></h3>

</body>
</html>