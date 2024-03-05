<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册</title>
</head>
<%request.setCharacterEncoding("utf-8");%>
<script>
function isEmpty(s){
	if(s==null || s=="")	return true;
}
function check(form){
	var error = "";//报错语句
	
	var email = form.email.value.trim();
	var checkE = /^[\w-]+@([\w-]+\.)+[a-zA-Z]{2,4}$/;
	
	var id = form.id.value.trim();
	var checkI = /^[a-zA-Z_]\w{0,9}$/;
	
	var password = form.password.value.trim();
	var passwore = form.passwore.value.trim();
	var checkP = /^.{6,16}$/;
	
	if(isEmpty(email)||isEmpty(id)||isEmpty(password)||isEmpty(passwore))//进行检查
		error = error + "未填写必填项\n";
	if(!checkE.test(email))
		error = error + "邮箱格式错误\n";
	if(!checkI.test(id))
		error = error + "用户名格式错误\n";
	if(!checkP.test(password))
		error = error + "密码格式错误\n";
	if(!password==passwore)
		error = error + "密码输入不一致\n";
	
	if(error=="")	return true;//报错语句为空，内容格式和两次密码输入无错误
	else{
		alert(error);//有错误，弹窗
		return false;
	}
}
</script>
<body>
<form id="form" name="form" method="post" action="signUp.jsp">
  <table width="827" height="406" border="0">
    <tr>
      <td width="106" align="right" valign="top" scope="row">会员邮箱：</td>
      <td width="210" valign="top"><label for="email4"></label>
        <input name="email" type="text" style="width:200px" maxlength="50" id="email"/></td>
      <td width="497" valign="top"><span style="color:red">*</span>请输入有效的邮箱地址</td>
    </tr>
    <tr>
      <td align="right" valign="top" scope="row">会员名：</td>
      <td valign="top"><label for="id"></label>
      <input type="text" style="width:200px" maxlength="50" name="id" id="id" /></td>
      <td valign="top"><span style="color:red">*</span>字母数字下划线1到10位，不能是数字开头</td>
    </tr>
    <tr>
      <td align="right" valign="top" scope="row">密码：</td>
      <td valign="top"><label for="password"></label>
      <input type="password" style="width:200px" maxlength="50" name="password" id="password" /></td>
      <td valign="top"><span style="color:red">*</span>密码请设置6-16位字符</td>
    </tr>
    <tr>
      <td align="right" valign="top" scope="row">重复密码：</td>
      <td valign="top"><label for="codere"></label>
        <input type="password" style="width:200px" maxlength="50" name="passwore" id="passwore" /></td>
      <td valign="top"><span style="color:red">*</span></td>
    </tr>
    <tr>
      <td height="51" align="right" valign="top" scope="row">性别：</td>
      <td valign="top"><p>
        <label>
          <input type="radio" name="gender" value="男" id="gender_0" />
          男</label>
        <br />
        <label>
          <input type="radio" name="gender" value="女" id="gender_1" />
          女</label>
        <br />
      </p></td>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr>
      <td align="right" valign="top" scope="row">联系电话：</td>
      <td valign="top"><label for="number"></label>
      <input type="text" style="width:200px" maxlength="50" name="number" id="number" /></td>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr>
      <td align="right" valign="top" scope="row">兴趣爱好：</td>
      <td valign="top"><p>
        <label for="hobby"></label>
        <textarea name="hobby" id="hobby" style="width:200px" cols="45" rows="3"></textarea>
        <br />
      </p></td>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr>
      <td align="right" valign="top" scope="row">所在城市：</td>
      <td valign="top"><label for="city"></label>
        <select name="city" id="city">
          <option value="北京">北京</option>
          <option value="天津" selected="selected">天津</option>
          <option value="石家庄">石家庄</option>
          <option value="太原">太原</option>
          <option value="呼和浩特">呼和浩特</option>
          <option value="哈尔滨">哈尔滨</option>
          <option value="成都">成都</option>
          <option value="上海">上海</option>
          <option value="三亚">三亚</option>
      </select></td>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr>
      <td align="right" valign="top" scope="row">个人介绍：</td>
      <td valign="top"><textarea name="cv" id="cv" style="width:200px" cols="45" rows="3"></textarea></td>
      <td valign="top">&nbsp;</td>
    </tr>
  </table>

  <p>
    &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
    <input type="submit" name="login" id="login" value="同意并提交" onclick="return check(this.form);"
    style= "color:#F0FFFF;background-color:purple;width:100px;height:30px;"/>
    &lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;
  </p>
</form>
</body>
<%
if(request.getParameter("flag")!=null)	return;//flag不空代表从主页跳转来还未填写信息，不进行下面代码

Statement stmt = null;
ResultSet rs = null;
Connection conn = null;
String task = null;

try{
	String email = request.getParameter("email");
	String id = request.getParameter("id");
	
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/final";
	String username= "root";
	String pw = "1";
	String dbname = "final";
	conn = DriverManager.getConnection(url, username, pw);
	stmt = conn.createStatement();//连sql
	
	int errE = 0;
	int errI = 0;//两个错误标志变量
	task = "select count(*) from usif where email = '"+email+"'";//检查邮箱是否已存在
	rs = stmt.executeQuery(task);
	rs.next();
	if(rs.getInt(1)>0)	errE = 1;
	task = "select count(*) from usif where id = '"+id+"'";//检查用户名是否已存在
	rs = stmt.executeQuery(task);
	rs.next();
	if(rs.getInt(1)>0)	errI = 1;
	
	String errStr = "";//报错语句
	if(errE*errI==1)	errStr = "&";
	if(errE==1)	errStr = "errorE=1"+errStr;//邮箱已存在
	if(errI==1)	errStr = errStr+"errorI=1";//用户名已存在
	if(!errStr.equals("")){//报错语句不为空，则直接跳转主页，进行错误提示
		response.sendRedirect("logOrSign.jsp?"+errStr);
		return;
	}
	
	task = "insert into usif (email) values ('" +email+ "')";//无错误，用户信息加入数据库，初始只有邮箱
	stmt.execute(task);
	Enumeration pNames=request.getParameterNames();//获取表单中所有变量名
	while(pNames.hasMoreElements()){//遍历所有信息变量
   		String name=(String)pNames.nextElement();//数据库语句要用的列名变量
		if(name.equals("passwore")||name.equals("login"))	continue;//如果是重复输入密码或按钮的值就略过
   		String value[] = request.getParameterValues(name);//存信息值，同名变量值数组（爱好是多选框）
		String values = "";//同名变量字符串
		for(int i=0;i<value.length;i++){
			if(i>0)	values = values+",";//如果有超过一个变量，在中间用逗号隔开
			values = values+value[i];
		}
		task = "update usif set " +name+ "='" +values+ "' where email='" +email+ "'";
		stmt.execute(task);//轮流更新
	}
	response.sendRedirect("logOrSign.jsp?newuser=1");//注册成功返回登录页，标志为注册成功
}
catch(Exception e){
	out.print(e);
}
%>

</html>