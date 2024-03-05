<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>主页</title>
</head>
<%
HttpSession s=request.getSession();
String id = (String)s.getAttribute("id");//session获取id
%>

<body>
<form id="form1" name="form1" method="post" action="">
  <p>
    <input type="submit" name="logoff" id="logoff" value="退出登录" formaction="logOrSign.jsp"/>
</p>
<p>---------------------------------------&gt;&gt;您好，<%=id%>-------------------------------------------^_^</p>
<table width="598" border="0">
  <tr>
    <td width="141">&nbsp;</td>
    <td width="300" align="center"><input type="submit" name="button" id="button" value="日志小树" formaction="timeline.jsp"/></td>
    <td width="143">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center"><input type="submit" name="button2" id="button2" value="账号信息" formaction="myInfo.jsp"/></td>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center"><input type="submit" name="button3" id="button3" value="留言区" formaction="board.jsp"/></td>
    <td>&nbsp;</td>
    </tr>
</table>
<p>&nbsp;</p>
  <p>&nbsp;</p>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>