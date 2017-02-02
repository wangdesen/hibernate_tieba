<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户登录贴吧</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
    
    <script type="text/javascript">
    $(function(){
    	$("#username").val("");
    	$("#password").val("");
    });
    
    function submitlogin(){
    	$("#err").html("");
    	var username = $("#username").val();
    	var password = $("#password").val();
    	var role = $("#role").val();
    	
    	if(username == ""){
    		$("#err").html("用户名不能为空");
    		return false;
    	} else if(password == ""){
    		$("#err").html("密码不能为空");
    		return false;
    	} else if(role == ""){
    		$("#err").html("请选择一个角色登录");
    		return false;
    	}
    	
    	if(role == "0"){//普通用户登录
    		fm.action = "${pageContext.request.contextPath}/userAction_login";
    		fm.submit();
    	} else{//管理员登录
    		fm.action = "${pageContext.request.contextPath}/managerAction_login";
    		fm.submit();
    	}
    }
    </script>
  </head>
  <body>
  	<fieldset style="width:250px;padding-left:40px;padding-top:20px;margin-top:10%;margin-left:40%;">
	    <legend>登录贴吧</legend>
	    <s:fielderror fieldName="error" cssStyle="font-size:14px;color:#ff0000;"/>
	    <s:form name="fm" action="" method="post" onsubmit="return submitlogin()">
	    	<div id="err" style="font-size:14px;color:#ff0000;"></div>
	    	<table>
	    		<tr><td>用户名</td><td><s:textfield id="username" name="username" value="" cssStyle="width:150px;"/></td></tr>
	    		<tr><td>密　码</td><td><s:password id="password" name="password" value="" cssStyle="width:150px;"/></td></tr>
	    		<tr><td>角　色</td><td><s:select id="role" name="role" list="#{'0':'普通用户','1':'管理员'}" listKey="key" listValue="value" headerKey="" headerValue="请选择" cssStyle="width:80px;"/></td></tr>
	    		<tr><td colspan="2" align="center"><s:submit value="登录"/></td></tr>
	    	</table>
	    </s:form>
    </fieldset>
  </body>
</html>
