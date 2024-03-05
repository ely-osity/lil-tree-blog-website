<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>编辑资料</title>
</head>
<script>
function isEmpty(s){
	if(s==null || s=="")	return true;
}
function check(form){//检查密码格式函数
	var error = "";
	var password = form.password.value;
	var checkP = /^.{6,16}$/;
	
	if(isEmpty(password))
		error = error + "密码不能为空\n";
	if(!checkP.test(password))
		error = error + "密码格式错误\n";
	if(error=="")	return true;
	else{
		alert(error);
		return false;
	}
}
</script>
<%
HttpSession s=request.getSession();
String str[] = (String[])s.getAttribute("str");//用session获取当前用户信息，不可更改的直接显示
%>
<body>
<form id="form6" name="form6" method="post" action="myInfo.jsp">
  <label for="button5"></label>
  <input type="submit" name="button5" id="button5" value="返回" />
</form>
<table width="710" height="376" border="0">
  <tr>
    <td width="94" align="right" valign="top" scope="row">会员邮箱：</td>
    <td width="200" valign="top"><%=str[0]%></td>
    <td width="42" valign="top">&nbsp;</td>
    <td width="356" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" valign="top" scope="row">会员名：</td>
    <td valign="top"><%=str[1]%></td>
    <td valign="top">&nbsp;</td>
    <td valign="top">&nbsp;</td>
  </tr>
  <form id="form1" name="form1" method="post" action="update.jsp">
  <tr>
    <td align="right" valign="top" scope="row">新密码：</td>
    <td valign="top">
      <label for="text"></label>
      <input type="text" style="width:200px" maxlength="50" name="password" id="password" /></td>
    <td valign="top"><label for="button">
      <input type="submit" name="button" id="button4" value="提交" onclick="return check(this.form);"/>
    </label></td>
    <td valign="top"><span style="color:red">*</span>密码请设置6-16位字符</td>
  </tr>
  </form>
  <tr>
    <td height="21" align="right" valign="top" scope="row">性别：</td>
    <td valign="top"><p><%=str[3]%><br />
    </p></td>
    <td valign="top">&nbsp;</td>
    <td valign="top">&nbsp;</td>
  </tr>
  <form id="form2" name="form2" method="post" action="update.jsp">
  <tr>
    <td align="right" valign="top" scope="row">联系电话：</td>
    <td valign="top"><label for="text"></label>
      <input type="text" style="width:200px" maxlength="50" name="number" id="number" /></td>
    <td valign="top"><input type="submit" name="button" id="button2" value="提交" /></td>
    <td valign="top">&nbsp;</td>
  </tr>
  </form>
  <form id="form3" name="form3" method="post" action="update.jsp">
  <tr>
    <td align="right" valign="top" scope="row">兴趣爱好：</td>
    <td valign="top"><p>
      <label for="textarea"></label>
      <textarea name="hobby" style="width:200px" cols="45" rows="3" id="hobby"></textarea>
      <br />
    </p></td>
    <td valign="top"><label for="button"></label>
      <input type="submit" name="button" id="button" value="提交" /></td>
    <td valign="top">&nbsp;</td>
  </tr>
  </form>
  <form id="form4" name="form4" method="post" action="update.jsp">
  <tr>
    <td align="right" valign="top" scope="row">所在城市：</td>
    <td valign="top"><label for="city"></label>
      <label for="textfield"></label>
      <input type="text" name="city" id="city" /></td>
    <td valign="top"><label for="button"></label>
      <input type="submit" name="button" id="button" value="提交" /></td>
    <td valign="top">&nbsp;</td>
  </tr>
  </form>
  <form id="form5" name="form5" method="post" action="update.jsp">
  <tr>
    <td align="right" valign="top" scope="row">个人介绍：</td>
    <td valign="top"><textarea name="cv" style="width:200px" cols="45" rows="3" id="cv"></textarea></td>
    <td valign="top"><label for="button"></label>
      <input type="submit" name="button" id="button3" value="提交" /></td>
    <td valign="top">&nbsp;</td>
  </tr>
  </form>
</table>
<p>&nbsp;</p>
</body>
</html>