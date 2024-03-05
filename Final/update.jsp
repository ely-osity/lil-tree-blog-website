<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改个人信息</title>
</head>
<%
HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");
String varIds[]=new String[]{"password","number","hobby","city","cv"};//可更改的信息名单
String varId = "";//要更改的信息名
String varValue = "";//要更改的信息值
String task = "";
for(int i=0; i<5; i++){//遍历
	if(request.getParameter(varIds[i])!=null){//找出要改哪一项
		varId = varIds[i];//存名字
		varValue = request.getParameter(varIds[i]);//存值
		break;//打破循环
	}
	else	continue;
}
task = "update usif set " +varId+ "='"+varValue+"' where id = '" +id+ "'";//更新语句

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String pw = "1";
	String dbname = "final";
	conn = DriverManager.getConnection(url, username, pw);
	stmt = conn.createStatement();//连sql
	stmt.execute(task);//进行更新
}catch(Exception e){
	out.print(e);
}finally{
	response.sendRedirect("myInfo.jsp");//返回信息页
}
	
%>
<body>
</body>
</html>