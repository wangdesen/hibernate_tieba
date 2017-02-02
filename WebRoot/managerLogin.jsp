<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'managerLogin.jsp' starting page</title>
  </head>
  
  <body>
  	<fieldset style="width:250px;padding-left:40px;padding-top:20px;margin-top:10%;margin-left:40%;">
	    <legend>管理员登录</legend>
	    <s:fielderror fieldName="error" cssStyle="font-size:14px;color:#ff0000;"/>
	    <s:form namespace="/" action="managerAction_login" method="post">
	    	<table>
	    		<tr>
	    			<td>用户名</td>
	    			<td>
	    				<s:textfield name="username" value="" cssStyle="width:150px;"/>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>密　码</td>
	    			<td>
	    				<s:password name="password" value="" cssStyle="width:150px;"/>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="center">
	    				<s:submit value="登录"/>
	    			</td>
	    		</tr>
	    	</table>
	    </s:form>
    </fieldset>
  </body>
</html>
