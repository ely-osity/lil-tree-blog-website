<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人信息</title>
</head>
<%
HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");//session获取id
String[] str = new String[]{"","","","","","","","",""};//信息值字符串数组，顺序已经固定

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = "";
int rpt = 0;//收到的警告数量
try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String password = "1";
	String dbname = "final";
	conn = DriverManager.getConnection(url, username, password);
	stmt = conn.createStatement();
	task = "select * from usif where id = '" +id+ "'";
	rs = stmt.executeQuery(task);
	rs.next();
	for(int i=0; i<8; i++){
		if(rs.getString(i+2)==null)	str[i]="无";
		else	str[i]=rs.getString(i+2);
	}
	s.setAttribute("str", str);//用session传参，信息编辑页用
	
	task = "select count(*) from rptlist where postId = '"+id+"' and flag = 1";//查询id被举报并确认被警告的次数
	rs = stmt.executeQuery(task);
	rs.next();
	rpt = rs.getInt(1);//存rpt
		
}
catch(Exception e){
	out.print(e);
}
%>

<script>
function check(form){//检查密码是否正确
	var password = <%=str[2]%>;//字符串数组第三个是密码
	var input = form.pw.value.trim();
	if(password==input)	return true;
	else{
		alert("密码输入错误！");//不正确就弹窗
		return false;
	}
}
</script>

<body>
<form id="form2" name="form2" method="post" action="">
  <input type="submit" name="button2" id="button2" value="返回主页" formaction="mainPage.jsp"/>
  <input type="submit" name="button3" id="button3" value="我的帖子" formaction="board.jsp?myinfo=1&mine=1"/>
</form>
<p>
<%
if(rpt>0)	out.print("您收到了"+String.valueOf(rpt)+"次警告");//如果警告次数不为0就显示
%>
</p>
<table width="379" border="1">
  <tr>
    <th width="113" scope="row">邮箱</th>
    <td width="250"><%=str[0]%></td>
  </tr>
  <tr>
    <th scope="row">用户名</th>
    <td><%=str[1]%></td>
  </tr>
  <tr>
    <th scope="row">性别</th>
    <td><%=str[3]%></td>
  </tr>
  <tr>
    <th scope="row">电话</th>
    <td><%=str[4]%></td>
  </tr>
  <tr>
    <th scope="row">爱好</th>
    <td><%=str[5]%></td>
  </tr>
  <tr>
    <th scope="row">所在城市</th>
    <td><%=str[6]%></td>
  </tr>
  <tr>
    <th scope="row">自我简介</th>
    <td><%=str[7]%></td>
  </tr>
</table>
<form id="form1" name="form1" method="post" action="editInfo.jsp">
  <p>输入密码修改资料
：
    <input type="password" name="pw" id="pw" />
    <label for="button"></label>
    <input type="submit" name="button" id="button" value="提交" onclick="return check(this.form);"/>
  </p>
  <p>
    <label for="button2"></label>
  </p>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>