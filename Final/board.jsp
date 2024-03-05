<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>留言区</title>
</head>
<%
HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");//获取使用者id
String back = "";//返回键跳转的超链接
String post = "post.jsp?num=";//留言帖页面的url
int flag = 0;//标志是否是个人信息页面跳转来的
if(request.getParameter("myinfo")!=null){//从个人信息跳转来
	back="myInfo.jsp";
	post="post.jsp?myinfo=1&num=";
	flag = 1;
}
else if(s.getAttribute("admin")==null) back = "mainPage.jsp";//从用户主页跳转来
else back = "mainPageAdmin.jsp";//从管理员主页跳转来

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
	task = "select num, id, title, time from board";//获取编号、发帖用户名、题目、发帖时间
	if(request.getParameter("mine")!=null)//是否为只看自己帖子界面
		task = task + " where id = '"+id+"'";//只查找本id的帖子
	task = task + " order by time desc";//时间降序，最新在最上方
	rs = stmt.executeQuery(task);
		
%>
<body>
<form id="form1" name="form1" method="post" action="">
  <p>
    <input type="submit" name="button2" id="button" value="返回" formaction="<%=back%>"/>
    <%if(flag==0){//从个人页跳转时不显示以下三个按钮%>
    <input type="submit" name="button3" id="button3" value="发布帖子" formaction="newPost.jsp"/>
    <input type="submit" name="button" id="button2" value="只看我的" formaction="board.jsp?mine=1"/>
    <input type="submit" name="button" id="button2" value="全部帖子" formaction="board.jsp"/>
    <%}%>
  </p>
</form>

<table width="539" border="1">
  <tr>
    <td width="33">编号</td>
    <td width="79" height="23">发帖人</td>
    <td width="155">标题</td>
    <td width="200">时间</td>
    <td width="38"></td>
  </tr>
<%//循环输出表格，在每行最末超链接跳转帖子
for(int i=1; rs.next(); i++){
	out.print("<tr>");
	out.print("<td>"+i+"</td>");//显示出的帖子编号是实时顺序，不是数据库里的
	for(int j=2; j<5; j++)
		out.print("<td>"+rs.getString(j)+"</td>");
%>
	<td bgcolor="#12F100"><a href="<%=post+rs.getString(1)%>">查看</a></td>
<%
	out.print("</tr>");
	}
}catch(Exception e){
	throw(e);
}
%>
</table>
</body>
</html>