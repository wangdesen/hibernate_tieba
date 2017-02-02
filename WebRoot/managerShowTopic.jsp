<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title><s:property value="title"/>_专区</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css"> 
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript">
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
	
	<!--管理员登录 -->
	<div style="text-align:right;">
		<s:if test="#session.manager != null">
			管理员：<span style="color:#ff0000;text-align:right;"><s:property value="#session.manager.username"/></span>&nbsp;&nbsp;
			<s:a name="/" action="managerAction_logout" cssClass="color:#aaaaaa;font-size:14px;">[退出]</s:a>
		</s:if>
		<s:else>
			<div style="text-align:right;"><a href="${pageContext.request.contextPath}/managerLogin.jsp">管理员登录</a></div>
		</s:else>
	</div>
	
	<!-- 菜单 -->
	<div class="menubar">
		<s:a namespace="/" action="managerTopicAction_findAll?page_num=1">主题列表</s:a>
	</div>
	
	<!-- 当前主题贴数 -->
	<div style="padding: 10px 30px; font-size: 12px; font-family:'宋体'">
		回复贴：<font color="red"><s:property value="replies.size()"/></font>
	</div>
	<table>
	  
	
	</table>
	
	<!-- 显示主贴 -->
	<table class="postList" cellspacing="0">
	    <tr class="title">
	        <td width="25" class="num">楼主</td>
	        <td>
	        	<s:a namespace="/" action="managerTopicAction_findById" title="%{title}" cssStyle="font-weight:bold;font-size:16px;color:#000000;">
	        		<s:property value="title"/>
	        		<s:param name="id" value="id"/>
	        	</s:a>
			</td>
			<td>[<s:property value="state"/>]</td>
	    </tr>
	    <tr class="content">
	        <td></td>
	        <td>
	        	<pre>
	        		<s:property value="content"/>
	        	</pre>
	        </td>
	    </tr>
	    <tr class="info">
	        <td></td>
	        <td>
				作者：<font color="blue"><s:property value="author"/></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            <font color="#999999">1楼&nbsp;&nbsp;发贴时间：<s:date name="createDate" format="yyyy-MM-dd hh:mm:ss"/></font>
	        </td>
	        <td class="info">
			    <s:a namespace="/" action="managerTopicAction_checkTopic?topic_state=审核通过">
			        <s:param name="id" value="id"/>通过
			    </s:a>
			    <s:a namespace="/" action="managerTopicAction_checkTopic?topic_state=审核未通过">
			        <s:param name="id" value="id"/>拒绝
			    </s:a>
			</td>
	    </tr>
	    
	    <tr><td></td>
	    <td>
		  <s:a namespace="/" action="managerTopicAction_findById?reply_state=等待审核">
		    <s:param name="id" value="id"/>待审核
		  </s:a><font>&nbsp;&nbsp;</font>
		  <s:a namespace="/" action="managerTopicAction_findById?reply_state=审核通过">
		    <s:param name="id" value="id"/>已审核
		  </s:a><font>&nbsp;&nbsp;</font>
		  <s:a namespace="/" action="managerTopicAction_findById?reply_state=审核未通过">
		    <s:param name="id" value="id"/>未通过
		  </s:a>
		</td>
	  </tr>
	    
	    
	</table>
	
	<!-- 显示回复列表 -->
	<%int i=0; %>
	<s:iterator value="#replys" var="reply" status="status">
	<%i++; %>
		<table class="postList" cellspacing="0">
	        <tr class="title">
	            <td width="20" class="num">
	            	<s:property value="#status.index + 1"/>
	            </td>
	            <td>[<s:property value="#reply.state"/>]</td>
	        </tr>
	        <tr class="content">
	            <td></td>
	            <td>
	            	<pre>
	            		<s:property value="#reply.content"/>
	            	</pre>
	            </td>
	        </tr>
	        <tr class="info">
	            <td></td>
	            <td>
					作者：<font color="blue"><s:property value="#reply.author"/></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                <font color="#999999"><s:property value="#status.index + 2"/>楼&nbsp;&nbsp;回贴时间：<s:date name="#reply.replyDate" format="yyyy-MM-dd hh:mm:ss"/></font>&nbsp;&nbsp;
	            	<s:if test="#session.manager != null">
	            		<s:a namespace="/" action="replyAction_deleteById">
		            		<s:param name="id" value="#reply.id"/>删除
		            		<s:param name="topic.id" value="%{#reply.topic.id}"/>
            	 		</s:a>
            	 	</s:if>
	            </td>
	            <td class="info">
			      <s:a namespace="/" action="replyAction_checkReply?reply_state=审核通过">
			        <s:param name="topic.id" value="%{#reply.topic.id}"/>
			        <s:param name="id" value="#reply.id"/>通过
			      </s:a>
			      <s:a namespace="/" action="replyAction_checkReply?reply_state=审核未通过">
			        <s:param name="topic.id" value="%{#reply.topic.id}"/>
			        <s:param name="id" value="#reply.id"/>拒绝
			      </s:a>
			    </td>
			    <!--
	            <s:if test="#session.manager != null"> 
	            	<td><a id="reply<%=i %>" href="javascript:void(0);" onclick="reply(<%=i %>);" style="text-decoration:none;">回复</a></td>
	        	</s:if>
	        	-->
	        </tr>
	        <!-- 回复-回帖 -->
	        <tr id="replyArea<%=i %>" style="display:none;">
		    	<td colspan="2">
		    		<s:form namespace="/" action="replyAction_add" method="post" cssClass="addNewTopicForm">
		    			<s:hidden name="reply.id" value="%{id}"/>  
		    			<table>
		    			    <input type="hidden" name="author" value="${sessionScope.manager.username}"/>
				            <tr><td><s:textarea name="content" cssClass="content" value="" style="width:600px;height:50px;"/></td></tr>
				            <tr><td align="right"><s:submit value="回　复" style="background-color:#ff9224;color:#ffffff;border:0px;"/></td></tr>
		    			</table>
		    		</s:form>
		    	</td>
	    	</tr>
	    </table>
    </s:iterator>
    
    <!-- 返回“首页” -->
    <div style="margin-left:15px;margin-top:10px;">
    	<s:a namespace="/" action="managerTopicAction_findAll" cssStyle="text-decoration:none;font-size:13px;color:#0044bb;">&lt;&lt;返回首页</s:a>
    </div>
    
    <!-- 发表回复表单 -->
    <div style="margin-top: 20px">
		<span style="margin-left:15px;font-weight:bolder;">回复主贴</span>
		<s:form namespace="/" action="replyAction_managerAdd" method="post" cssClass="addNewTopicForm">
			<s:hidden name="topic.id" value="%{id}"/>
			<table class="publishArticleForm">
			    <s:if test="#session.manager.username != null">
			        <input type="hidden" name="author" value="${sessionScope.manager.username}"/>
		            <tr><td class="label">内　容:</td><td><s:textarea name="content" cssClass="content" value=""/></td></tr>
		            <tr><td></td><td><s:submit value="发　表"/></td></tr>
		        </s:if>
		        <s:else>
		            <tr><td class="label">内　容:</td><td><s:textarea name="content" cssClass="content" readonly="true" value=""/></td></tr>
		            <tr><td></td><td><s:submit value="发　表" disabled="true"/></td></tr>
		        </s:else>
		    </table>
		</s:form>
	</div>
</body>
</html>