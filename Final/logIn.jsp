<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>中转页</title>
</head>
<%
Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = null;

try{
	String id = "";
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	boolean identity = request.getParameter("identity").equals("user");//判断身份
	
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String pw = "1";
	String dbname = "final";
	conn = DriverManager.getConnection(url, username, pw);
	stmt = conn.createStatement();//连sql
	
	if(identity){//是用户
		task = "select count(*) from usif where email='" +email+ "' and password='"+password+"'";//检索匹配用户
		rs = stmt.executeQuery(task);
		int count = 0;
		if(rs.next())	count = rs.getInt(1);
		if(count>0){//有匹配
			task = "select id from usif where email='" +email +"'";
			rs = stmt.executeQuery(task);
			rs.next();
			id = rs.getString("id");
			HttpSession s=request.getSession();
			s.setAttribute("id",id);//获取id，存入session
			
			response.sendRedirect("mainPage.jsp");//跳转用户主页
			return;
		}
		else{//无匹配
			response.sendRedirect("logOrSign.jsp?failed=1");//跳转登录页，标记为失败
			return;
		}
	}
	else{//管理员
		task = "select count(*) from admin where aEmail='" +email+ "' and aPw='"+password+"'";
		rs = stmt.executeQuery(task);
		int count = 0;
		if(rs.next())	count = rs.getInt(1);//检索
		if(count>0){//有匹配
			task = "select id from admin where aEmail='" +email +"'";
			rs = stmt.executeQuery(task);
			rs.next();
			id = rs.getString("id");
			HttpSession s=request.getSession();
			s.setAttribute("id",id);//存session
			
			response.sendRedirect("mainPageAdmin.jsp");//跳转管理员主页
			return;
		}
		else{
			response.sendRedirect("logOrSign.jsp?failed=1");//跳转登陆页，标记为失败
			return;
		}
	}
}catch(Exception e){
	out.print(e);
}
%>
<body>
</body>
</html>