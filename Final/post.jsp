<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>帖子内容</title>
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
String id = (String)s.getAttribute("id");//session获取当前用户id

String num = request.getParameter("num");
s.setAttribute("postNum", num);//存帖子编号，举报页用

String postId = "";//发帖id，删除和举报用
String date = "";//发帖时间，删除用、

String dltUrl="";//删除页url
String backUrl = "";//返回页面的url
if(request.getParameter("myinfo")!=null){
	backUrl="board.jsp?myinfo=1&mine=1";//返回我的帖子页
	dltUrl="delete.jsp?myinfo=1&type=2&date=";
}
else if(request.getParameter("rptlist")==null){
	backUrl="board.jsp";//返回主页
	dltUrl="delete.jsp?type=2&date=";
}
else{
	backUrl="reportList.jsp";//返回举报信息页
	dltUrl="delete.jsp?rptlist=1&type=2&date=";
}

String info[] = new String[5];
info[0] = num;

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = null;

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String password = "1";
	String dbname = "fianl";
	conn = DriverManager.getConnection(url, username, password);
	stmt = conn.createStatement();
	
	task = "select count(*) from board where num = "+num+"";//根据帖子编号找到帖子信息
	rs = stmt.executeQuery(task);
	rs.next();
	if(rs.getInt(1)==0){//查询无结果
%>
<form id="form3" name="form3" method="post" action="">
  <input type="submit" name="button" id="button4" value="返回" formaction="<%=backUrl%>"/>
</form>
<%		out.print("页面不存在或已被删除！");
		return;
	}
	task = "select * from board where num = "+num+"";//根据帖子编号找到帖子信息
	rs = stmt.executeQuery(task);
	rs.next();
	postId = rs.getString(2);
	date = rs.getString(5);
	s.setAttribute("postId", postId);//发帖人ID存入session，可传给举报页
}catch(Exception e){
	throw(e);
}
%>
<body>
<form id="form2" name="form2" method="post" action="">
  <input type="submit" name="button" id="button3" value="返回" formaction="<%=backUrl%>"/>
</form>
<table width="367" height="207" border="1">
  <tr>
    <th width="85" height="23" scope="row">发帖时间</th>
    <td width="266"><%=date%></td>
  </tr>
  <tr>
    <th height="23" scope="row">发帖人</th>
    <td><%=rs.getString(2)%></td>
  </tr>
  <tr>
    <th height="23" scope="row">标题</th>
    <td><%=rs.getString(3)%></td>
  </tr>
  <tr>
    <th valign="top" scope="row">内容</th>
    <td valign="top"><%=rs.getString(4)%></td>
  </tr>
</table>
<p>&nbsp;</p>
<form id="form1" name="form1" method="post" action="">
<%
if(!id.equals(postId) && s.getAttribute("admin")==null){//非本人且非管理员查看帖子，有投诉选项
%>
  <label for="button"></label>
  <label for="投诉"></label>
  <input type="submit" name="button2" id="button" value="投诉此帖" formaction="report.jsp"/>
<%
}
if(id.equals(postId) || s.getAttribute("admin")!=null){//本人或管理员查看帖子，有删除选项
%>
  <label for="button2"></label>
  <input type="submit" name="button2" id="button2" value="删除帖子" onclick="return dltcfm()"
  formaction="<%=dltUrl+date%>"/>
</form>
<%}%>
<p>&nbsp;</p>
</body>
</html>