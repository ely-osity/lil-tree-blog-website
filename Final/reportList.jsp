<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>投诉处理</title>
<script>
function isEmpty(s){
	if(s==null || s=="")	return true;
}
function check(form){//检查表单内容
	var error = "";
	var num = form.num.value.trim();
	if(isEmpty(num))
		error = error + "未填写必填项\n";
	if(error=="")	return true;
	else{
		alert(error);
		return false;
	}
}
</script>
</head>
<%
Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = "";
String num = "";
int tbrow = 0;//信息行数即时获取
int tbclm = 5;//总共5列
try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String password = "1";
	String dbname = "fianl";
	conn = DriverManager.getConnection(url, username, password);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	
	if(request.getParameter("submit")!=null){//提交表单，进行数据处理
		num = request.getParameter("num");
		task = "select count(*) from rptlist where rptNum = "+num+"";//检查编号是否正确
		rs=stmt.executeQuery(task);
		rs.next();
		if(rs.getInt(1)==0){//不正确
			out.print("请输入正确编号");
		}
		else{//正确
			if(request.getParameter("submit").equals("1")){//对该被举报的用户进行警告
				task = "update rptlist set flag = 1 where rptNum = "+num;//设flag为1
				stmt.execute(task);
				response.sendRedirect("reportList.jsp");//回到原页面刷新
				return;
			}
			else if(request.getParameter("submit").equals("2")){//举报不成立
				task = "select count(*) from rptlist where rptNum = '"+num+"' and flag = 1";//检查是否已发送警告
				rs=stmt.executeQuery(task);
				rs.next();
				if(rs.getInt(1)!=0){
					out.print("已警告！");//若已警告则不能判为不成立
				}
				else{//未警告过
					task = "delete from rptlist where rptNum = '"+num+"'";//将该举报信息删除
					stmt.execute(task);
					response.sendRedirect("reportList.jsp");//回到原页面刷新
					return;
				}
			}
		}
	}
	
	task = "select * from rptlist";
	rs = stmt.executeQuery(task);
}
catch(Exception e){
	out.print(e);
}


%>
<body>
<form id="form2" name="form1" method="post" action="mainPageAdmin.jsp">
  <label for="返回主页"></label>
  <input type="submit" name="返回主页" id="返回主页" value="返回" />
</form>
<table width="725" border="1">
  <tr>
    <th width="42" scope="row">编号</th>
    <td width="86">投诉人</td>
    <td width="89">投诉对象</td>
    <td width="371">违规行为</td>
    <td width="66">帖子编号</td>
    <td width="31">flag</td>
  </tr>
<%
for(int i=0; rs.next(); i++){//用循环即时输出所有投诉信息，帖子链接可以跳转
%>
	<tr>
    <th scope="row"><%=rs.getString(1)%></th>
    <td><%=rs.getString(2)%></td>
    <td><%=rs.getString(3)%></td>
    <td><%=rs.getString(4)%></td>
    <td><a href="post.jsp?rptlist=1&num=<%=rs.getString(5)%>"><%=rs.getString(5)%></a></td>
    <td><%=rs.getString(6)%></td>
  </tr>

<%}%>
</table>

<p>要进行警告的投诉编号：</p>
<form id="form1" name="form1" method="post" action="">
  <label for="id"></label>
  <input type="text" name="num" id="num" />
  <label for="button"></label>
  <input type="submit" name="button" id="button" onclick="return check(this.form)" value="警告" formaction="reportList.jsp?submit=1"/>
  <input type="submit" name="button2" id="button2" onclick="return check(this.form)" value="不成立" formaction="reportList.jsp?submit=2"/>
</form>
<p>&nbsp;</p>
</body>
</html>