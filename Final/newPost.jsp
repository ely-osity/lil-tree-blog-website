<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*, java.util.*, java.text.SimpleDateFormat" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新建帖子</title>
</head>
<%
if(request.getParameter("submit")!= null){//如果点击提交后跳转此界面，则执行录入语句

HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");//session获取id
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String time = df.format(new java.util.Date());//获取当前日期

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = null;

String title = request.getParameter("title");
String content = request.getParameter("content");//获取标题和内容
String num = "";

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String password = "1";
	String dbname = "fianl";
	conn = DriverManager.getConnection(url, username, password);
	stmt = conn.createStatement();
	
	task = "insert into board(id, title, content, time)"+
			"values('"+id+"', '"+title+"', '"+content+"', '"+time+"')";//插入数据库
	stmt.execute(task);
	
	task = "select num from board where id='"+id+"' and time='"+time+"'";//获取新生成的帖子编号，用于生成详情页
	rs = stmt.executeQuery(task);
	rs.next();
	num = String.valueOf(rs.getInt(1));
}catch(Exception e){
	throw(e);
}
response.sendRedirect("post.jsp?num="+num);
}//if
%>
<body>
<form id="form1" name="form1" method="post" action="newPost.jsp?submit=1">
  <table width="415" border="1">
    <tr>
      <th width="52" align="right" valign="top" scope="row">标题</th>
      <td width="347"><input type="text" name="title" id="title" /></td>
    </tr>
    <tr valign="top">
      <th height="199" align="right" scope="row">内容</th>
      <td><textarea name="content" id="content" cols="45" rows="5"></textarea></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <p>
    <label for="content"></label>
  </p>
  <p>
    <label for="button"></label>
    <input type="submit" name="button" id="button" value="提交" />
  </p>
</form>
</body>
</html>