<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录</title>
</head>
<%session.invalidate();//在登陆页确保session为空%>
<body>
<form id="form" name="form" method="post" action="logIn.jsp">
  <table width="368" height="149" border="0">
    <tr>
      <th width="60" height="27" align="left" scope="row">我是</th>
      <td width="298"><select name="identity" id="identity">
        <option value="user" selected="selected">用户</option>
        <option value="admin">管理员</option>
      </select></td>
    </tr>
    <tr>
      <th height="23" align="left" scope="row">邮箱</th>
      <td><input type="text" name="email" id="email" /></td>
    </tr>
    <tr>
      <th height="23" align="left" scope="row">密码</th>
      <td><input type="password" name="password" id="password" /></td>
    </tr>
    <tr>
      <th height="64" align="left" scope="row">&nbsp;</th>
      <td><p>
        <input type="submit" name="logIn" id="logIn" value="登录" />        
        <input type="submit" name="signUp" id="signUp" value="新用户注册" formaction="signUp.jsp?flag=1"/>
      </p>
      <p>&nbsp;
	  <%
	  if(request.getParameter("newuser")!=null)//注册成功
	  	out.print("注册成功！");
	  if(request.getParameter("errorE")!=null)
	  	out.print("邮箱已注册！");
	  if(request.getParameter("errorI")!=null)//注册失败的两种情况
	  	out.print("用户名已存在！");
	  if(request.getParameter("failed")!=null)//登录失败
	  	out.print("邮箱或密码错误。");
	  %> 
      </p></td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
</body>
</html>