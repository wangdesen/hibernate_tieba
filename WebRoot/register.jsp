<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户注册</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
    <style type="text/css">
    a:link{
    	text-decoration:none;
    }
    </style>
    <script type="text/javascript">
    function submitregister(){
    	$("#err").html("");
    	var username = $("#username").val();
    	var password = $("#password").val();
    	
    	if(username == ""){
    		$("#err").html("用户名不能为空");
    		return false;
    	} else if(password == ""){
    		$("#err").html("密码不能为空");
    		return false;
    	} 
    	
   		fm.action = "${pageContext.request.contextPath}/userAction_add";
   		fm.submit();
    }
    </script>
  </head>
  <body>
  	<fieldset style="width:250px;padding-left:40px;padding-top:20px;margin-top:10%;margin-left:40%;">
	    <legend>用户注册</legend>
	    <span style="font-size:14px;color:#ff0000;">${error}</span>
	    <s:form name="fm" action="" method="post" onsubmit="return submitregister()">
	    	<div id="err" style="font-size:14px;color:#ff0000;"></div>
	    	<table>
	    		<tr><td>用户名</td><td><s:textfield id="username" name="username" cssStyle="width:150px;"/></td></tr>
	    		<tr><td>密　码</td><td><s:password id="password" name="password" cssStyle="width:150px;"/></td></tr>
	    		<tr><td colspan="2" align="center"><s:submit value="注册"/><span style="font-size:14px;">&nbsp;请<a href="${pageContext.request.contextPath}/login.jsp">登录</a></span></td></tr>
	    	</table>
	    </s:form>
    </fieldset>
  </body>
</html>
