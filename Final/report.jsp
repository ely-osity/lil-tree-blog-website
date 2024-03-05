<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>举报不良行为</title>
</head>
<script>
function isEmpty(s){
	if(s==null || s=="")	return true;
}
function check(form){//检查表单内容
	var error = "";
	var rsn = form.rsn.value.trim();
	if(isEmpty(rsn))
		error = error + "未填写必填项\n";
	if(error=="")	return true;
	else{
		alert(error);
		return false;
	}
}
</script>
<body>
<%
HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");
String postNum = (String)s.getAttribute("postNum");//生成帖子链接
String postId = (String)s.getAttribute("postId");//接受session传来的帖子编号和发帖人id

if(request.getParameter("submit")==null){//未提交时界面
%>
<form action="report.jsp?submit=1" method="post" name="form1" id="form1">
  <p>
    <label for="textarea"></label>
  投诉原因</p>
  <p>
  <textarea name="rsn" id="rsn" cols="45" rows="5"></textarea>
  </p>
  <p>
    <label for="button"></label>
    <input type="submit" name="button" id="button" onclick="return check(this.form);" value="提交" />
    <input type="submit" name="button4" id="button4" value="返回交流区" formaction="board.jsp"/>
  </p>
</form>
<p>
<%
}
else{//提交后信息检查+录入
	Statement stmt = null;
	ResultSet rs = null;
	Connection conn = null;
	String task = null;

	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/final";
		String username= "root";
		String pw = "1";
		String dbname = "final";
		conn = DriverManager.getConnection(url, username, pw);
		stmt = conn.createStatement();//连sql
		
		postId = "'"+postId+"',";
		id = "'"+id+"',";
		String rsn = "'"+request.getParameter("rsn")+"',";
		postNum = "'"+postNum+"'";//信息用方便写sql语句的方式保存
		task = "insert into rptlist (postId, id, rsn, postNum) values ("+postId+id+rsn+postNum+")";//存入数据库
		stmt.execute(task);
		out.print("已提交");
%>
<form id="form2" name="form2" method="post" action="">
  <label for="button2"></label>
  <input type="submit" name="button3" id="button3" value="返回交流区" formaction="board.jsp"/>
</form>
<%
	}catch(Exception e){
		throw(e);
	}
}
%>
</body>
</html>