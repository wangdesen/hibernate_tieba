<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>主题列表管理</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
	<style type="text/css">
	a:link{text-decoration:none;color:#0066ff;}
	a:hover{text-decoration:underline;}
	</style>
</head>
<body>
	<script type="text/javascript">
        function test(){
            var page = document.getElementById("page_id").value;
            var reg = /\d{3}/; //正则匹配
            if(page == ""){
            	alert("请输入页码");
            } else if(!reg.test(page)){
            	alert("数据非法");
            } else{
                window.location.href="topicAction_findAll?page_num="+page;
            }
        }
        function change1(){
            var obj1 = document.getElementById("button1");
            var obj2 = document.getElementById("button2");
            obj1.disabled = false;
            obj2.disabled = true;
        }
        function change2(){
            var obj1 = document.getElementById("button1");
            var obj2 = document.getElementById("button2");
            obj1.disabled = true;
            obj2.disabled = false;
        }
        function confirmmsg(){
            if (confirm("你确认要删除吗？")){
                return true;
            }
            else{
                return false;
            }  
        }
    </script>
	<!-- 标题 -->
	<div style="margin: 15px auto;" ><font class="logoLabel">C语言精品课程在线交流</font></div>
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
	<div class="menubar" style="padding-left:40px;">
		<span style="color:#ffffff;">贴子</span>
	</div>
	
	<!-- 选择待审核、已审核 -->
	<table><tr>
	    <!-- 判断待审核、已审核 -->
	    <td><button id="button1" type="button" onclick="change2();window.location='managerTopicAction_findTopicByState?page_num=1&topic_state=等待审核'">待审核</button></td>
	    <td><button id="button2" type="button" onclick="change1();window.location='managerTopicAction_findTopicByState?page_num=1&topic_state=审核通过'">已审核</button></td>
	    <td><button id="button3" type="button" onclick="window.location='managerTopicAction_findTopicByState?page_num=1&topic_state=审核未通过'">未通过</button></td>
	</tr></table>

	<!-- 主题列表 -->
	<table cellspacing="0">
		<tbody class="list topicList">
    		<!--显示表头-->
		    <tr class="title">
		        <td width="25">编号</td>
		        <td width="25">回复</td>
		        <td width="500">标题</td>
		        <td width="110">作者</td>
		        <td width="145">最后回复时间</td>
		        <td width="110">审核状态</td>
		    </tr>

    		<!-- 显示帖子列表 -->
    		<s:iterator value="#allTopic" var="topic" status="status">
		        <tr class="data">
		            <td class="num">
		            	<s:property value="#status.index + 1"/>
		            </td>
		            <td class="num">
		            	<s:property value="#topic.replies.size()"/>
		            </td>
		            <td>
		            	<s:a namespace="/" action="managerTopicAction_findById?reply_state=等待审核">
		            		<s:param name="id" value="#topic.id"/>
		            		<s:property value="#topic.title"/>
		            	</s:a>
		            </td>
		            <td class="info">
		            	<s:property value="#topic.author"/>
		            </td>
		            <td class="info">
		            	<s:date name="#topic.lastReplyDate" format="yyyy-MM-dd hh:mm:ss"/>
		            </td>
		            <td class="info">
		                <s:if test="#topic.state == '等待审核'">
		                    <FONT color="#008b8b"><s:property value="#topic.state"/></FONT>
		                </s:if>
		                <s:if test="#topic.state == '审核通过'">
		                    <FONT color="#7cfc00"><s:property value="#topic.state"/></FONT>
		                </s:if>
		                <s:if test="#topic.state == '审核未通过'">
		                    <FONT color="#ff0000"><s:property value="#topic.state"/></FONT>
		                </s:if>
		            	
		            </td>
		            <s:if test="#session.manager != null">
			            <td class="info">
			            	<s:a namespace="/" action="managerTopicAction_deleteById" onclick="javascript:return confirmmsg()">
			            	  <s:param name="id" value="#topic.id"/>删除
			            	</s:a>
			            </td>
		            </s:if>
		        </tr>
			</s:iterator>
		    <tr>
		        <td colspan="5" class="num">共有主题数<font color="red"><s:property value="#allTopic.size()"/></font>个</td>
		    </tr>
   		 </tbody>
	</table>
	<table>
	    <!-- 判断是否锁死"首页"和"上一页" -->
	    <s:if test="page_num == 1">
	        <td><button type="button" disabled="disabled">首页</button></td>
	        <td><button type="button" disabled="disabled">上一页</button></td>
   		</s:if>
   		<s:else>
   		    <td><button type="button" onclick="window.location='managerTopicAction_findAll?page_num=1'">首页</button></td>
			<td><button type="button" onclick="window.location='managerTopicAction_findAll?page_num=${page_num-1}'">上一页</button></td>
		</s:else>
		<td>当前第<s:property value="#session.page_num"/>页，共<s:property value="#session.total_page"/>页</td>
		<!-- 显示当前是第几页 -->
		<!-- 判断是否锁死"下一页"和"尾页" %{name == age}-->
		<s:if test="page_num == #session.total_page">
	        <td><button type="button" disabled="disabled">下一页</button></td>
		    <td><button type="button" disabled="disabled">尾页</button></td>
   		</s:if>
   		<s:else>
			<td><button type="button" onclick="window.location='managerTopicAction_findAll?page_num=${page_num+1}'">下一页</button></td>
		    <td><button type="button" onclick="window.location='managerTopicAction_findAll?page_num=${total_page}'">尾页</button></td>
		</s:else>
		<td><input type="text" name="page_text" id="page_id" style="width:30px;" value=""/></td>
		<td><button type="button" onclick="test()">确定</button></td>
		
	</table>
	<div style="margin-bottom: 15px"></div>

	<hr/>
	<!--发表主题表单-->
	<span style="margin-left:15px;font-weight:bolder;">发表新贴</span><br/><br/>
	<s:form namespace="/" action="managerTopicAction_add" method="post" cssClass="addNewTopicForm">
	    <table class="publishArticleForm">
	    <s:if test="#session.manager != null">
	        <input type="hidden" name="author" value="${sessionScope.manager.username}"/>
	        <tr><td>标　题:</td><td><s:textfield name="title" value="" cssClass="title"/></td></tr>
	        <tr><td>内　容:</td><td><s:textarea name="content" cssClass="content"/></td></tr>
	        <tr><td></td><td><s:submit value="发　表"/></td></tr>
	    </s:if>
	    <s:else>
	        <tr><td>标　题:</td><td><s:textfield name="title" value="" readonly="true" cssClass="title"/></td></tr>
	        <tr><td>内　容:</td><td><s:textarea name="content" readonly="true" cssClass="content"/></td></tr>
	        <tr><td></td><td><s:submit value="发　表" disabled="true"/>
	                     请先<a href="${pageContext.request.contextPath}/managerLogin.jsp">登录</a></td></tr>
	    </s:else>
	    </table>
	</s:form>
</body>
</html>
