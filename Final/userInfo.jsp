<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>网站用户信息</title>
</head>
<%
Statement stmt = null;
ResultSet rs = null;//获取用户信息
Statement stmtFlag = null;
ResultSet rsFlag = null;//获取警告次数
Connection conn = null;
String task = "";
int tbrow = 0;//用户数量即时查询
int tbclm = 9;//用户信息-密码+警告次数
try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String password = "1";
	String dbname = "fianl";
	conn = DriverManager.getConnection(url, username, password);
	stmt = conn.createStatement();
	stmtFlag = conn.createStatement();//举报次数的stmt

	task = "select count(*) from usif";
	rs = stmt.executeQuery(task);
	rs.next();
	tbrow = rs.getInt("count(*)");//查询用户数量
	task = "select * from usif";
	rs = stmt.executeQuery(task);//查询所有用户信息
}
catch(Exception e){
	out.print(e);
}

String usif[][] = new String[tbrow][tbclm];//创建要输出的用户信息二维数组
for(int i=0; i<tbrow; i++){
	rs.next();//每个用户（每行）信息录入
	for(int j=0; j<tbclm-1; j++){//usif里的信息录入
		if(j<3)	usif[i][j]=rs.getString(j+1);
		else 	usif[i][j]=rs.getString(j+2);//密码不显示，跳过
	}
	task = "select count(*) from rptlist where id = '"+usif[i][2]+"' and flag = 1";//查询id被警告的次数
	rsFlag = stmtFlag.executeQuery(task);
	rsFlag.next();
	usif[i][tbclm-1] = String.valueOf(rsFlag.getInt(1));//警告次数录入每行最后一项
}
%>
<body>
<form id="form1" name="form1" method="post" action="mainPageAdmin.jsp">
  <label for="返回主页"></label>
  <input type="submit" name="返回主页" id="返回主页" value="返回" />
</form>
<table width="679" border="1">
  <tr>
    <th width="38" scope="row">编号</th>
    <td width="133">邮箱</td>
    <td width="51">用户名</td>
    <td width="20">性别</td>
    <td width="82">手机</td>
    <td width="83">爱好</td>
    <td width="47">城市</td>
    <td width="113">自我简介</td>
    <td width="54">警告次数</td>
  </tr>
<%
for(int i=0; i<tbrow; i++){//用循环输出所有用户信息
	out.print("<tr>");//行标识
	for(int j=0; j<tbclm; j++){
		if(j==0)	out.print("<th scope=\"row\">"+usif[i][j]+"</th>");//编号列
		else		out.print("<td>"+usif[i][j]+"</td>");//打印每行数据
	}
	//out.print("<td>"++"</td>");
	out.print("</tr>");
}

%>
</table>
<p>&nbsp;</p>
</body>
</html>