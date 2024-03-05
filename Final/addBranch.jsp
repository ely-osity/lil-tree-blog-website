<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加日志</title>
</head>

<body>
<form id="form1" name="form1" method="post" action="">
  <p>
    <label for="year"></label>
    <label for="month"></label>
    <input name="year" type="text" id="textfield2" size="4" maxlength="4" />
年
<label for="date"></label>
    <input name="month" type="text" id="textfield4" size="2" maxlength="2" />
    月
    <label for="textfield5"></label>
    <input name="date" type="text" id="textfield5" size="2" maxlength="2" />
    日
  </p>
  <p>
    <label for="title"></label>
    <input type="text" name="title" id="title" />
  </p>
  <p>
    <label for="journal"></label>
    <textarea name="journal" id="journal" cols="45" rows="5"></textarea>
  </p>
  <p>
    <label for="button"></label>
    <input type="submit" name="button" id="button" value="提交" formaction="addBranch.jsp?submit=1"/>
  </p>
</form>
</body>
<%
if(request.getParameter("submit")==null)	return;//submit空，代表从主页跳转来还未填写信息，不进行下面代码

HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");//session获取id

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = null;
String date = request.getParameter("year")+"-"
				+request.getParameter("month")+"-"
				+request.getParameter("date");
String title = request.getParameter("title");
String journal = request.getParameter("journal");

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String pw = "1";
	String dbname = "final";
	conn = DriverManager.getConnection(url, username, pw);
	stmt = conn.createStatement();//连sql
	
	task = "select count(*) from timeline where id = '"+id+"' and date = '"+date+"'";
	rs=stmt.executeQuery(task);
	rs.next();
	if(rs.getInt(1)>0){//检查是否已传过相同日期的日志
		out.print("该日期已有日志！");
	}
	else{//不撞车，存入
		task = "insert into timeline values ('"+id+"','"+date+"','"+title+"','"+journal+"')";
		stmt.execute(task);
		response.sendRedirect("timeline.jsp");//返回日志小树
		return;
	}
}
catch(Exception e){
	out.print("日期输入错误，请重试！");
}
%>
</html>