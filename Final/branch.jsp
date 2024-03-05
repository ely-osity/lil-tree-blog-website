<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>日志内容</title>
</head>
<script>
function dltcfm() {
if (!confirm("确认要删除？")){
	return false;
	}
}
</script>
<%
HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");//session获取id
String date = request.getParameter("date");
String dlt = "delete.jsp?type=1&date="+date;

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = "";

String title = "";
String journal = "";

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String password = "1";
	String dbname = "fianl";
	conn = DriverManager.getConnection(url, username, password);
	stmt = conn.createStatement();//
	task = "select title, journal from timeline where id = '"+id+"' and date = '"+date+"'";
	rs = stmt.executeQuery(task);//根据id和日期获取日志题目和内容
	rs.next();
	title = rs.getString(1);
	journal = rs.getString(2);
}catch(Exception e){
	throw(e);
}
%>
<body>
<table width="374" border="1">
  <tr>
    <th width="34" scope="row">日期</th>
    <td width="324"><%=date%></td>
  </tr>
  <tr>
    <th scope="row">标题</th>
    <td><%=title%></td>
  </tr>
  <tr>
    <th valign="top" scope="row">内容</th>
    <td height="300" valign="top"><%=journal%></td>
  </tr>
</table>
<form id="form1" name="form1" method="post" action="">
  <label for=""></label>
  <input type="submit" name="button" id="button" value="返回" formaction="timeline.jsp"/>
  <label for="button"></label>
  <input type="submit" name="button2" id="button2" value="删除" onclick="return dltcfm();" formaction="<%=dlt%>"/>
</form>
<p>&nbsp;</p>
</body>
</html>