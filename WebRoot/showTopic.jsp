<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title><s:property value="title"/>_专区</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
	<style> 
        .black_overlay{ 
            display: none; 
            position: fixed; 
            top: 0%; 
            left: 0%; 
            width: 100%;
            height: 100%;
            background-color: black; 
            z-index:1001; 
            -moz-opacity: 0.8; 
            opacity:.80; 
            filter: alpha(opacity=88); 
        } 
        .white_login { 
            display: none; 
            position: fixed; 
            top: 25%; 
            left: 38%; 
            width: 20%; 
            height: 35%; 
            padding: 20px; 
            border: 2px solid orange; 
            background-color: white; 
            z-index:1002; 
            overflow: auto; 
        }
        .white_content { 
            display: none; 
            position: fixed; 
            top: 25%; 
            left: 35%;
            width: 40%; 
            height: 50%;
            padding: 20px; 
            border: 2px solid orange; 
            background-color: Gainsboro; 
            z-index:1002; 
            overflow: auto; 
        }
    </style>
    
    <script type="text/javascript">
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
    
    function reply(num){
    	var reply = $("#reply"+num).text();
    	if(reply == "回复"){
    		$("#replyArea"+num).show(1000);
    		$("#reply"+num).text("收起回复");
    	} else{
    		$("#replyArea"+num).hide(1000);
    		$("#reply"+num).text("回复");
    	}
    }
    </script>
</head>
<body>
	<!-- 标题 -->
	<div style="margin: 15px auto; "><font class="logoLabel">C语言精品课程在线交流</font></div>
	
	<!-- 登录 -->
	<div style="text-align:right;">
		<s:if test="#session.user != null">
			当前登录：<span style="color:#ff0000;text-align:right;"><s:property value="#session.user.username"/></span>&nbsp;&nbsp;
			<s:a name="/" action="userAction_logout" cssClass="color:#aaaaaa;font-size:14px;">[退出]</s:a>
		</s:if>
		<s:else>
			<div style="text-align:right;">
			    <a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';
                document.getElementById('fade').style.display='block'">登录</a>
			</div>
		</s:else>
	</div>
	
	<!-- 菜单 -->
	<div class="menubar">
		<s:a namespace="/" action="topicAction_findAll?page_num=1">主题列表</s:a>
	</div>
	
	<!-- 当前主题贴数 -->
	<div style="padding: 10px 30px; font-size: 12px; font-family:'宋体'">
		回复贴：<font color="red"><s:property value="replies.size()"/></font>
	</div>
	
	<!-- 显示主贴-->
	<table class="postList" cellspacing="0">
	    <tr class="title">
	        <td width="25" class="num">楼主</td>
	        <td><s:a namespace="/" action="topicAction_findById" title="%{title}" cssStyle="font-weight:bold;font-size:16px;color:#000000;">
	        	<s:property value="title"/><s:param name="id" value="id"/></s:a>
			</td>
	    </tr>
	    <!-- 帖子内容 -->
	    <tr class="content">
	        <td></td>
	        <td><pre><s:property value="content"/></pre></td>
	    </tr>
	    <!-- 作者，楼层，发帖时间等信息，回复按钮 -->
	    <tr class="info">
	        <td></td>
	        <td>作者：<font color="blue"><s:property value="author"/></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            <font color="#999999">1楼&nbsp;&nbsp;发贴时间：<s:date name="createDate" format="yyyy-MM-dd hh:mm:ss"/></font>
	        </td>
	    </tr>
	</table>
	
	<!-- 显示回复列表 -->
	<%int i=0; %>
	<s:iterator value="replys" var="reply" status="status">
	<%i++; %>
		<table class="postList" cellspacing="0">
		    <!-- 打印排序 -->
	        <tr class="title"><td width="20" class="num"><s:property value="#status.index + 1"/></td><td></td></tr>
	        <!-- 回复内容 -->
	        <tr class="content"><td></td><td><pre><s:property value="#reply.content"/></pre></td></tr>
	        <!-- 作者，楼层，发帖时间等信息，回复按钮 -->
	        <tr class="info"><td></td>
	            <td>作者：<font color="blue"><s:property value="#reply.author"/></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                <font color="#999999"><s:property value="#status.index + 2"/>楼&nbsp;&nbsp;回贴时间：<s:date name="#reply.replyDate" format="yyyy-MM-dd hh:mm:ss"/></font>&nbsp;&nbsp;
	            </td>
	            <s:if test="#session.user != null"> 
	            	<td><a id="reply<%=i %>" href="javascript:void(0);" onclick="reply(<%=i %>);" style="text-decoration:none;">回复</a></td>
	        	</s:if>
	        	<s:else><!-- 如果当前没有用户登录，点击回复，跳转到登录页面 -->
		            <td>
		                <a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';
	                    document.getElementById('fade').style.display='block'">回复</a>
		            </td>
	        	</s:else>
	        </tr>
	        <!-- 回复-回帖 -->
	        <tr id="replyArea<%=i %>" style="display:none;">
		    	<td colspan="2">
		    	    <!-- 对回复者的回复：：： -->
		    		<s:form namespace="/" action="replyAction_add" method="post" cssClass="addNewTopicForm">
		    			<s:textarea name="topic.id" value="%{topic.id}"/>  
		    			<table>
		    			    <tr><td><input type="hidden" name="author" value="${sessionScope.user.username}"/></td></tr>
				            <tr><td><s:textarea name="content" cssClass="content" value="回复【%{#reply.author}】------'%{#reply.content}'/n" style="width:600px;height:50px;"/></td></tr>
				            <tr><td align="right"><s:submit value="回　复" style="background-color:#ff9224;color:#ffffff;border:0px;"/></td></tr>
		    			</table>
		    		</s:form>
		    	</td>
	    	</tr>
	    </table>
    </s:iterator>
     
    <!-- 返回“首页” -->
    <div style="margin-left:15px;margin-top:10px;">
    	<s:a namespace="/" action="topicAction_findAll?page_num=1" cssStyle="text-decoration:none;font-size:13px;color:#0044bb;">&lt;&lt;返回首页</s:a>
    </div>
	
	<!-- 发表回复表单 -->
	<div style="margin-top:20px;">
		<span style="margin-left:15px;font-weight:bolder;">回复主贴</span>
		<s:form namespace="/" action="replyAction_add" method="post" cssClass="addNewTopicForm">
			<s:hidden name="topic.id" value="%{id}"/>
			<table class="publishArticleForm">
			    <s:if test="#session.user != null">
			        <input type="hidden" name="author" value="${sessionScope.user.username}"/>
		            <tr><td class="label">内　容:</td><td><s:textarea name="content" cssClass="content" value=""/></td></tr>
		            <tr><td></td><td><s:submit value="发　表"/></td></tr>
		        </s:if>
		        <s:else>
		            <tr><td class="label">内　容:</td><td><s:textarea name="content" cssClass="content" readonly="true" value=""/></td></tr>
		            <tr><td></td><td><s:submit value="发　表" disabled="true"/>
		                                请先<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';
	                document.getElementById('fade').style.display='block'">登录</a></td></tr>
		        </s:else>
		    </table>
		</s:form>
	</div>
	<!-- 登录层div---------------------------- -->
	<div id="light" class="white_login"><a href = "javascript:void(0)" onclick = 
        "document.getElementById('light').style.display='none';
         document.getElementById('fade').style.display='none'">关闭</a>
         <fieldset style="width:220px;padding-left:40px;padding-top:20px;margin-top:10%;margin-left:0%;">
	    <legend>登录贴吧</legend>
	    <s:fielderror fieldName="error"/>
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
    </div>
         
         <!-- 黑色蒙层---------- -->
        <div id="fade" class="black_overlay"></div>
        
        <!-- 回复回帖者的弹出层div -->
        <!--  
        <div id="replay_div" class="white_content">
        <table>
        <tr>
         <td>参与/回复主题</td>
         <td style="text-align:right;"><a href = "javascript:void(0)" onclick = 
         "document.getElementById('replay_div').style.display='none';document.getElementById('fade').style.display='none'">关闭</a></td>
         </tr>
         <tr></tr><tr></tr>
         <tr class="title"><td>RE：<s:property value="title"/></td></tr>
	    <tr></tr><tr></tr>
	    <tr>
	        <td><s:property value="#session.replyer"/> 发表于</td>
	        <td><s:property value="#session.reply_time"/></td>
	    </tr>
	    <tr><td>.    <s:property value="#session.reply_content"/></td></tr>
	    </table>
	    <s:form namespace="/" action="replyAction_add" method="post" cssClass="addNewTopicForm">
		<s:hidden name="topic.id" value="%{id}"/>
		<table class="publishArticleForm">
		    <tr><td><input type="hidden" name="author" value="${sessionScope.user.username}"/></td></tr>
	        <tr><td><s:textarea name="content" cssClass="content" value=""/></td></tr>
	        <tr><td></td><td><s:submit value="发　表"/></td></tr>
	    </table>
	</s:form>
         </div>
        -->
</body>
</html>