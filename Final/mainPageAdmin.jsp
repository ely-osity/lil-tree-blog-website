<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员主页</title>
</head>
<%HttpSession s=request.getSession();
s.setAttribute("admin", "1");
String id = (String)s.getAttribute("id");//session获取id
%>
<body>
<form id="form1" name="form1" method="post" action="">
  <label for=""></label>
  <input name="button2" type="submit" id="button2" value="退出登录" formaction="logOrSign.jsp"/>
<p>---------------------------------------&gt;&gt;您好，<%=id%>管理员-------------------------------------------^_^</p>
<table width="598" border="0">
  <tr>
    <td width="141">&nbsp;</td>
    <td width="300" align="center"><input type="submit" name="button5" id="button5" value="用户信息" formaction="userInfo.jsp"/></td>
    <td width="143">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center"><input type="submit" name="button4" id="button4" value="投诉处理" formaction="reportList.jsp"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center"><input name="button" type="submit" id="button" value="留言区" formaction="board.jsp"/></td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>