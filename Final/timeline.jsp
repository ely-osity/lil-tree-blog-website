<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>日志小树</title>
<style type="text/css">
<!--
td {
	text-align: center;
	color: #FFF;
}
-->
</style>
</head>
<%
HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");//session获取id

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = "";
String num = "";
int length = 0;//记录数即时获取
try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String password = "1";
	String dbname = "fianl";
	conn = DriverManager.getConnection(url, username, password);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);//设为可前后滚动的
	task = "select date, title from timeline where id = '"+id+"' order by date desc";//降序获取日期
	rs = stmt.executeQuery(task);
	rs.last();
	length = rs.getRow();//获取记录数目
	rs.beforeFirst();
%>
<body>
<form id="form1" name="form1" method="post" action="">
  <p>
    <label for="button"></label>
    <input type="submit" name="button2" id="button2" value="返回" formaction="mainPage.jsp"/>
    <input type="submit" name="button" id="button" value="创建新日志" formaction="addBranch.jsp"/>
    <label for="button2"></label>
  </p>
</form>
<table border="0">
  <tr>
    <td width="200" height="45" bgcolor="#009900">&nbsp;</td>
    <td width="100" height="45" color=\"#FFF\" bgcolor="#993300">&nbsp;</td>
    <td width="200" height="45" bgcolor="#009900">&nbsp;</td>
  </tr>
<%
	boolean flag = length%2==0;//判断总数是否偶,偶数->最顶树叶在左，反之在右，保证根部叶子位置不变
	
	String frnt = "<td height=\"35\" bgcolor=\"#009900\"><a href=\"branch.jsp?date=";//颜色+超链接
	String mdl = "\">";//中间
	String bck = "</a></td>";//尾部
	
	String noLeaf = "<td height=\"35\">&nbsp;</td>";//无填充的格
	
	for(int i=0; rs.next(); i++){//循环长树
		out.print("<tr>");//行标识
		String leaf = frnt+rs.getString(1)+mdl+rs.getString(1)+bck;//有填充的格，颜色+日期
		out.print(flag ? leaf:noLeaf);//左边长树叶/不长
		out.print("<td height=\"35\" color=\"#FFF\" bgcolor=\"#993300\">"+rs.getString(2)+"</td>");//树干，颜色+标题
		out.print(flag ? noLeaf:leaf);//右边长树叶/不长
		flag = !flag;
	}
}catch(Exception e){
	throw(e);
}
%>
  <tr>
    <td height="45">&nbsp;</td>
    <td height="45" bgcolor="#993300">&nbsp;</td>
    <td height="45">&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>