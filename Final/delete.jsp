<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>删除</title>
</head>
<%
HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");//session获取当前id，确保是自己删除自己的内容
if(s.getAttribute("admin")!=null)	id=(String)s.getAttribute("postId");//管理员可以删除所有
String date = request.getParameter("date");
String type = request.getParameter("type");//区分删除的是日志还是帖子

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = "";

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String password = "1";
	String dbname = "fianl";
	conn = DriverManager.getConnection(url, username, password);
	stmt = conn.createStatement();
	if(type.equals("1"))//从日志中删除
		task = "delete from timeline where id = '"+id+"' and date = '"+date+"'";
	else if(type.equals("2"))//从讨论版中删除
		task = "delete from board where id = '"+id+"' and time = '"+date+"'";
	stmt.execute(task);
}catch(Exception e){
	throw(e);
}
if(type.equals("1")){//删除的是日志只会返回日志页
	response.sendRedirect("timeline.jsp");
}
else{//删除的是留言帖
	String back = "";
	if(request.getParameter("myinfo")!=null)
		back="board.jsp?myinfo=1&mine=1";//返回我的帖子页
	else if(request.getParameter("rptlist")==null)
		back="board.jsp";//返回主页
	else
		back="reportList.jsp";//返回举报信息页
	response.sendRedirect(back);
}//返回相应网址
%>
<body>
</body>
</html>